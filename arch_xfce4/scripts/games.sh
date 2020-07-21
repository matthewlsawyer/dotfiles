#!/bin/bash

. sudov.sh
. functions.sh

#########
# Games #
#########

# ==
# WINE depedencies
# ==

pinstall wine-staging-nine                  # WINE staging with the gallium-nine patches, for that bleeding edge
pinstall winetricks
pinstall giflib lib32-giflib                # Gif support
pinstall libpng lib32-libpng                # PNG support
pinstall libldap lib32-libldap              # LDAP, needed for some games in WINE
pinstall gnutls lib32-gnutls                # Transport layer, needed for some games in WINE
pinstall mpg123 lib32-mpg123                # MPEG support
pinstall openal lib32-openal                # 3D audio
pinstall v4l-utils lib32-v4l-utils          # Video 4 linux support
pinstall libjpeg-turbo lib32-libjpeg-turbo
pinstall libxcomposite lib32-libxcomposite  # X11 Composite extension library
pinstall libxinerama lib32-libxinerama      # X11 Xinerama extension library
pinstall ncurses lib32-ncurses              # Curses emulation
pinstall opencl-icd-loader                  # OpenCL Installable Client Driver (ICD) Loader
pinstall lib32-opencl-icd-loader
pinstall libxslt lib32-libxslt              # XSLT support
pinstall libva lib32-libva                  # Video Acceleration (VA) API for Linux
pinstall gtk3 lib32-gtk3
pinstall gst-plugins-base-libs              # GStreamer Multimedia Framework Base Plugin libraries
pinstall lib32-gst-plugins-base-libs
pinstall vulkan-icd-loader                  # Vulkan Installable Client Driver (ICD) Loader
pinstall lib32-vulkan-icd-loader
pinstall cups
pinstall samba
pinstall libwbclient                        # Samba winbind client library -- might need to pull in PGP key from PKGBUILD
#yinstall lib32-libwbclient                 # Multilib samba winbind client library
pinstall dosbox                             # DOS emulation
pinstall gnutls                             # Better networking in Proton 3.16 Beta

# Microsoft fonts for WINE games
# This is deprecated but there's no better solution for now
yinstall ttf-ms-fonts

# WINE wrapper useful for managing wine versions and bottles
#pinstall playonlinux
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

pinstall steam steam-native-runtime

# Xpad kernel module included with Valve's SteamOS
yinstall sc-controller steamos-xpad-dkms

# ==
# Emulators
# ==

#  Make sure to add user to the `games` group
#  Might need to receive key for ncurses dependency
pinstall dolphin-emu    # Gamecube\Wii
yinstall epsxe          # PS
pinstall desmume        # DS
#yinstall citra-git  # 3DS
#pinstall retroarch
