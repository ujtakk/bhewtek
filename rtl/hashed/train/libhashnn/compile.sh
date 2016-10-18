#! /bin/bash

buildDir="_build"

if [ ! -d "$buildDir" ]; then
  mkdir ${buildDir}
fi
cd ${buildDir}

# replace with cmake -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-7.0 .. if your
# cuda is not 7.0
cmake -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-7.0 ..

make

cp libhashnn.so ../../




