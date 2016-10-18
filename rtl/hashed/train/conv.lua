
require 'optim'
require 'nn'
require 'cunn'

------------------------------------------------------------------------
--                Parser                                              --
------------------------------------------------------------------------
local function commandLine()
  local cmd = torch.CmdLine()

  cmd:text()
  cmd:text('Options:')
  cmd:option('-seed', 222, 'fixed input seed for repeatable experiments')
  cmd:option('-validate', .2, 'Specify size of validation set (empty by default by)')
  cmd:option('-nhLayers', 1, 'total number of hidden layers, excluding input and output layers')
  cmd:option('-nhu', 500, 'number of hidden units')
  cmd:option('-ncLayers', 2, 'total number of conv layers, excluding input and output layers')
  cmd:option('-hash', false, 'enable hashing')
  cmd:option('-compression', 0.2, 'compression rate')
  cmd:option('-hash_bias', true, 'Specify whether or not to hash bias terms')
  cmd:option('-rescale_grad', false, 'Specify whether or not divide gradients by the frequency it is used')
  cmd:option('-learningRate', 5, 'learning rate at t=0')
  cmd:option('-decay_lr', 1e-4, 'learning rate decay')
  cmd:option('-batchSize', 50, 'mini-batch size (1 = pure stochastic)')
  cmd:option('-momentum', 0.9, 'momentum (SGD only)')
  cmd:option('-dropout', 0.25,  'specify dropout rate')
  cmd:option('-l2reg', 0, 'l2 regularization')
  cmd:option('-maxEpoch', 1000, 'maximum # of epochs to train for')
  cmd:option('-xi', true, 'Specify whether or not to use auxiliary hash function Xi')
  cmd:option('-hashSeed', 1691, 'seed for hash functions')
  cmd:option('-shuffle', true, 'shuffle training data')
  cmd:option('-lhconv', false, 'setting conv mode when hash is enabled')

  cmd:text()

  local opt = cmd:parse(arg or {})

  torch.manualSeed(opt.seed)
  return opt
end


------------------------------------------------------------------------
--               Data Loader              --
------------------------------------------------------------------------

local function load_data(opt)
  local mnist   = require 'mnist'
  local trainData = mnist.traindataset()
  local testData  = mnist.testdataset()
  local data    = {}
  data['xr']    = trainData.data:float()
  data['xe']    = testData.data:float()
  data['yr']    = trainData.label + 1
  data['ye']    = testData.label + 1
  opt.outputDim   = 10
  opt.inputDim  = 784

  -- shuffle the training data
  local shuffle_idx = torch.randperm(data.xr:size(1),'torch.LongTensor')
  data.xr       = data.xr:index(1,shuffle_idx)
  data.yr       = data.yr:index(1,shuffle_idx)

  -- normalization
  local xMax = data.xr:max()
  data.xr:div(xMax)
  data.xe:div(xMax)

  -- validation set
  local nValid = math.floor(data.xr:size(1) * opt.validate)
  local nTrain = data.xr:size(1) - nValid
  data['xv']   = data.xr:sub(nTrain+1,data.xr:size(1))
  data['yv']   = data.yr:sub(nTrain+1,data.xr:size(1))
  data['xr']   = data.xr:sub(1,nTrain)
  data['yr']   = data.yr:sub(1,nTrain)

  return data
end

------------------------------------------------------------------------
--               Configuration              --
------------------------------------------------------------------------

local function adjust(opt, nTrain)
  ------ Learning Rate Adjustment
  opt.learningRate = opt.learningRate / opt.batchSize
  opt.nBatches   = math.ceil(nTrain/opt.batchSize)
  --opt.decay_lr   = opt.decay_lr / opt.nBatches
  opt.decay_lr   = opt.decay_lr
end


local function optimConfig(opt)
  opt.optim_config = {
    learningRate      = opt.learningRate,
    learningRateDecay   = opt.decay_lr,
    weightDecay       = opt.l2reg,
    momentum        = opt.momentum
  }
  opt.optimizer = optim.sgd
end

local function hashConfig(opt)
  local hash_config = {
    compression   = opt.compression,
    xi            = opt.xi,
    hbias         = opt.hash_bias,
    hashSeed      = opt.hashSeed,
    rescale_grad  = opt.rescale_grad,
    lhconv        = opt.lhconv
  }
  return hash_config

end

local function createModel(opt)
  local prev = opt.inputDim
  local hash_config = nil
  if opt.hash then
    hash_config = hashConfig(opt)
    require 'HashLinear'
    require 'HashConvMM'
    require 'libhashnn'
  end

  local function linear_module(inSize, outSize)
    local linear = nil
    if hash_config then
      linear = nn.HashLinear(inSize, outSize, hash_config)
    else
      linear = nn.Linear(inSize, outSize)
    end
    return linear
  end

  local function conv_module(inSize, outSize, kerHeight, kerWidth)
    local conv = nil
    if hash_config then
      conv = nn.HashConvMM(inSize, outSize, kerHeight, kerWidth, 1, 1, 0, 0, hash_config)
    else
      conv = nn.SpatialConvolutionMM(inSize, outSize, kerHeight, kerWidth)
    end
    return conv
  end

  local dcLayers = {1, 20, 50}
  local kerSize = 5
  local poolSize = 2
  local image_size = 28
  -- model
  local model = nn.Sequential()
  model:add(nn.Reshape(1, 28, 28))
  model:add(nn.Dropout(opt.dropout))
  for l = 1, opt.ncLayers do
    model:add(conv_module(dcLayers[l], dcLayers[l+1], kerSize, kerSize))
    model:add(nn.ReLU())
    model:add(nn.Dropout(opt.dropout))
    model:add(nn.SpatialMaxPooling(poolSize, poolSize))
    image_size = (image_size - kerSize + 1)/poolSize;
    prev = dcLayers[l+1]*image_size*image_size;
  end
  model:add(nn.View(prev))
  for l = 1, opt.nhLayers do
    model:add(linear_module(prev, opt.nhu))
    model:add(nn.ReLU())
    model:add(nn.Dropout(opt.dropout))
    prev = opt.nhu
  end
  model:add(linear_module(prev, opt.outputDim))
  model:add(nn.LogSoftMax())

  -- write hash index to files
  if hash_config then
     path = 'data/idx'
     os.execute('mkdir -p ' .. path)
     conv_nodes = model:findModules('nn.HashConvMM')
     for l = 1, #conv_nodes do
  idx = conv_nodes[l].idxW:reshape(conv_nodes[l].size_out, conv_nodes[l].size_in, kerSize*kerSize)
  if hash_config.xi then
     xi = conv_nodes[l].xi_W:reshape(conv_nodes[l].size_out, conv_nodes[l].size_in, kerSize*kerSize)
  end
  for i = 1, idx:size()[1] do
     for j = 1, idx:size()[2] do
        f = io.open(path..'/conv'..l..'_idxW_'..i..'_'..j..'.txt', 'w')
        if hash_config.xi then
     f_xi = io.open(path..'/conv'..l..'_xi_W_'..i..'_'..j..'.txt', 'w')
        end
        for k = 1, kerSize*kerSize do
     f:write(idx[i][j][k] .. '\n')
     if hash_config.xi then
        f_xi:write(xi[i][j][k] .. '\n')
     end
        end
        f:close()
        if hash_config.xi then
     f_xi:close()
        end
     end
  end
  idx = conv_nodes[l].idxB
  if hash_config.xi then
     xi = conv_nodes[l].xi_B
  end
  f = io.open(path..'/conv'..l..'_idxB.txt', 'w')
  if hash_config.xi then
     f_xi = io.open(path..'/conv'..l..'_xi_B.txt', 'w')
  end
  for i = 1, idx:nElement() do
     f:write(idx[i][1] .. '\n')
     if hash_config.xi then
        f_xi:write(xi[i][1] .. '\n')
     end
  end
  f:close()
  if hash_config.xi then
     f_xi:close()
  end
     end
     lin_nodes = model:findModules('nn.HashLinear')
     for l = 1, #lin_nodes do
  idx = lin_nodes[l].idxW
  if hash_config.xi then
     xi = lin_nodes[l].xi_W
  end
  for i = 1, idx:size()[1] do
     f = io.open(path..'/lin'..l..'_idxW_'..i..'.txt', 'w')
     if hash_config.xi then
        f_xi = io.open(path..'/lin'..l..'_xi_W_'..i..'.txt', 'w')
     end
     for j = 1, idx:size()[2] do
        f:write(idx[i][j] .. '\n')
        if hash_config.xi then
     f_xi:write(xi[i][j] .. '\n')
        end
     end
     f:close()
     if hash_config.xi then
        f_xi:close()
     end
  end
  idx = lin_nodes[l].idxB
  if hash_config.xi then
     xi = lin_nodes[l].xi_B
  end
  f = io.open(path..'/lin'..l..'_idxB.txt', 'w')
  if hash_config.xi then
     f_xi = io.open(path..'/lin'..l..'_xi_B.txt', 'w')
  end
  for i = 1, idx:nElement() do
     f:write(idx[i][1] .. '\n')
     if hash_config.xi then
        f_xi:write(xi[i][1] .. '\n')
     end
  end
  f:close()
  if hash_config.xi then
     f_xi:close()
  end
     end
  end

  -- loss function
  local criterion   = nn.ClassNLLCriterion()

  -- transfer to cuda
  print(model)
  print(criterion)
  model:cuda()
  criterion:cuda()
  return model, criterion
end


------------------------------------------------------------------------
--               Training                 --
------------------------------------------------------------------------

local function train(model, criterion, W, grad, data, opt)
  model:training() -- for dropout


  local inputs_gpu = torch.CudaTensor()
  local targets_gpu = torch.CudaTensor()
  local nTrain = data.xr:size(1)

  -- shuffle the data
  if opt.shuffle then
    local shuffle_idx = torch.randperm(nTrain,'torch.LongTensor')
    data.xr       = data.xr:index(1,shuffle_idx)
    data.yr       = data.yr:index(1,shuffle_idx)
  end

  -- Train minibatch
  for t = 1, nTrain, opt.batchSize do
    ------ Minibatch generation
    local idx   = math.min(t+opt.batchSize-1, nTrain)
    local inputs  = data.xr:sub(t,idx)
    local targets = data.yr:sub(t,idx)

    -- copy data from cpu to gpu
    inputs_gpu:resize(inputs:size()):copy(inputs)
    targets_gpu:resize(targets:size()):copy(targets)

    -- objective function for optimization
    function feval(x)
      assert(x == W)
      grad:zero() -- reset grads

      local outputs  = model:forward(inputs_gpu)
      local f    = criterion:forward(outputs, targets_gpu)
      local df_dw  = criterion:backward(outputs, targets_gpu) -- ~= df/dW
      model:backward(inputs_gpu, df_dw)

      f = f/opt.batchSize -- Adjust for batch size

      return f,grad
    end
    opt.optimizer(feval, W, opt.optim_config)
  end

end


------------------------------------------------------------------------
--               Evaluation               --
------------------------------------------------------------------------
local function evaluation(suffix, data, model, batchSize, confusion)

  if suffix ~= 'r' and suffix ~= 'e' and suffix ~= 'v' then
    error('Unrecognized dataset specified')
  end

  model:evaluate()

  local N   = data['x' .. suffix]:size(1)
  local err   = 0

  local inputs_gpu = torch.CudaTensor()
  local targets_gpu = torch.CudaTensor()
  for k = 1, N, batchSize do
    local idx     = math.min(k+batchSize-1,N)
    local inputs    = data['x' .. suffix]:sub(k,idx)
    local targets   = data['y' .. suffix]:sub(k,idx)

    -- copy data from cpu to gpu
    inputs_gpu:resize(inputs:size()):copy(inputs)
    targets_gpu:resize(targets:size()):copy(targets)

    local outputs   = model:forward(inputs_gpu)
    --print(outputs)
    --print(targets_gpu)
    confusion:batchAdd(outputs, targets_gpu)
  end

  confusion:updateValids()
  err  = 1 - confusion.totalValid
  confusion:zero()

  return err
end

local function reportErr(data, model, opt, confusion)
  local bestValid = math.huge
  local bestTest  = math.huge
  local bestTrain = math.huge
  local bestEpoch = math.huge
  local function report(t)
    local err_e = evaluation('e', data, model, opt.batchSize, confusion)
    local err_v = evaluation('v', data, model, opt.batchSize, confusion)
    local err_r = evaluation('r', data, model, opt.batchSize, confusion)
    print('---------------Epoch: ' .. t .. ' of ' .. opt.maxEpoch)
    print(string.format('Current Accuracy: test: %.4f | valid: %.4f | train: %.4f',
          (1-err_e)*100, (1-err_v)*100, (1-err_r)*100))
    if bestValid > err_v then
      -- Model that achieves the best validation error is considered the
      -- best model
      bestValid = err_v
      bestTrain = err_r
      bestTest = err_e
      bestEpoch = t
    end
    print(string.format('Optima achieved at epoch %d: test: %.4f, valid: %.4f',
        bestEpoch, (1-bestTest)*100, (1-bestValid)*100))
  end

  return report
end

local function writeParams(model, opt)

  if opt.hash then
    conv_nodes = model:findModules('nn.HashConvMM')
    lin_nodes = model:findModules('nn.HashLinear')

    -- write hash table
    path = 'data/hash'
    os.execute('mkdir -p ' .. path)
    for l = 1, #conv_nodes do
      hash = conv_nodes[l].h_weight
      f = io.open(path..'/conv'..l..'_hashW.txt', 'w')
      for i = 1, hash:size()[1] do
        f:write(hash[i] .. '\n')
      end
      f:close()
      hash = conv_nodes[l].h_bias
      f = io.open(path..'/conv'..l..'_hashB.txt', 'w')
      for i = 1, hash:size()[1] do
        f:write(hash[i] .. '\n')
      end
      f:close()
        end
        for l = 1, #lin_nodes do
      hash = lin_nodes[l].h_weight
      f = io.open(path..'/lin'..l..'_hashW.txt', 'w')
      for i = 1, hash:size()[1] do
        f:write(hash[i] .. '\n')
      end
      f:close()
      hash = lin_nodes[l].h_bias
      f = io.open(path..'/lin'..l..'_hashB.txt', 'w')
      for i = 1, hash:size()[1] do
        f:write(hash[i] .. '\n')
      end
      f:close()
    end

  else -- without hash
    conv_nodes = model:findModules('nn.SpatialConvolutionMM')
    lin_nodes = model:findModules('nn.Linear')
  end

  -- write uncompressed weights
  for l = 1, #conv_nodes do
    path = 'data/wb_'..l
    os.execute('mkdir -p ' .. path)
    kerSize = conv_nodes[l].kW
    W = conv_nodes[l].weight:reshape(conv_nodes[l].nOutputPlane, conv_nodes[l].nInputPlane, kerSize*kerSize)
    B = conv_nodes[l].bias
    for i = 1, W:size()[1] do
      if l == 1 then
        f = io.open(path..'/data'..(i-1)..'.txt', 'w')
        for k = 1, kerSize*kerSize do
          f:write(W[i][1][k] .. '\n')
        end
        f:write(B[i] .. '\n')
        f:close()
      else
        for j = 1, W:size()[2] do
          f = io.open(path..'/data'..(i-1)..'_'..(j-1)..'.txt', 'w')
          for k = 1, kerSize*kerSize do
            f:write(W[i][j][k] .. '\n')
          end
          f:close()
        end
        -- bias
        f = io.open(path..'/data'..(i-1)..'.txt', 'w')
        f:write(B[i] .. '\n')
        f:close()
      end
    end
  end
  for l = 1, #lin_nodes do
    path = 'data/wb_'..(#conv_nodes+l)
    os.execute('mkdir -p ' .. path)
    W = lin_nodes[l].weight
    B = lin_nodes[l].bias
    for i = 1, W:size()[1] do
      f = io.open(path..'/data'..(i-1)..'.txt', 'w')
      for j = 1, W:size()[2] do
        f:write(W[i][j] .. '\n')
      end
      f:write(B[i] .. '\n')
      f:close()
    end
  end

  collectgarbage()
end


------------------------------------------------------------------------
--              Main Function               --
------------------------------------------------------------------------

local function main()
  local opt = commandLine()
  torch.setdefaulttensortype('torch.FloatTensor')
  local data = load_data(opt)

  local nTrain = data.xr:size(1)
  adjust(opt, nTrain)
  optimConfig(opt)
  local model, criterion = createModel(opt)

  local confusion = optim.ConfusionMatrix(opt.outputDim)
  local W, grad   = model:getParameters()

  print('the number of paramters is ' .. W:nElement())

  local report = reportErr(data, model, opt, confusion)

  for t = 1, opt.maxEpoch do

    ------------ Training Call
    train(model, criterion, W, grad, data, opt) -- performs a single epoch

    ------------ Report Errors
    report(t)

    writeParams(model, opt)

    collectgarbage()
  end
end

main()



