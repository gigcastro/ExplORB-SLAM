#!/usr/bin/env bash

#
# RUN THIS SCRIPT FROM THE ROOT PROJECT DIRECTORY
#

source setup.env

# Default value
default_container_name=$IMAGE_NAME

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --name)
            container_name="$2"
            shift 2
            ;;
        *)
            echo "Unknown parameter passed: $1"
            exit 1
            ;;
    esac
done

# Use the default value if no --name argument was passed
container_name="${container_name:-$default_container_name}"

echo "Running image $IMAGE_NAME using USERNAME=$USERNAME USER_UID=$USER_UID USER_GID=$USER_GID"
echo "Container will be named $container_name"
echo "Current directory $(pwd) will be forwarded to $EXPLORB_WS"
echo 

# Running the container forwarding the host user and the current directory as $EXPLORB_WS
docker run -it \
   --rm \
   --gpus=all \
   --net=host \
   --user $USER_UID:$USER_GID \
   -e DISPLAY=$DISPLAY \
   -v /tmp/.X11-unix:/tmp/.X11-unix \
   -v /dev/dri:/dev/dri \
   -v /dev/shm:/dev/shm \
   -v $(pwd)/..:$EXPLORB_WS \
   --name $container_name \
   $IMAGE_NAME
