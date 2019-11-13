FROM balenalib/aarch64-ubuntu-python:3.6-bionic AS base
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

RUN apt-get update

# setup bazel
RUN apt-get install -y build-essential openjdk-8-jdk zip unzip
ENV EXTRA_BAZEL_ARGS --host_javabase=@local_jdk//:jdk
RUN apt-get install -y wget
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.26.1/bazel-0.26.1-dist.zip
RUN unzip bazel-0.26.1-dist.zip -d bazel
WORKDIR /bazel
RUN bash compile.sh
RUN cp output/bazel /usr/local/bin

# setup tensorflow
RUN apt-get install -y libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev libjpeg8-dev
RUN pip3 install -U pip
RUN pip3 install -U wheel
RUN apt-get install -y git
RUN cd / && git clone https://github.com/tensorflow/tensorflow.git -b v2.0.0-rc0
ADD cuda /usr/local/cuda
RUN pip3 install numpy
ENV TMP /tmp
RUN pip3 install keras_preprocessing
WORKDIR /tensorflow
Add .tf_configure.bazelrc /tensorflow
RUN bazel build --config=opt --config=cuda --config=nonccl --config=v2 --local_resources 8192,8,1.0 //tensorflow/tools/pip_package:build_pip_package
RUN ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tensorflow_pkg
RUN cd /usr/lib/aarch64-linux-gnu && ln -s libhdf5_serial.so libhdf5.so && ln -s libhdf5_serial_hl.so libhdf5_hl.so
RUN apt-get install -y pkg-config
RUN pip3 wheel --wheel-dir /tensorflow_pkg /tensorflow_pkg/tensorflow-2.0.0rc0-cp36-cp36m-linux_aarch64.whl
RUN pip3 wheel --wheel-dir /jupyter_pkg jupyter jupyterlab

FROM balenalib/aarch64-ubuntu-python:3.6-bionic
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

COPY --from=base /tensorflow_pkg /tensorflow_pkg
RUN pip3 install --find-link /tensorflow_pkg /tensorflow_pkg/tensorflow-2.0.0rc0-cp36-cp36m-linux_aarch64.whl
RUN rm -rf /tensorflow_pkg

COPY --from=base /jupyter_pkg /jupyter_pkg
RUN pip3 install --find-link /jupyter_pkg jupyter jupyterlab
RUN rm -rf /jupyter_pkg
RUN mkdir /data
CMD jupyter lab --port=8888 --ip=0.0.0.0 --notebook-dir=/data --no-browser --allow-root

