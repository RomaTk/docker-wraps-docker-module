#!/bin/bash

function main {
    local path_to_config="$1"
    local to_replace="$2"
    local replace_with="$3"

    local script_path
    local script_dir
    local config_folder

    if [[ -z "$to_replace" ]]; then
        echo "Error: to_replace is not provided" >&2
        exit 1
    fi

    if [[ -z "$replace_with" ]]; then
        script_path="${BASH_SOURCE[0]}"
        script_dir="$(dirname "$script_path")"
        if [[ $? -ne 0 ]]; then
            echo "Error determining script directory" >&2
            exit 1
        fi

        source "$script_dir/get-replace-with.sh" 
        if [[ $? -ne 0 ]]; then
            echo "Error sourcing get-replace-with.sh" >&2
            exit 1
        fi

        replace_with="$(main)"
        if [[ $? -ne 0 ]]; then
            echo "Error getting replace_with value" >&2
            exit 1
        fi
    else
        replace_with="$(realpath "$replace_with")"
        if [[ $? -ne 0 ]]; then
            echo "Error resolving replace_with path" >&2
            exit 1
        fi
    fi
    
    if [[ -z "$path_to_config" ]]; then
        echo "Error: path_to_config is not provided" >&2
        exit 1
    fi

    if [[ ! -f "$path_to_config" ]]; then
        config_folder="$(dirname "$path_to_config")"
        if [[ $? -ne 0 ]]; then
            echo "Error determining config folder" >&2
            exit 1
        fi

        mkdir -p "$config_folder"
        if [[ $? -ne 0 ]]; then
            echo "Error creating config folder" >&2
            exit 1
        fi
        
        {
            echo "TO_REPLACE=\"$to_replace\""
            echo "REPLACE_WITH=\"$replace_with\""
        } > "$path_to_config"
    fi

    exit 0
}