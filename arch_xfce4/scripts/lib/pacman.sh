#!/bin/bash

# pkg_install contract — pacman implementation (see shared/README.md#install-contract)

function pkg_install() {
    sudo pacman -S --noconfirm --needed -q "$@"
}
