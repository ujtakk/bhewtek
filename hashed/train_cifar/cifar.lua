-- reference: torch/demos/train-on-cifar/train-on-cifar.lua

local torch = require 'torch'
require 'paths'

local cifar = {}

----------------------------------------------------------------------
-- get/create dataset
--
local trsize = 50000
local tesize = 10000

-- download dataset
if not paths.dirp('cifar-10-batches-t7') then
   local www = 'http://torch7.s3-website-us-east-1.amazonaws.com/data/cifar-10-torch.tar.gz'
   local tar = paths.basename(www)
   os.execute('wget ' .. www .. '; '.. 'tar xvf ' .. tar)
end

-- local function preprocess(data, x_mean, x_std, is_train)
--   data = 
-- end

-- load dataset
function cifar.traindataset()
  trainData = {
     data = torch.Tensor(50000, 3072),
     label = torch.Tensor(50000),
     size = function() return trsize end
  }

  for i = 0, 4 do
     subset = torch.load('cifar-10-batches-t7/data_batch_' .. (i+1) .. '.t7', 'ascii')
     trainData.data[{ {i*10000+1, (i+1)*10000} }] = subset.data:t()
     trainData.label[{ {i*10000+1, (i+1)*10000} }] = subset.labels
  end

  return trainData
end

function cifar.testdataset()
  subset = torch.load('cifar-10-batches-t7/test_batch.t7', 'ascii')

  testData = {
     data = subset.data:t():double(),
     label = subset.labels[1]:double(),
     size = function() return tesize end
  }

  return testData
end

-- local function preprocess_cifar()
--   print '<trainer> preprocessing data (color space + normalization)'
--   collectgarbage()
--
--   -- preprocess trainSet
--   normalization = nn.SpatialContrastiveNormalization(1, image.gaussian1D(7))
--   for i = 1,trainData:size() do
--      -- rgb -> yuv
--      local rgb = trainData.data[i]
--      local yuv = image.rgb2yuv(rgb)
--      -- normalize y locally:
--      yuv[1] = normalization(yuv[{{1}}])
--      trainData.data[i] = yuv
--   end
--   -- normalize u globally:
--   mean_u = trainData.data[{ {},2,{},{} }]:mean()
--   std_u = trainData.data[{ {},2,{},{} }]:std()
--   trainData.data[{ {},2,{},{} }]:add(-mean_u)
--   trainData.data[{ {},2,{},{} }]:div(-std_u)
--   -- normalize v globally:
--   mean_v = trainData.data[{ {},3,{},{} }]:mean()
--   std_v = trainData.data[{ {},3,{},{} }]:std()
--   trainData.data[{ {},3,{},{} }]:add(-mean_v)
--   trainData.data[{ {},3,{},{} }]:div(-std_v)
--
--   -- preprocess testSet
--   for i = 1,testData:size() do
--      -- rgb -> yuv
--      local rgb = testData.data[i]
--      local yuv = image.rgb2yuv(rgb)
--      -- normalize y locally:
--      yuv[{1}] = normalization(yuv[{{1}}])
--      testData.data[i] = yuv
--   end
--   -- normalize u globally:
--   testData.data[{ {},2,{},{} }]:add(-mean_u)
--   testData.data[{ {},2,{},{} }]:div(-std_u)
--   -- normalize v globally:
--   testData.data[{ {},3,{},{} }]:add(-mean_v)
--   testData.data[{ {},3,{},{} }]:div(-std_v)
-- end

return cifar
