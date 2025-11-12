#!/bin/bash

function main {
    
    if [[ -f "/working-env/docker/dood/volume-path-replacer/config.cfg" ]]; then
        source /working-env/docker/dood/volume-path-replacer/config.cfg
        if [ $? -ne 0 ]; then
            echo "Error sourcing config file" >&2
            exit 1
        fi
        
        echo "$REPLACE_WITH"
    else
        echo "$(pwd)"
    fi

    exit 0
}