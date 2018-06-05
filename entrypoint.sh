#!/bin/bash

# Entrypoint for the scripts

CWD="$(pwd)"

# Make sure the user has a configuration argument
if [[ -z $1 ]]; then
    echo "Missing an argument that specifies the configuration"
    exit -1
fi
if [[ ! -d "$CWD/$1" ]]; then
    echo "No directory found that matches the given configuration argument"
    exit -1
fi

function main() {
    entrypoint="$CWD/$1/scripts/entrypoint.sh";
    if [[ -f $entrypoint ]]; then source $entrypoint $@; fi
}

main $@

unset -f main
unset CWD