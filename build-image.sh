#!/bin/bash

# to do: paramatrise this file
#

# test raw module
go test -v

# build raw avatar ggGbinary 
go build -o ./bin/avatar .

# run avatar binary
./bin/avatar tmp/src/model-1.jpeg tmp/out/model-1.jpeg 
./bin/avatar tmp/src/model-2.jpeg tmp/out/model-2.jpeg 
./bin/avatar tmp/src/model-3.png tmp/out/model-3.png 
./bin/avatar tmp/src/model-4.png tmp/out/model-4.png
tree

# build image
docker build -t avatar .
docker images

# run container
docker run --name av_cntl avatar:latest
tree

# view default result using the eye of gnome
docker ps -a --no-trunc
# sudo eog /var/lib/docker/volumes/2c71e0096b6fa70054a8c10e27ea384975db7e06b942b5c6e705fa499babc2e0/_data/external-content.png

# macOS is not a native host of the Docker engine, 
# which is why the Docker engine 
# runs through a Linux virtual machine. 
# The path specified in the Docker volume 
# is a path on the virtual machine’s filesystem.
#
# Remedy macOS:
# alias dvmc='docker run -it --rm --privileged --pid=host alpine:edge nsenter -t 1 -m -u -n -i sh'
# $ dvmc
# 
