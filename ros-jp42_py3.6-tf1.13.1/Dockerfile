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

WORKDIR /catkin_ws/src
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

