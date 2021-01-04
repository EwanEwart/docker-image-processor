#!/bin/bash

if [[ $2 == "macos" ]]; then
    viewer=open
else
    viewer=eog
fi 

test() {
    echo "> test raw go module"
    rm tmp/out/*
    go test -v
    tree
    ls -lt tmp/out
    $viewer tmp/out/model-1.jpg
    $viewer tmp/out/model-2.jpg
    
}
raw_run() {
    echo "> build raw avatar binary"
    go build -o ./bin/avatar .

    echo "> run avatar binary"
    rm tmp/out/* 
    ./bin/avatar tmp/src/model-1.jpeg tmp/out/model-1.jpeg 
    ./bin/avatar tmp/src/model-2.jpeg tmp/out/model-2.jpeg 
    ./bin/avatar tmp/src/model-3.png tmp/out/model-3.png 
    ./bin/avatar tmp/src/model-4.png tmp/out/model-4.png
    tree
    ls -lt tmp/out
    $viewer tmp/out/model-1.jpeg
    $viewer tmp/out/model-2.jpeg
    $viewer tmp/out/model-3.png
    $viewer tmp/out/model-4.png
}
prune () {
    echo "> container prune"
    echo 'y' | docker container prune
    echo "> volume prune"
    echo 'y' | docker volume prune
    echo "> image prune"
    echo 'y' | docker image prune
    echo "> Delete dangling images - alternative"
    docker rmi -f `docker images -q -f dangling=true`
    echo "> Delete external host volume"
    sudo rm -f ~/avatar-files/*
}
build () {
    echo "> Create directory of external host volume"
    mkdir ~/avatar-files 2>/dev/null
    echo "> build image" 
    docker build -t avatar .
    docker images
}
build_keir () { // build on keir intranet
    # compile on another server
    export DOCKER_HOST=ssh://keir@192.168.188.222
    echo "→ DOCKER_HOST=$DOCKER_HOST"

}
run() {
    echo "> run container" 
    # docker run --name av_cntl avatar:latest avatar:latest 
    docker run --rm -v ~/avatar-files:/app/shared avatar:latest
    tree
    ls -lt ~/avatar-files
}
view() {
    echo "> View default result using the eye of gnome"
    docker ps -a --no-trunc
    # sudo $viewer /var/lib/docker/volumes/2c71e0096b6fa70054a8c10e27ea384975db7e06b942b5c6e705fa499babc2e0/_data/external-content.png
    $viewer ~/avatar-files/external-content.png
}




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

case "$1" in
"prune")
    prune
    ;;
"build")
    build
    ;;
"run")
    run
    ;;
"view")
    view
    ;;
"keir")
    build_keir
    ;;
"test")
    test
    ;;
"rawrun")
    raw_run
    ;;
"dmv")
    dmv
    ;;
*)
    echo -e "\n> Usage: $0 keir | prune | build | run | dmv\n"
    ;;
esac
