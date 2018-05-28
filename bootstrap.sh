#!/bin/bash

# Initializes a new system

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

distro=arch_xfce4

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
	# Copy the staged dotfiles into the home directory
	# Flags:
	#  -a           archive
	#  -v           verbose
	#  -h           human readable
	#  --no-perms   don't copy over file permissions
	# rsync -avh --no-perms ./$1/dotfiles/ ~;
    echo "No op";
}

# Run the scripts
function scripts() {
    echo "No op";
}

# Bootstrap the system
function bootstrap() {
    sync;
    scripts;
}

bootstrap;