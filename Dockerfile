FROM ros:noetic-perception

ARG USERNAME=USERNAME
ARG USER_UID=USER_UID
ARG USER_GID=USER_GID

RUN echo "Building..."
RUN echo "+ USERNAME=$USERNAME" 
RUN echo "+ USER_UID=$USER_UID"
RUN echo "+ USER_GID=$USER_GID"
RUN echo "+ EXPLORB_WS=$EXPLORB_WS"

# Reproduce host user on docker environment
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
RUN apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install apt packages dependencies
RUN apt update && apt install -y --no-install-recommends apt-utils && \
    rosdep init && rosdep update
    
RUN apt install -y \
    python3 \
    python3-pip \
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
    ros-noetic-octomap-server \
    ros-noetic-teb-local-planner
    
# Install python packages dependencies
RUN pip install --yes \
    numpy \
    scipy \
    scikit-learn \
    Numba \
    networkx \
    sophus \
    sophuspy \
    opencv-python \
    matplotlib \
    nptyping

# Adding sourcing ros environment in bash profile
ENV SHELL /bin/bash
RUN echo source /opt/ros/noetic/setup.bash >> /home/$USERNAME/.bashrc
RUN echo source $EXPLORB_WS/devel/setup.bash >> /home/$USERNAME/.bashrc

# Setting the user inside container
USER $USERNAME

WORKDIR $EXPLORB_WS
CMD ["/bin/bash"]
