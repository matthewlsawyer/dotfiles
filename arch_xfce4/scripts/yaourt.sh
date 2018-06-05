#!/bin/bash

# This script will install yaourt if it is not already installed.

# First check if yaourt is installed
if pacman -Qs yaourt > /dev/null ; then
    return
fi

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure pacman is up to date
sudo pacman -Syy
# Grab dependencies for package-query
sudo pacman -S --noconfirm --needed yajl

# Make package-query
cd $HOME \
    && git clone https://aur.archlinux.org/package-query.git \
    && cd $HOME/package-query \
    && makepkg -s
# Install it
sudo pacman -U --noconfirm $HOME/package-query/package-query-*-x86_64.pkg.tar.xz

# Make yaourt
cd $HOME \
    && git clone https://aur.archlinux.org/yaourt.git \
    && cd $HOME/yaourt \
    && makepkg -s
sudo pacman -U --noconfirm $HOME/yaourt/yaourt-*-any.pkg.tar.xz

# Cleanup
rm -fr $HOME/package-query $HOME/yaourt
