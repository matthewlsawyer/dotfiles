#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

#########
# Games #
#########

# ==
# WINE depedencies
# ==

pkg_install wine-staging-nine                  # WINE staging with the gallium-nine patches, for that bleeding edge
pkg_install winetricks
pkg_install giflib lib32-giflib                # Gif support
pkg_install libpng lib32-libpng                # PNG support
pkg_install libldap lib32-libldap              # LDAP, needed for some games in WINE
pkg_install gnutls lib32-gnutls                # Transport layer, needed for some games in WINE
pkg_install mpg123 lib32-mpg123                # MPEG support
pkg_install openal lib32-openal                # 3D audio
pkg_install v4l-utils lib32-v4l-utils          # Video 4 linux support
pkg_install libjpeg-turbo lib32-libjpeg-turbo
pkg_install libxcomposite lib32-libxcomposite  # X11 Composite extension library
pkg_install libxinerama lib32-libxinerama      # X11 Xinerama extension library
pkg_install ncurses lib32-ncurses              # Curses emulation
pkg_install opencl-icd-loader                  # OpenCL Installable Client Driver (ICD) Loader
pkg_install lib32-opencl-icd-loader
pkg_install libxslt lib32-libxslt              # XSLT support
pkg_install libva lib32-libva                  # Video Acceleration (VA) API for Linux
pkg_install gtk3 lib32-gtk3
pkg_install gst-plugins-base-libs              # GStreamer Multimedia Framework Base Plugin libraries
pkg_install lib32-gst-plugins-base-libs
pkg_install vulkan-icd-loader                  # Vulkan Installable Client Driver (ICD) Loader
pkg_install lib32-vulkan-icd-loader
pkg_install cups
pkg_install samba
pkg_install libwbclient                        # Samba winbind client library -- might need to pull in PGP key from PKGBUILD
#yinstall lib32-libwbclient                 # Multilib samba winbind client library
pkg_install dosbox                             # DOS emulation
pkg_install gnutls                             # Better networking in Proton 3.16 Beta

# Microsoft fonts for WINE games
# This is deprecated but there's no better solution for now
yinstall ttf-ms-fonts

# WINE wrapper useful for managing wine versions and bottles
#pkg_install playonlinux
#yinstall q4wine
yinstall lutris

# Clean out all the dumb wine extensions
rm -f ~/.local/share/applications/wine-extension*

# Monster Hunter World launch options
# WINEDEBUG=-all __GL_SHADER_DISK_CACHE=1 __GL_SHADER_DISK_CACHE_PATH=/sdata/GLCache/mhw __GL_THREADED_OPTIMIZATIONS=1 %command% -nofriendsui -udp

# ==
# Dependencies to run Blizzard games
# ==

sudo pacman -S lib32-gnutls lib32-libldap \
    lib32-libgpg-error lib32-sqlite lib32-libpulse

sudo pacman -S wine-staging giflib \
    lib32-giflib libpng lib32-libpng \
    libldap lib32-libldap gnutls \
    lib32-gnutls mpg123 lib32-mpg123 \
    openal lib32-openal v4l-utils \
    lib32-v4l-utils libpulse lib32-libpulse \
    libgpg-error lib32-libgpg-error \
    alsa-plugins lib32-alsa-plugins \
    alsa-lib lib32-alsa-lib libjpeg-turbo \
    lib32-libjpeg-turbo sqlite lib32-sqlite \
    libxcomposite lib32-libxcomposite \
    libxinerama lib32-libgcrypt libgcrypt \
    lib32-libxinerama ncurses lib32-ncurses \
    opencl-icd-loader lib32-opencl-icd-loader \
    libxslt lib32-libxslt libva lib32-libva \
    gtk3 lib32-gtk3 gst-plugins-base-libs \
    lib32-gst-plugins-base-libs vulkan-icd-loader \
    lib32-vulkan-icd-loader

# ==
# Steam
# ==

pkg_install steam steam-native-runtime

# Xpad kernel module included with Valve's SteamOS
yinstall sc-controller steamos-xpad-dkms

# ==
# Emulators
# ==

#  Make sure to add user to the `games` group
#  Might need to receive key for ncurses dependency
pkg_install dolphin-emu    # Gamecube\Wii
yinstall epsxe          # PS
pkg_install desmume        # DS
#yinstall citra-git  # 3DS
#pkg_install retroarch
