#!/bin/bash

# Initializes a new system

# Make sure the user has a configuration argument
if [[ -z $1 ]]; then
    echo "Missing an argument that specifies the configuration";
    exit -1;
fi
if [[ ! -d "$1" ]]; then
    echo "No directory found that matches the given configuration argument";
    exit -1;
fi

# Sync the dotfiles
function sync() {
    # Copy the dotfiles into the home directory
    dotfiles="./$1/dotfiles/"
    # Flags:
    #  -a           archive
    #  -v           verbose
    #  -h           human readable
    #  --no-perms   don't copy over file permissions
    sync -avh --no-perms $dotfiles ~;
}

# Run the scripts
function scripts() {
    # Run the scripts in order
    preinstall="./$1/scripts/preinstall.sh";
    if [[ -f $preinstall ]]; then source $preinstall; fi

    packages="./$1/scripts/packages.sh";
    if [[ -f $packages ]]; then source $packages; fi

    postinstall="./$1/scripts/postinstall.sh";
    if [[ -f $postinstall ]]; then source $postinstall; fi
}

# Bootstrap the system
function bootstrap() {
    sync $1;
    scripts $1;
}

bootstrap $1;