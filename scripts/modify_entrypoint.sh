#!/bin/bash
sed -i '/exec "$@"/i export ROS_PACKAGE_PATH="/opt/ros/noetic/share:${EXPLORB_WS}/src"' /ros_entrypoint.sh
