FROM ros:noetic-perception

ENV EXPLORB_WS=/root/explorb_ws \
    DEBIAN_FRONTEND=noninteractive

# setting bash shell, allows 'source' command
#SHELL ["/bin/bash", "-c"]

RUN apt update && apt install -y --no-install-recommends apt-utils

RUN apt install -y \
    python3 \
    python3-catkin-tools \
    ros-noetic-rviz \
    ros-noetic-gazebo-ros \
    ros-noetic-tf-conversions \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-turtlebot3-teleop \
    ros-noetic-turtlebot3 \
    ros-noetic-octomap \
    ros-noetic-octomap-mapping \
    ros-noetic-octomap-msgs \
    ros-noetic-octomap-ros \
    ros-noetic-octomap-rviz-plugins \
    ros-noetic-octomap-server
    

COPY . $EXPLORB_WS
COPY ./scripts $EXPLORB_WS

WORKDIR $EXPLORB_WS

RUN  catkin config --extend /opt/ros/noetic
RUN /bin/bash -c "chmod +x build.sh && chmod +x modify_entrypoint.sh && sync && ./modify_entrypoint.sh && ./build.sh"
