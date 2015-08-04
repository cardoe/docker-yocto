# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.17

MAINTAINER Doug Goldstein <cardoe@cardoe.com>

# No Debian that's a bad Debian! We don't have an interactive prompt don't fail
ENV DEBIAN_FRONTEND noninteractive

# Use baseimage-docker's init
# https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/
CMD ["/sbin/my_init"]

# Yocto's depends
RUN apt-get --quiet --yes update && \
	apt-get --quiet --yes install gawk wget git-core diffstat unzip \
		texinfo gcc-multilib build-essential chrpath socat

# If you need to add more packages, just do additional RUN commands here
# I've intentionally done this so that the layers before this don't have
# to be regenerated and fetched since the above layer is big.
# RUN apt-get --quiet --yes install something

# clean up
RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
