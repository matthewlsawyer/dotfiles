#!/bin/bash

# This file grabs all of the base16 themes we want for our various apps
# and configures them.

# Shell
# git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
# Default to using Ocean
# source ~/.config/base16-shell/scripts/base16_ocean.sh

# Tilix
mkdir -p ~/.config/tilix/
git clone https://github.com/karlding/base16-tilix.git ~/.config/tilix/base16
mkdir -p ~/.config/tilix/schemes
ln -sf ~/.config/tilix/base16/tilix/*.json ~/.config/tilix/schemes/
# Tilix dconf is configured to use Ocean
dconf load /com/gexperts/Tilix/ < ~/.config/tilix/tilix.dconf

# Xfce4
mkdir -p ~/.local/share/xfce4/terminal/
git clone https://github.com/afg984/base16-xfce4-terminal.git ~/.local/share/xfce4/terminal/base16
mkdir -p ~/.local/share/xfce4/terminal/colorschemes/
ln -sf ~/.local/share/xfce4/terminal/base16/colorschemes/*.theme ~/.local/share/xfce4/terminal/colorschemes/
# The ~/.config/xfce4/terminal/terminalrc file is configured to use Ocean

# Xresources
mkdir -p ~/.config/Xresources/
git clone https://github.com/chriskempson/base16-xresources.git ~/.config/Xresources/base16
# Default to using Ocean
xrdb -merge ~/.config/Xresources/base16/xresources/base16-ocean-256.Xresources
