#!/bin/bash

# Initializes a new system

# Make sure the user has a configuration argument
if [[ -z $1 ]]; then
    echo "Missing an argument that specifies the configuration"
    exit -1
fi
if [[ ! -d "$1" ]]; then
    echo "No directory found that matches the given configuration argument"
    exit -1
fi

function sync() {
    echo "Running rsync..."
    # Copy the dotfiles into the home directory
    dotfiles="./$1/dotfiles/"
    # Flags:
    #  -a           archive
    #  -v           verbose
    #  -h           human readable
    #  --no-perms   don't copy over file permissions
    rsync -avh --no-perms $dotfiles ~
    echo "Done!"
}

function scripts() {
    echo "Running the scripts..."
    # Run the scripts
    entrypoint="./$1/scripts/entrypoint.sh";
    if [[ -f $entrypoint ]]; then source $entrypoint; fi
    echo "Done!"
}

function main() {
    if [ "$1" == "--force" -o "$1" == "-f" ]; then
        sync $1
    else
        read -p "This may overwrite existing files in your home directory. Are you sure? (Y/n) " -n 1
        echo ""
        # If the reply is not 'N' or 'n'
        if [[ $REPLY =~ ^[^Nn]?$ ]]; then
            sync $1
        fi
    fi
    read -p "Would you like to run the scripts? (Y/n) " -n 1
    echo ""
    # If the reply is not 'N' or 'n'
    if [[ $REPLY =~ ^[^Nn]?$ ]]; then
        scripts $1
    fi
}

main $1

unset -f main
unset -f scripts
unset -f sync