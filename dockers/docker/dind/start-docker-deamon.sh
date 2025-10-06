#!/bin/bash

function main {
    local file_path="$1"
    local pid="$2"
    local pids_array
    local length
    local existing_pid
    local i
    local line_count
    local new_pids_array="[]"

    pids_array=$(cat "$file_path")
    if [ $? -ne 0 ]; then
        echo "Error reading file: $file_path" >&2
        exit 1
    fi

    length=$(echo "$pids_array" | jq -r '. | length')
    if [ $? -ne 0 ]; then
        echo "Error parsing JSON from file: $file_path" >&2
        exit 1
    fi

    # Cleaning not existing processes
    for ((i=0; i<length; i++)); do
        existing_pid=$(echo "$pids_array" | jq -r ".[$i]")
        [ $? -ne 0 ] && exit 1

        line_count=$(ps -p "$existing_pid" 2>/dev/null | wc -l)
        if [ $? -ne 0 ]; then
            echo "Error checking process: $existing_pid" >&2
            exit 1
        fi

        if [ "$line_count" -lt 2 ]; then
            continue
        fi

        new_pids_array=$(echo "$new_pids_array" | jq --arg pid "$existing_pid" '. + [$pid]')
        [ $? -ne 0 ] && exit 1
    done

    pids_array="$new_pids_array"

    length=$(echo "$pids_array" | jq -r '. | length')
    if [ $? -ne 0 ]; then
        echo "Error parsing JSON from file: $file_path" >&2
        exit 1
    fi
    # End cleaning not existing processes

    if [ "$length" -eq 0 ]; then
        pid_pgrep=$(pgrep -x "dockerd")
        if [ -n "$pid_pgrep" ]; then
            pids_array="[\"$pid_pgrep\", \"$pid\"]"
        else
            pids_array="[\"$pid\"]"
            echo "start"
        fi
    else
        for ((i=0; i<length; i++)); do
            existing_pid=$(echo "$pids_array" | jq -r ".[$i]")
            [ $? -ne 0 ] && exit 1

            if [ "$existing_pid" == "$pid" ]; then
                exit 0
            fi
        done

        pids_array=$(echo "$pids_array" | jq -r --arg pid "$pid" '. + [$pid]')
        if [ $? -ne 0 ]; then
            echo "Error updating JSON array" >&2
            exit 1
        fi
    fi

    echo "$pids_array" > "$file_path"
    if [ $? -ne 0 ]; then
        echo "Error writing to file: $file_path" >&2
        exit 1
    fi

    exit 0
}

