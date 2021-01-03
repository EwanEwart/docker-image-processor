#!/bin/bash

# build image
docker build -t avatar .
docker images

# build container
docker run --name av_cntl avatar:latest

# view default result using eye of gnome
docker ps -a --no-trunc
sudo eog /var/lib/docker/volumes/2c71e0096b6fa70054a8c10e27ea384975db7e06b942b5c6e705fa499babc2e0/_data/external-content.png
