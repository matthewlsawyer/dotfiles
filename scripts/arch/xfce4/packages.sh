#!/bin/bash

# Install XFCE and related packages.
sudo pacman -S --noconfirm xfce4 \
                           thunar-archive-plugin \ # Right-click menu for unzipping
                           xfce4-sensors-plugin \
                           plank \                 # Plank
                           compton \               # Compton will be used for compositing
                           i3lock \                # i3lock is used to lock the screen
# Panel plugins
# sudo pacman -S --noconfirm xfce4-cpufreq-plugin
# sudo pacman -S --noconfirm xfce4-datetime-plugin