#!/bin/bash

# Contract: bootstrap pipeline step 2 — packages.sh
# Core packages only. Optional tiers live in hardware/, apps/, desktop/.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/sudov.sh"

# Enable multilib (needed for lib32 stacks in optional graphics/games modules)
if [[ -z "$(grep -n "^\[multilib\]" /etc/pacman.conf)" ]]; then
    echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee --append /etc/pacman.conf > /dev/null
fi

sudo pacman -Syy
sudo pacman -Syu --noconfirm

. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

# Display base (Xorg before desktop.sh)
pinstall xorg-server xorg-xinit xorg-apps

# Desktop audio
pinstall pulseaudio libpulse lib32-libpulse \
            alsa-plugins lib32-alsa-plugins \
            alsa-lib lib32-alsa-lib \
            pavucontrol

# Opinionated extras
pinstall plank

# Shell / dev minimum
pinstall vim git tmux jq

# System
pinstall pacman-contrib lvm2

# Contract — sync.sh
pinstall rsync
