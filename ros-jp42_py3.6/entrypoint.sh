#!/bin/bash
set -e

service avahi-daemon restart

# setup ros environment
source "/opt/ros/melodic/setup.bash"
source "/catkin_ws/devel/setup.bash"
exec "$@"

