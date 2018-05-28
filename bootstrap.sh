#!/bin/bash

# Initializes a new system

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

distro=arch
desktop_env=xfce4

if [[ -z $distro ]]; then
    echo "Missing distro argument, perhaps you forgot it";
fi

if [[ -z $desktop_env ]]; then
    echo "Missing desktop_env argument, perhaps you forgot it";
fi

# Sync the dotfiles
function sync() {
    # Clear the stage folder
    if [ -d "./stage" ]; then
        rm -fr ./stage;
    fi
    # And recreate it
    mkdir -p ./stage;

    # Stage the dotfiles in order of specificity
    cp -a ./dotfiles/_base/_base/. ./stage/;
    if [[ $desktop_env ]]; then cp -a ./dotfiles/_base/$desktop_env/. ./stage/; fi
    if [[ $distro ]]; then cp -a ./dotfiles/$distro/_base/. ./stage/; fi
    if [[ $distro ]] && [[ $desktop_env ]]; then cp -a ./dotfiles/$distro/$desktop_env/. ./stage/; fi

	# Copy the staged dotfiles into the home directory
	# Flags:
	#  -a           archive
	#  -v           verbose
	#  -h           human readable
	#  --no-perms   don't copy over file permissions
	# rsync -avh --no-perms ./stage/ ~;
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