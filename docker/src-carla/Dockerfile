FROM jetson/ros:melodic-desktop-full
ARG CARLA_VERSION="0.9.9"

USER root

RUN apt-get update && \
    apt-get install -y \
        ros-melodic-ackermann-msgs \
        ros-melodic-derived-object-msgs \
        ros-melodic-ainstein-radar-msgs \
        build-essential \
        clang-8 \
        lld-8 \
        g++-7 \
        cmake \
        ninja-build \
        libvulkan1 \
        python \
        python-pip \
        python-dev \
        python3-dev \
        python3-pip \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
        tzdata \
        sed \
        curl \
        unzip \
        autoconf \
        libtool \
        rsync \
        libxml2-dev \
        libsdl-dev \
        libsdl-image1.2-dev \
        libsdl-mixer1.2-dev \
        libsdl-ttf2.0-dev \
        libsmpeg-dev \
        libportmidi-dev \
        libavformat-dev \
        libswscale-dev && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-8/bin/clang++ 180 && \
    update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-8/bin/clang 180 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN sudo pip install --verbose \
        numpy \
        pygame

WORKDIR /tmp
RUN git clone -b ${CARLA_VERSION} https://github.com/carla-simulator/carla && \
    cd carla && \
    make PythonAPI && \
    mkdir -p -v /opt/carla && \
    cp -r -v PythonAPI /opt/carla/ && \
    cd /tmp && \
    rm -rf carla

USER ros
WORKDIR /home/ros/catkin_ws
ENV PYTHONPATH "${PYTHONPATH}:/opt/carla/PythonAPI/carla/dist/carla-${CARLA_VERSION}-py2.7-linux-aarch64.egg"
COPY ./entrypoint.sh /tmp
ENTRYPOINT ["/tmp/entrypoint.sh"]
