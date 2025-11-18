#!/bin/bash

function main {
    local version="$1"
    local os="$2"
    local path_to_docker="$3"
    local file_version_in_download_docker_context="$path_to_docker/download/with-configs/configs/versions.cfg"
    local empty_file_name="buildx-null.null-null"

    if [ -z "$version" ]; then
        source ./env-scripts/not-by-wrap-name/install-some-util/get-latest-version.sh
        [ $? -ne 0 ] && exit 1

        version="$(getLatestVersion "$path_to_docker" "docker-buildx" "$os")"
        [ $? -ne 0 ] && exit 1
    fi

    source "./env-scripts/not-by-wrap-name/install-some-util/prepare-before-build/main.sh"
    [ $? -ne 0 ] && exit 1

    main "$version" "$os" "docker-buildx" "$path_to_docker" "$empty_file_name"
    [ $? -ne 0 ] && exit 1

    exit 0
}

function isRunDownloadWrap {
    local version="$1"
    local os="$2"
    local arch="$3"

    if [ -f "./dockers/docker/buildx/install/saved-versions/buildx-${version}.${os}-${arch}" ]; then
        echo "no"
        exit 0
    fi

    echo "yes"
    exit 0
}

function formatArch {
    local arch="$1"

    case "$arch" in
        "x86_64" | "amd64")
            echo "amd64"
            ;;
        "aarch64" | "arm64")
            echo "arm64"
            ;;
        "armv7l" | "armv7" | "arm")
            echo "arm-v7"
            ;;
        "ppc64le")
            echo "ppc64le"
            ;;
        "s390x")
            echo "s390x"
            ;;
        "riscv64")
            echo "riscv64"
            ;;
        *)
            echo "unsupported"
            exit 1
            ;;
    esac

    exit 0
}