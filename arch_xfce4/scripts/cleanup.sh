#!/bin/bash

# This file will cleanup after the install.

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Remove unused packages
sudo pacman -Rns $(pacman -Qtdq)

# Remove cache of all but latest version of package and all cache from uninstalled packages
sudo paccache -rk1 -ruk0
