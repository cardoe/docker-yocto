#!/bin/bash

# The user can supply a UID and GID from the docker run command by:
# docker run -e BUILD_UID=$(id -u) -e BUILD_GID=$(id -g) ...
BUILD_UID=${BUILD_UID:-580}
BUILD_GID=${BUILD_GID:-580}

# create a group
groupadd --gid ${BUILD_GID} --non-unique buildgroup

# create a non-root user
useradd --no-create-home --home-dir /var/build -s /bin/bash \
	--non-unique --uid ${BUILD_UID} --gid ${BUILD_GID} --groups sudo \
	builduser

# give users in the sudo group sudo access in the container
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
