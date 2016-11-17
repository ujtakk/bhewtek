local HashConvMM, parent = torch.class('nn.HashConvMM', 'nn.SpatialConvolutionMM')

function HashConvMM:__init(nInputPlane, nOutputPlane, kW, kH, dW, dH, padW, padH, config)
  parent.__init(self, nInputPlane, nOutputPlane, kW, kH, dW, dH, padW, padH)

  self:copyConfig(config)

  ------ Size Info
  self.size_in    = nInputPlane
  self.size_out   = nOutputPlane
  self.ker_width  = kW
  self.ker_height = kH
  self.stride_x   = dW or 1
  self.stride_y   = dH or 1
  self.padding_x  = padW or 0
  self.padding_y  = padH or 0
  self.size_w     = nInputPlane*nOutputPlane*kW*kH
  self.size_b     = nOutputPlane
  self.hsize_w    = math.ceil(self.size_w * self.config.compression)
  self.hsize_k    = math.ceil(self.ker_width*self.ker_height*self.config.compression)
  if self.config.hbias then
    self.hsize_b = math.ceil(self.size_b * self.config.compression)
  else
    self.hsize_b = self.size_b
  end

  -- Hashed Parameter & Gradient Preallocation
  self.h_weight        = torch.Tensor(self.hsize_w):zero()
  self.h_gradWeight    = torch.Tensor(self.hsize_w):zero()
  self.h_bias          = torch.Tensor(self.hsize_b):zero()
  self.h_gradBias      = torch.Tensor(self.hsize_b):zero()

  self.xxhash = require 'xxhash'

  self:HashConfig('W')
  if self.config.hbias then
    self:HashConfig('B')
  end
  self:hashReset()
end

function HashConvMM:hashReset(stdv)
  if stdv then
    stdv = stdv * math.sqrt(3)
  else
    stdv = 1./math.sqrt(self.size_in)
  end
  self.h_weight:uniform(-stdv, stdv)
  self.h_bias:uniform(-stdv, stdv)
end

function HashConvMM:hashFunc(hN, size_out, size_in, ker_width, ker_height, extra_str, lhmode)
  local Nall = size_out * size_in * ker_width * ker_height
  local idx = torch.FloatTensor(Nall, 1)
  local max = hN
  local min = 1
  local rep = 3
  local range = max - min + 1
  local count = 0
  local extra_str = extra_str or ''
  local key_i, key_j, key_k, key_l
  for i = 1, size_out do
    for j = 1, size_in do
      for k = 1, ker_width do
        for l = 1, ker_height do
          count, key_i, key_j, key_k, key_l = count+1, '', '', '', ''
          for r = 0,rep-1 do
            key_i = key_i .. tostring(i+r)
            key_j = key_j .. tostring(j+r)
            key_k = key_k .. tostring(k+r)
            key_l = key_l .. tostring(l+r)
          end
          key = key_i .. '_' .. key_j .. '_' .. key_k .. '_' .. key_l .. extra_str

	  if self.config.xorhash then
	     bit32 = require 'bit32'
	     if lhmode then
		idx[count] = (bit32.bxor(count, count*2)) % (range) + min + ((i-1)*size_in + (j-1)) * range
	     else
		idx[count] = (bit32.bxor(count, count*2)) % (range) + min
	     end
	  else
	     if lhmode then
		idx[count] = self.xxhash.xxh32(key, self.config.hashSeed) % (range) + min + ((i-1)*size_in + (j-1)) * range
	     else
		idx[count] = self.xxhash.xxh32(key, self.config.hashSeed) % (range) + min
	     end
          end
        end
      end
    end
  end
  return idx:cuda()
end


function HashConvMM:copyConfig(config)
  if type(config) ~= 'table' then
    error('The third argument \"config\" should be a table')
  end
  self.config               = {}
  self.config.compression   = config.compression
  self.config.xi            = config.xi
  self.config.hbias         = config.hbias
  self.config.hashSeed      = config.hashSeed or 1691
  self.config.rescale_grad  = config.rescale_grad
  self.config.verbose       = config.verbose
  self.config.cpu           = config.cpu or false
  self.config.lhconv        = config.lhconv
  self.config.xorhash       = config.xorhash
  if not self.config.compression then
    error('variable compression must be specified')
  end
  if self.config.cpu then error('only cuda is supported now!') end
  if self.config.verbose then
    if self.config.xi then print('Using xi auxiliary hash function') end
    if self.config.hbias then print('Hashing bias terms') end
  end
end

-- WorB is either W or B
function HashConvMM:HashConfig(WorB)
  local h_size, k_size, dim1, dim2, dim3, dim4
  if WorB == 'W' then
    h_size = self.hsize_w
    k_size = self.hsize_k
    dim1 = self.size_out
    dim2 = self.size_in
    dim3 = self.ker_width
    dim4 = self.ker_height
  elseif WorB == 'B' then
    h_size = self.hsize_b
    k_size = self.hsize_b
    dim1 = self.size_out
    dim2 = 1
    dim3 = 1
    dim4 = 1
  end

  -- make the index of weight matrix
  if self.config.lhconv and WorB == 'W' then
    self['idx' .. WorB] = self:hashFunc(k_size, dim1, dim2, dim3, dim4, 'idx' ..WorB, true):reshape(dim1, dim2*dim3*dim4)
  else
    self['idx' .. WorB] = self:hashFunc(h_size, dim1, dim2, dim3, dim4, 'idx' ..WorB, false):reshape(dim1, dim2*dim3*dim4)
  end
  if self.config.xi then
    -- redundant if statement.
    if self.config.lhconv then
      self['xi_' .. WorB] = self:hashFunc(2, dim1, dim2, dim3, dim4, 'xi_' .. WorB, false):reshape(dim1, dim2*dim3*dim4):mul(2):add(-3)
    else
      self['xi_' .. WorB] = self:hashFunc(2, dim1, dim2, dim3, dim4, 'xi_' .. WorB, false):reshape(dim1, dim2*dim3*dim4):mul(2):add(-3) -- convert to 1 or -1
    end
  end

  -- below this line: what these cuda func does ?
  --  => these functions are for computing grads.
  -- h_size: total number of hash values.

  -- Important! should be initialized with 0
  self['unique_idx' .. WorB] = torch.zeros(h_size, 1, 'torch.CudaTensor')
  --self['sort_val_' .. WorB] = torch.range(1, dim1*dim2, 'torch.FloatTensor'):reshape(dim1, dim2):cuda()
  --if self.config.lhconv then
  --  self['sort_val_' .. WorB] = torch.range(1, dim1*dim2*dim3*dim4, 'torch.FloatTensor'):reshape(dim1*dim2, dim3*dim4):cuda()
  --else
    self['sort_val_' .. WorB] = torch.range(1, dim1*dim2*dim3*dim4, 'torch.FloatTensor'):cuda()
  --end
  self['sort_key_' .. WorB] = self['idx' .. WorB]:clone()
  -- sort_key: equals to idx, contains hash index
  -- sort_val: contains range of idx
  -- sorts index by hash index ascendingly (may has overlap)
  libhashnn.mysort(self['sort_key_' .. WorB], self['sort_val_'.. WorB])


  ------ Compute occupancy for w
  self['occupancy_' .. WorB] = self['unique_idx' .. WorB]:clone()
  self['buffer_' .. WorB]  = self['occupancy_' .. WorB]:clone()

  local allones = self['sort_key_' .. WorB]:clone():fill(1)
  -- buffer: count of hitting hash index (corresponding to index)
  -- occupancy: count of hitting hash index (rearranged for convenience)
  libhashnn.myreduce(self['sort_key_' .. WorB], allones, self['unique_idx' .. WorB], self['occupancy_' .. WorB], self['buffer_' .. WorB])

end



------------------------------------------------------------
-- Remind:
--  Cuda operations are based on pointer operation.
--    => the shape of array is not concerned.
--    => must align values on our own.
------------------------------------------------------------


function HashConvMM:updateOutput(input)
  -- Reconstruct weight matrix and bias vector
  --
  -- h_weight:  (size_out, size_in, hsize_k)
  -- idxW:      (size_out, size_in, ker_width, ker_height)
  -- weight:    (size_out, size_in, ker_width, ker_height)
  --
  --  thrust::transform(myWind_data, myWind_data+fullsize, myW_data,
  --            myindex_functor(thrust::raw_pointer_cast(myWhash_data)));
  --    => W[i] = *(base_Whash + Wind[i] - 1);
  --    => W[i] = Whash[Wind[i]];
  --
  --    W[i, j, k, l] = W[i * (size_in*ker_width*ker_height) + j * (ker_width*ker_height) + k * ker_height + l]
  --
  libhashnn.myindexing(self.h_weight, self.idxW, self.weight);
  if self.config.hbias then
    libhashnn.myindexing(self.h_bias, self.idxB, self.bias);
  else
    self.bias:copy(self.h_bias)
  end
  if self.config.xi then
    self.weight:cmul(self.xi_W)
    if self.config.hbias then
      self.bias:cmul(self.xi_B)
    end
  end

  self.output = parent.updateOutput(self, input)
  return self.output
end



function HashConvMM:accGradParameters(input, gradOutput, scale)
  -- Reset gradients
  self.gradWeight:zero()
  self.gradBias:zero()

  parent.accGradParameters(self, input, gradOutput, scale)

  -- below is operated to accumulate grads for corrensponding hash index.

  --accumarray part
  if not self.gradWBuffer or not self.gradBBuffer then
    self.gradWBuffer = self.gradWeight:clone()
    if self.config.hbias then self.gradBBuffer = self.gradBias:clone()
    else self.gradBBuffer = "place_holder" end
  end

  if not self.idxW_buffer or not self.idxB_buffer then
    self.idxW_buffer = self.idxW:clone()
    if self.config.hbias then self.idxB_buffer = self.idxB:clone()
    else self.idxB_buffer = "place_holder" end
  end

  if self.config.xi then
    self.gradWeight:cmul(self.xi_W)
    if self.config.hbias then
      self.gradBias:cmul(self.xi_B)
    end
  end

  libhashnn.myindexing(self.gradWeight, self.sort_val_W, self.gradWBuffer)
  libhashnn.myreduce(self.sort_key_W,self.gradWBuffer,self.unique_idxW,self.h_gradWeight,self.buffer_W)
  if self.config.rescale_grad then
    self.h_gradWeight:cdiv(self.occupancy_W)
  end

  if self.config.hbias then
    libhashnn.myindexing(self.gradBias, self.sort_val_B, self.gradBBuffer)
    libhashnn.myreduce(self.sort_key_B,self.gradBBuffer,self.unique_idxB,self.h_gradBias,self.buffer_B)
    if self.config.rescale_grad then
      self.h_gradBias:cdiv(self.occupancy_B)
    end
  else
    self.h_gradBias:copy(self.gradBias)
  end

end





function HashConvMM:parameters()
  return {self.h_weight, self.h_bias}, {self.h_gradWeight, self.h_gradBias}
end
