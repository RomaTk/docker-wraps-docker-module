#!/bin/bash

cd ./saved-versions
[ $? -ne 0 ] && exit 1

dest_folder="./downloaded"

if [ ! -d "$dest_folder" ]; then
    mkdir -p "$dest_folder"
    [ $? -ne 0 ] && exit 1
fi

tar -xzf "downloaded.tgz" -C "$dest_folder" --strip-components=1
[ $? -ne 0 ] && exit 1

cd "$dest_folder"
[ $? -ne 0 ] && exit 1

cp ./* /bin/
[ $? -ne 0 ] && exit 1

exit 0