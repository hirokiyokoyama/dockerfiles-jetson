FROM ubuntu:xenial
LABEL maintainer "hirokiyokoyama <h-yokoyama@craft-server.co.jp>"

RUN apt-get update && apt-get install -y \
    udev git software-properties-common \
    libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev \
    libglfw3-dev qtcreator cmake-curses-gui \
    && rm -rf /var/lib/apt/lists/*

#RUN apt-get update && apt-get install -y --install-recommends \
#    linux-generic-lts-xenial xserver-xorg-core-lts-xenial xserver-xorg-lts-xenial xserver-xorg-video-all-lts-xenial xserver-xorg-input-all-lts-xenial libwayland-egl1-mesa-lts-xenial \
#    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/jetsonhacks/buildLibrealsense2TX.git \
    && cd buildLibrealsense2TX && ./installLibrealsense.sh

# librealsense
#RUN git clone https://github.com/IntelRealSense/librealsense.git \
#    && cd librealsense && ./scripts/setup_udev_rules.sh
    #&& sed -i -e 's/sudo//g' scripts/install_qt.sh

#RUN /librealsense/scripts/install_qt.sh 
#RUN cp /librealsense/config/99-realsense-libusb.rules /etc/udev/rules.d/ \
#    && udevadm control --reload-rules && udevadm trigger

#RUN cd /librealsense && mkdir build && cd build \
#    && cmake ../ -DBUILD_EXAMPLES=true \
#    && make && make install

# ROS
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list

RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    ros-kinetic-ros-core \
    && rm -rf /var/lib/apt/lists/* \
    && rosdep init

RUN mkdir -p /catkin_ws/src && cd /catkin_ws/src && \
    . /opt/ros/kinetic/setup.sh && catkin_init_workspace && \
    cd .. && catkin_make

# realsense2_camera
RUN cd /catkin_ws/src && git clone https://github.com/intel-ros/realsense.git \
    && cd realsense && git checkout 2.2.3 
RUN apt-get update && rosdep update \
    && apt-get install -y ros-kinetic-librealsense \
    && cd /catkin_ws && rosdep -y install --from-paths src --ignore-src --rosdistro kinetic \
    && . /catkin_ws/devel/setup.sh && catkin_make \
    && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /
ENTRYPOINT /entrypoint.sh

