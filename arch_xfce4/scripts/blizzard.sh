#!/bin/bash

# This file installs all the necessary wine dependencies to run Blizzard games in wine.

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
    