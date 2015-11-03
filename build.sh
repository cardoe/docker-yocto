#!/bin/sh -eux

# Called as follows:
# ./build.sh TAG NAME
# e.g. ./build.sh
# e.g. ./build.sh latest
# e.g. ./build.sh latest rust
# all 3 are equal if run from a directory called 'docker-rust'

# Try to figure out the project name
NAME=$(basename $(dirname $(readlink -f $0)))
NAME=${NAME#docker-}
NAME=${2:-${NAME}}
TAG=${1:-latest}
REGISTRY=registry.star.lab
COMPLETE=${REGISTRY}/${NAME}:${TAG}

docker build --rm=true -t ${COMPLETE} .

docker push ${COMPLETE}
