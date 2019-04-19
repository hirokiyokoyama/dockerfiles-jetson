FROM balenalib/aarch64-ubuntu-python:3.6-bionic

#FROM ubuntu:bionic AS base
#ENV DEBIAN_FRONTEND noninteractive
#ENV LANG en_US.UTF-8

LABEL maintainer "hirokiyokoyama <h-yokoyama@craft-server.co.jp>"

#FROM python:3.6
#COPY --from=base . .

RUN apt-get update && apt-get install -y -o Dpkg::Options::="--force-confnew" \
    libhdf5-dev build-essential \
    && rm -rf /var/lib/apt/lists/* 

RUN ln -s /usr/include/hdf5/serial/*.h /usr/local/include \
    && ln -s /usr/lib/aarch64-linux-gnu/hdf5/serial/* /usr/local/lib \
    #&& ln -s /usr/lib/aarch64-linux-gnu/hdf5/serial/libhdf5.a /usr/local/lib \
    #&& ln -s /usr/lib/aarch64-linux-gnu/hdf5/serial/libhdf5_hl.a /usr/local/lib \
    && pip3 install h5py 
    #&& rm /usr/local/lib/libhdf5.a /usr/local/lib/libhdf5_hl.a
RUN pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu

RUN pip3 install --no-cache-dir --upgrade \
    # pyzmq==17.0.0 \
    jupyter jupyterlab

RUN mkdir /data
CMD jupyter lab --port=8888 --ip=0.0.0.0 --notebook-dir=/data --no-browser --allow-root

