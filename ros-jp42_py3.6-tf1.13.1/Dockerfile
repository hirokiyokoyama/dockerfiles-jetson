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

# install cv-bridge and put python3 version of cv_bridge
RUN apt-get update && apt-get install --no-install-recommends -y \
    ros-melodic-cv-bridge \
    && rm -rf /var/lib/apt/lists/* \
    && pip install pyyaml 
COPY ./cv_bridge /opt/ros/melodic/lib/python2.7/dist-packages/cv_bridge
#COPY ./cv_bridge /usr/local/lib/python3.6/dist-packages

# setup catkin_ws
RUN mkdir -p /catkin_ws/src && cd /catkin_ws/src \
    && . /opt/ros/melodic/setup.sh && catkin_init_workspace \
    && cd .. && catkin_make

# setup tf and tf2 for python3
RUN pip install catkin_pkg rospkg empy
RUN apt-get update && apt-get install --no-install-recommends -y \
    libbullet-dev libeigen3-dev \
    ros-melodic-orocos-kdl ros-melodic-angles \
    && rm -rf /var/lib/apt/lists/*
# needed by tf2_kdl and tf2_geometry_msgs but cannot build...
#RUN cd / && git clone https://github.com/foolyc/PyKDL.git \
#    && cd /PyKDL && git checkout 9b387f1 \
#    && sed -i -e "s/python3.5m/python3.6m/g" \
#              -e "s/py35/py36/g" \
#              -e "s/1.58/1.65/g" -e "s/1.58.0/1.65.1/g" \
#              CMakeLists.txt \
#    && sed -i -e "s/python3.5m/python3.6m/g" \
#              -e "s/kinetic/melodic/g" \
#              -e "s|/usr/local|/usr|g" \
#              python_orocos_kdl/CMakeLists.txt \
#    && . /opt/ros/melodic/setup.sh \
#    && mkdir build && cd build && cmake .. && make \
#    && cp lib/PyKDL.so /usr/lib/python3/dist-packages \
#    && rm -rf /PyKDL
RUN cd /catkin_ws/src && git clone https://github.com/ros/geometry.git \
                      && git clone https://github.com/ros/geometry2.git \
    && cd /catkin_ws && . devel/setup.sh \
    && catkin_make -DPYTHON_EXECUTABLE=/usr/local/bin/python3.6 \
                   -DPYTHON_LIBRARY=/usr/local/bin/python3.6 \
                   -DPYTHON_VERSION=3 \
                   -DCMAKE_BUILD_TYPE="Release"

WORKDIR /catkin_ws/src
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

