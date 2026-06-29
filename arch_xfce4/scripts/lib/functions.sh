#!/bin/bash

# Requires init.sh first (sets DOTFILES_SHARED_ROOT). Keeps sudo alive for installs.
# shellcheck source=../../../shared/scripts/lib/sudov.sh
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"

function pkg_install() {
    sudo pacman -S --noconfirm --needed -q "$@"
}

function aur_install() {
    paru -S --noconfirm --needed "$@"
}

function aur_install_interactive() {
    paru -S --needed "$@"
}
