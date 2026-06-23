#!/bin/bash

# This file has global functions and is intended to be sourced into the
# other various scripts.

function pinstall() {
    sudo pacman -S --noconfirm --needed -q $@
}

function yinstall() {
    yaourt -S --noconfirm --needed $@
}
