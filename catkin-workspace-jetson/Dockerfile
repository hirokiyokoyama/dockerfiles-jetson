ARG ubuntu_version=xenial
FROM ubuntu:${ubuntu_version}
ARG ros_distro=kinetic

ENV ROS_DISTRO ${ros_distro}
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN echo "deb http://packages.ros.org/ros/ubuntu `. /etc/os-release; echo $UBUNTU_CODENAME` main" > /etc/apt/sources.list.d/ros-latest.list

RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    ros-${ros_distro}-ros-base \
    build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && rosdep init

RUN mkdir -p /catkin_ws/src && cd /catkin_ws/src \
    && . /opt/ros/${ros_distro}/setup.sh && catkin_init_workspace \
    && cd .. && catkin_make

WORKDIR /catkin_ws/src
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

