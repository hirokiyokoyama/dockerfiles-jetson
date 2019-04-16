FROM python:3.6
LABEL maintainer "hirokiyokoyama <h-yokoyama@craft-server.co.jp>"

RUN apt-get update && apt-get install -y \
    libhdf5-dev libhdf5-serial-dev \
    && rm -rf /var/lib/apt/lists/* 

RUN pip3 install --upgrade pip \
    && pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu

CMD python3

