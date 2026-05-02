#!/bin/bash

# BUILDX and docker installed test
./envs.sh start docker-buildx-with-docker-installed-test || exit 1

# DIND
./envs.sh start docker-dind-test || exit 1

# DOOD + PATH_REPLACER
./envs.sh start docker-dood-with-docker-installed-test || exit 1