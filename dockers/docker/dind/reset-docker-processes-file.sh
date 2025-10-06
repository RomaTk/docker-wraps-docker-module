#!/bin/bash

function checkIfRunningAsInit {
    local pid="$1"

    while true; do
        if [[ "$pid" == "1" ]]; then
            echo "true"
            break
        fi

        if [[ "$pid" == "0" ]]; then
            echo "false"
            break
        fi

        pid=$(ps -o ppid= -p "$pid" | awk '{print $1}')
        if [ $? -ne 0 ]; then
            echo "Error retrieving parent process ID for PID: $pid" >&2
            exit 1
        fi
    done

    exit 0
}

function resetFile {
    local file_path="$1"

    mkdir -p "$(dirname "$file_path")"
    if [ $? -ne 0 ]; then
        echo "Error creating directory for file: $file_path" >&2
        exit 1
    fi

    echo "[]" > "$file_path"
    if [ $? -ne 0 ]; then
        echo "Error writing to file: $file_path" >&2
        exit 1
    fi
    exit 0
}

function main {
    local file_path="/working-env/docker/dind/docker-processes.log"
    local is_init
    is_init=$(checkIfRunningAsInit "$$")
    if [ $? -ne 0 ]; then
        echo "Failed to determine if running as init process" >&2
        exit 1
    fi

    if [ "$is_init" == "true" ]; then
        (resetFile "$file_path")
        if [ $? -ne 0 ]; then
            echo "Failed to reset file: $file_path" >&2
            exit 1
        fi
    fi

    exit 0
}