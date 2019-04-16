ARG ROS_DISTRO=kinetic
FROM ros:${ROS_DISTRO}
LABEL maintainer "hirokiyokoyama <h-yokoyama@craft-server.co.jp>"

RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-rviz \
    && rm -rf /var/lib/apt/lists/*

CMD ["rviz"]

