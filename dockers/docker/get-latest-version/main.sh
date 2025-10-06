#!/bin/bash


function getVersion {
    local api_url
    local data_by_api
    local latest_version_tag
    local latest_version

    api_url="https://api.github.com/repos/moby/moby/releases/latest"

    data_by_api=$(wget -qO- "$api_url")
    [ $? -ne 0 ] && exit 1

    latest_version_tag=$(echo "$data_by_api" | jq -r .tag_name)
    [ $? -ne 0 ] && exit 1

    if [ -z "$latest_version_tag" ]; then
        echo "Failed to extract latest version tag"
        exit 1
    fi

    latest_version="${latest_version_tag#v}"
    [ $? -ne 0 ] && exit 1

    if [ -z "$latest_version" ]; then
        echo "Failed to extract latest version"
        exit 1
    fi

    echo "$latest_version"

    exit 0
}

latest_version=$(getVersion)

echo "LATEST_VERSION=\"$latest_version\"" > /working-env/docker/configs/latest-version.cfg