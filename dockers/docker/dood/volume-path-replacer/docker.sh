#!/bin/bash

function check_is_run_command {
    if [[ "$1" == "run" ]]; then
        exit 2
    fi

    exit 0
}



function fix_mount_args {
    local arg
    local fixed_arg

    local is_to_use_next_arg="false"
    
    source /working-env/docker/dood/volume-path-replacer/config.cfg
    if [ $? -ne 0 ]; then
        echo "Error loading configuration file" >&2
        exit 1
    fi

    for arg in "$@"; do
        if [[ "$is_to_use_next_arg" == "true" || "$arg" == "--mount="* ]]; then
            fixed_arg=$(echo "$arg" | sed -E "s#(src=)?$TO_REPLACE([^,]*)?#\1$REPLACE_WITH\2#")
            if [ $? -ne 0 ]; then
                echo "Error processing argument: $arg" >&2
                exit 1
            fi
            is_to_use_next_arg=false

            fixed_args+=("$fixed_arg")
            continue
        fi

        if [[ "$arg" == "--mount" ]]; then
            is_to_use_next_arg=true
        fi

        fixed_args+=("$arg")
    done
}


(check_is_run_command "$@")
if [ $? -eq 2 ]; then
    fixed_args=()
    fix_mount_args "$@"

    ("/bin/docker-orig" "${fixed_args[@]}")
    exit $?
else
    ("/bin/docker-orig" "$@")
    exit $?
fi