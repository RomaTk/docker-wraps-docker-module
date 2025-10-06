#!/bin/bash

function main {
    local file_path="$1"
    local pid="$2"
    local pids_array
    local length
    local existing_pid
    local i
    local new_pids_array="[]"
    local line_count

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

    is_some_change_done="no"

    for ((i=0; i<length; i++)); do
        existing_pid=$(echo "$pids_array" | jq -r ".[$i]")
        [ $? -ne 0 ] && exit 1

        if [ "$existing_pid" == "$pid" ]; then
            is_some_change_done="yes"
            continue
        fi

        line_count=$(ps -p "$existing_pid" 2>/dev/null | wc -l)
        if [ $? -ne 0 ]; then
            echo "Error checking process: $existing_pid" >&2
            exit 1
        fi

        if [ "$line_count" -lt 2 ]; then
            is_some_change_done="yes"
            continue
        fi

        new_pids_array=$(echo "$new_pids_array" | jq --arg pid "$existing_pid" '. + [$pid]')
        [ $? -ne 0 ] && exit 1
    done

    echo "$new_pids_array" > "$file_path"
    if [ $? -ne 0 ]; then
        echo "Error writing to file: $file_path" >&2
        exit 1
    fi

    if [ "$is_some_change_done" == "yes" ]; then
        length=$(echo "$new_pids_array" | jq -r '. | length')
        if [ $? -ne 0 ]; then
            echo "Error parsing JSON from file: $file_path" >&2
            exit 1
        fi
        
        if [ "$length" -eq 0 ]; then
            pid_pgrep=$(pgrep -x "dockerd")
            if [ -n "$pid_pgrep" ]; then
                kill "$pid_pgrep"
                while true; do
                    if ! ps -p "$pid_pgrep" > /dev/null 2>&1; then
                        break
                    else
                        sleep 0.1
                    fi
                done
            fi
        fi
    fi

    exit 0
}

