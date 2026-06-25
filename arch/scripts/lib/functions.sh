#!/bin/bash

# Global install helpers — sourced by optional module scripts.

function pinstall() {
    sudo pacman -S --noconfirm --needed -q "$@"
}
