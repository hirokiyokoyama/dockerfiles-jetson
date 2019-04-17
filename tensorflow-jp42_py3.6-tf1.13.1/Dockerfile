FROM hirokiyokoyama/tensorflow-jp42:py3.6-tf1.13.1
LABEL maintainer "hirokiyokoyama <h-yokoyama@craft-server.co.jp>"

RUN pip3 install --upgrade pip \
    && pip3 install --no-cache-dir --upgrade \
    # pyzmq==17.0.0 \
    jupyter jupyterlab

RUN mkdir /data
CMD jupyter lab --port=8888 --ip=0.0.0.0 --notebook-dir=/data --no-browser --allow-root

