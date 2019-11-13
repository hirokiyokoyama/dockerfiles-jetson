#!/bin/bash

cp -r `readlink -f /usr/local/cuda` ./cuda
cp /usr/lib/aarch64-linux-gnu/tegra/libcuda.so* ./cuda/lib64/
cp /usr/lib/aarch64-linux-gnu/libcudnn.so.7* ./cuda/lib64/
#cp /usr/include/aarch64-linux-gnu/cudnn_v7.h ./cuda/include/cudnn.h
cp /usr/include/cudnn.h ./cuda/include
docker build -t tensorflow-jp42:py3.6-tf2.0.0 .
rm -rf ./cuda

