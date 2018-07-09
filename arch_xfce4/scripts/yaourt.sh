#!/bin/bash

# This script will install yaourt if it is not already installed.

# First check if yaourt is installed
if pacman -Qs yaourt > /dev/null ; then
    return
fi

. sudov.sh

# Grab dependencies for package-query
sudo pacman -Sy --noconfirm --needed -q yajl

# Make package-query
cd $HOME \
    && git clone https://aur.archlinux.org/package-query.git \
    && cd $HOME/package-query \
    && makepkg -s
sudo pacman -U --noconfirm --needed $HOME/package-query/package-query-*-x86_64.pkg.tar.xz

# Make yaourt
cd $HOME \
    && git clone https://aur.archlinux.org/yaourt.git \
    && cd $HOME/yaourt \
    && makepkg -s
sudo pacman -U --noconfirm --needed $HOME/yaourt/yaourt-*-any.pkg.tar.xz

# Cleanup
rm -fr $HOME/package-query $HOME/yaourt
