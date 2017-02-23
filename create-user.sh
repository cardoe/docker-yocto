#!/bin/bash

homedir=/var/build

# figure out the uid/gid we need to use by integrating the path that has
# been bind mounted in. this is then used for the builduser.
# the fallback is 580/580 which happily mapped properly under Docker
# for Mac back to my real uid/gid.
BUILD_UID=$(stat --printf=%u ${homedir} 2>&1 > /dev/null)
BUILD_GID=$(stat --printf=%g ${homedir} 2>&1 > /dev/null)
BUILD_UID=${BUILD_UID:-580}
BUILD_GID=${BUILD_GID:-580}
BUILD_UID=${BUILD_UID/#0/580}
BUILD_GID=${BUILD_GID/#0/580}

# create a group
groupadd --gid ${BUILD_GID} --non-unique buildgroup

# create a non-root user
useradd --no-create-home --home-dir ${homedir} -s /bin/bash \
	--non-unique --uid ${BUILD_UID} --gid ${BUILD_GID} --groups sudo \
	builduser

# give users in the sudo group sudo access in the container
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
