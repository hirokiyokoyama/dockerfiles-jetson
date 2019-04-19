#!/bin/bash
set -e

service avahi-daemon restart

# setup ros environment
source "/catkin_ws/devel/setup.bash"
exec "$@"

