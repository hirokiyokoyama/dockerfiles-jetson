FROM hirokiyokoyama/tensorflow-jp42:py3.6-tf1.13.1

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list

RUN apt-get update && apt-get install \
    -o Dpkg::Options::="--force-confnew" --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    ros-melodic-ros-base \
    build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && rosdep init

# to resolve *.local hostname
RUN apt-get update && apt-get install --no-install-recommends -y \
    avahi-daemon \
    libnss-mdns \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i -e 's/#enable-dbus=yes/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf 

RUN mkdir -p /catkin_ws/src && cd /catkin_ws/src \
    && . /opt/ros/melodic/setup.sh && catkin_init_workspace \
    && cd .. && catkin_make
#RUN apt-get update && apt-get install -y \
#    python-catkin-tools \
#    && rm -rf /var/lib/apt/lists/*
#RUN mkdir catkin_ws
WORKDIR /catkin_ws
#RUN catkin init \
#    && catkin config -DPYTHON_EXECUTABLE=/usr/bin/python3 \
#                     -DPYTHON_INCLUDE_DIR=/usr/include/python3.6m \
#                     -DPYTHON_LIBRARY=/usr/lib/aarch64-linux-gnu/libpython3.6m.so
#RUN git clone https://github.com/ros-perception/vision_opencv.git src/vision_opencv \
#    && cd src/vision_opencv && git checkout 1.13.0
#RUN catkin build cv_bridge
ADD ./devel.tar.gz .

WORKDIR /catkin_ws/src
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

