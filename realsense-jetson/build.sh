#!/bin/bash

docker build -t realsense-jetson-tmp1 -f Dockerfile.1 .
docker run -v /usr/local/cuda:/usr/local/cuda --name realsense-jetson-tmp1-container realsense-jetson-tmp1
docker commit realsense-jetson-tmp1-container realsense-jetson-tmp2
docker rm realsense-jetson-tmp1-container
docker build -t realsense-jetson -f Dockerfile.2 .

