#!/bin/bash

function main() {
    local current_file="${BASH_SOURCE[0]}"
    local current_dir
    local mktemp_file
    
    current_dir="$(dirname "$current_file")"
    [ $? -ne 0 ] && exit 1

    cd "$current_dir" || exit 1
    [ $? -ne 0 ] && exit 1

    ln -sf "../$current_dir/dockers/docker" "../../dockers/docker"
    [ $? -ne 0 ] && exit 1

    ln -sf "../$current_dir/env-scripts/docker" "../../env-scripts/docker"
    [ $? -ne 0 ] && exit 1
    
    mktemp_file=$(mktemp)
    [ $? -ne 0 ] && exit 1

    jq -s '.[0] * .[1]' "./envs.json" "../../envs.json" > "$mktemp_file"
    [ $? -ne 0 ] && exit 1

    mv "$mktemp_file" "../../envs.json"
    [ $? -ne 0 ] && exit 1
    
    rm -f "$mktemp_file"
    [ $? -ne 0 ] && exit 1

    exit 0
}