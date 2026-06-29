#!/bin/bash

# Requires init.sh first (sets DOTFILES_SHARED_ROOT). Keeps sudo alive for installs.
# shellcheck source=../../../shared/scripts/lib/sudov.sh
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"

function pkg_install() {
    sudo pacman -S --noconfirm --needed -q "$@"
}

# TODO (MODERNIZATION P0): replace yaourt with paru or yay
function aur_install() {
    yaourt -S --noconfirm --needed "$@"
}
