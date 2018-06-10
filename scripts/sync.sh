#!/bin/bash

# System-agnostic script to rsync the dotfiles

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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

sudo pacman -Sy --noconfirm --needed -q rsync

function sync() {
    echo "Running rsync..."
    # Copy the dotfiles into the home directory
    dotfiles="$CWD/$1/dotfiles/"
    # Flags:
    #  -a           archive
    #  -v           verbose
    #  -h           human readable
    #  --no-perms   don't copy over file permissions
    rsync -avh --no-perms $dotfiles ~
    echo "Done!"
}

function main() {
    read -p "This may overwrite existing files in your home directory. Are you sure? (Y/n) " -n 1
    echo ""
    # If the reply is not 'N' or 'n'
    if [[ $REPLY =~ ^[^Nn]?$ ]]; then
        sync $@
    fi
}

main $@

unset -f main
unset -f sync
unset CWD
