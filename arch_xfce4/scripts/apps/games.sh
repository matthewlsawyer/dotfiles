#!/bin/bash

# Optional — WINE, Steam, and emulator stack.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

# ==
# WINE + dependencies (incl. Blizzard / Proton)
# ==

pkg_install wine-staging winetricks

pkg_install giflib lib32-giflib
pkg_install libpng lib32-libpng
pkg_install libldap lib32-libldap
pkg_install gnutls lib32-gnutls
pkg_install mpg123 lib32-mpg123
pkg_install openal lib32-openal
pkg_install lib32-libpulse lib32-alsa-plugins lib32-alsa-lib
pkg_install v4l-utils lib32-v4l-utils
pkg_install libjpeg-turbo lib32-libjpeg-turbo
pkg_install libxcomposite lib32-libxcomposite
pkg_install libxinerama lib32-libxinerama
pkg_install ncurses lib32-ncurses
pkg_install opencl-icd-loader lib32-opencl-icd-loader
pkg_install libxslt lib32-libxslt
pkg_install libva lib32-libva
pkg_install gtk3 lib32-gtk3
pkg_install gst-plugins-base-libs lib32-gst-plugins-base-libs
pkg_install vulkan-icd-loader lib32-vulkan-icd-loader
pkg_install libgpg-error lib32-libgpg-error
pkg_install libgcrypt lib32-libgcrypt
pkg_install sqlite lib32-sqlite
pkg_install cups
pkg_install samba
pkg_install libwbclient
# aur_install lib32-libwbclient

# Microsoft fonts for WINE games
# This is deprecated but there's no better solution for now
aur_install ttf-ms-fonts

# WINE wrapper useful for managing wine versions and bottles
# pkg_install playonlinux
# aur_install q4wine
# aur_install lutris

# Clean out all the dumb wine extensions
rm -f ~/.local/share/applications/wine-extension*

# ==
# Steam
# ==

pkg_install steam

install_user="${USER:-$(id -un)}"
sudo usermod -aG games "$install_user"
echo "Added $install_user to games group — log out/in, or run: newgrp games"

# Kernel 4.18+ hid_steam conflicts with Steam userspace controller — use sc-controller/xpad instead
# sudo modprobe -r hid_steam 2>/dev/null || true
# echo 'blacklist hid_steam' | sudo tee /etc/modprobe.d/sc.conf > /dev/null

# Xpad kernel module included with Valve's SteamOS
# aur_install sc-controller steamos-xpad-dkms

# ==
# Games
# ==

# Monster Hunter World launch options
# WINEDEBUG=-all __GL_SHADER_DISK_CACHE=1 __GL_SHADER_DISK_CACHE_PATH=/sdata/GLCache/mhw __GL_THREADED_OPTIMIZATIONS=1 %command% -nofriendsui -udp

# ==
# Emulators
# ==

# pkg_install dolphin-emu    # Gamecube\Wii
# aur_install epsxe          # PS
# pkg_install desmume        # DS
# aur_install citra-git      # 3DS
# pkg_install retroarch
# pkg_install dosbox
