#!/bin/bash

# This file should be used to grab wine and all of its dependencies.

. sudov.sh
. functions.sh

# Stuff for WINE
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
