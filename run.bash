#!/bin/bash

set -ex

DOCKER_IMAGE="killruana/openroad:ubuntu22.04"
DESIGN="aes"
PLATFORM="sky130hd"

IMPL_DIR=$(readlink -f $(dirname ${BASH_SOURCE[0]}))
cd "${IMPL_DIR}"
docker run \
    --user "$(id -u):$(id -g)" \
    -v "${IMPL_DIR}/run:/OpenROAD-flow-scripts/flow/run"  \
    ${DOCKER_IMAGE} \
    bash -c ". setup_env.sh && cd flow && make DESIGN_CONFIG=./designs/${PLATFORM}/${DESIGN}/config.mk LOG_DIR=./run/logs OBJECTS_DIR=./run/objects REPORTS_DIR=./run/reports RESULTS_DIR=./run/results"
