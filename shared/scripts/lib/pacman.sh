#!/bin/bash

# Shared pacman install helper — sourced by profile functions.sh

function pinstall() {
    sudo pacman -S --noconfirm --needed -q "$@"
}
