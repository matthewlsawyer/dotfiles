#!/bin/bash

# This script installs zsh and oh-my-zsh and all the plugins we want for it. Installing
# zsh is a manual process so this script should be done independently.

. sudov.sh
. functions.sh

# Zsh
pinstall zsh zsh-completions

# Oh-my-zsh
# Don't use the AUR here because the PKGBUILD puts it in /usr/share/oh-my-zsh/
#  which is inconvenient for installing plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Oh-my-zsh plugins
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
