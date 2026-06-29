#!/bin/bash

function pkg_install() {
    sudo pacman -S --noconfirm --needed -q "$@"
}

# TODO (MODERNIZATION P0): replace yaourt with paru or yay
function aur_install() {
    yaourt -S --noconfirm --needed "$@"
}
