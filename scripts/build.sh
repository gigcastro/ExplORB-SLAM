#!/usr/bin/env bash
source setup.env

echo "Building image $IMAGE_NAME using USERNAME=$USERNAME USER_UID=$USER_UID USER_GID=$USER_GID EXPLORB_WS=$EXPLORB_WS"

docker build --build-arg="EXPLORB_WS=$EXPLORB_WS" --build-arg="USER_UID=$USER_UID" --build-arg="USER_GID=$USER_GID" --build-arg="USERNAME=$USERNAME" -t $IMAGE_NAME ..
