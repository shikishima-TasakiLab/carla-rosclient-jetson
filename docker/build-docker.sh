#!/bin/bash
BUILD_DIR="$(dirname $(readlink -f $0))"

IMAGE_LS="$(docker image ls jetson/ros:melodic-desktop-full)"

if [[ $(echo "${IMAGE_LS}" | wc -l) -lt 2 ]]; then
    ${BUILD_DIR}/src-ros/docker/build-docker.sh
    if [[ $? != 0 ]]; then
        echo "エラーにより中断しました．"
        cd ${CURRENT_DIR}
        exit 1
    fi
fi

docker build -t jetson/carla-rosclient:melodic ${BUILD_DIR}/src-carla
if [[ $? != 0 ]]; then
    echo "エラーにより中断しました．"
    exit 1
fi