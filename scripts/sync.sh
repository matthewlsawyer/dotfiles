#!/bin/bash

# System-agnostic script to rsync the dotfiles

function sync() {
    echo "Running rsync..."
    CWD="$(pwd)"
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