#!/bin/bash

function main {
    local file_path="/working-env/docker/dind/docker-processes.log"
    local this_pid=$$
    local output
    local exit_code
    local pid_pgrep

    output=$(flock -x "$file_path" -c "
        bash -c '
            source /working-env/docker/dind/start-docker-deamon.sh && main \"$file_path\" \"$this_pid\"
            exit \$?
        '")

    if [ $? -ne 0 ]; then
        exit 1
    fi

    if [ "$output" == "start" ]; then
        (dockerd > /dev/null 2>&1 &)
    fi

    while true; do
        if /working-env/docker/dind/docker-original info > /dev/null 2>&1; then
            break
        fi
        sleep 0.1
    done

    (/working-env/docker/dind/docker-original "$@")
    exit_code=$?

    output=$(flock -x "$file_path" -c "
        bash -c '
            source /working-env/docker/dind/stop-docker-deamon.sh && main \"$file_path\" \"$this_pid\"
            exit \$?
        '")

    if [ $? -ne 0 ]; then
        exit 1
    fi

    exit $exit_code
}

main "$@"