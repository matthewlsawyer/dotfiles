#!/bin/bash

# This file will cleanup after the install.

. sudov.sh

# Remove unused packages
sudo pacman -Rns $(pacman -Qtdq)

# Remove cache of all but latest version of package and all cache from uninstalled packages
sudo paccache -rk1 -ruk0
