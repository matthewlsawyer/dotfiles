#!/bin/bash

# packages.sh — core packages. Optional tiers in hardware/, apps/, desktop/.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

# Enable multilib (needed for lib32 stacks in optional graphics/games modules)
if [[ -z "$(grep -n "^\[multilib\]" /etc/pacman.conf)" ]]; then
    echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee --append /etc/pacman.conf > /dev/null
fi

sudo pacman -Syy
sudo pacman -Syu --noconfirm


# Display base (Xorg before desktop.sh)
pkg_install xorg-server xorg-xinit xorg-apps

# Desktop audio
pkg_install pulseaudio libpulse lib32-libpulse \
            alsa-plugins lib32-alsa-plugins \
            alsa-lib lib32-alsa-lib \
            pavucontrol

# Opinionated extras
pkg_install plank

# Shell / dev minimum
pkg_install vim git tmux jq

# System
pkg_install pacman-contrib lvm2

# Contract — run_sync (apply.sh)
pkg_install rsync
