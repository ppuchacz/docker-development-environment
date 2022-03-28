#!/bin/bash

docker run --rm -it -v "$(pwd)"/projects:/home/user/projects ubuntu_php_env:latest "$@"