#!/bin/bash

cd ./saved-versions
[ $? -ne 0 ] && exit 1

dest_folder="/root/.docker/cli-plugins"
if [ ! -d "$dest_folder" ]; then
    mkdir -p "$dest_folder"
    [ $? -ne 0 ] && exit 1
fi

mv ./downloaded /root/.docker/cli-plugins/docker-buildx
[ $? -ne 0 ] && exit 1

chmod +x /root/.docker/cli-plugins/docker-buildx
[ $? -ne 0 ] && exit 1

exit 0