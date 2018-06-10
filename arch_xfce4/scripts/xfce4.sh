#!/bin/bash

# This file will grab XFCE and related packages.

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo pacman -S --noconfirm --needed -q xfce4
sudo pacman -S --noconfirm --needed -q thunar-archive-plugin  # Right-click menu for unzipping
sudo pacman -S --noconfirm --needed -q compton                # Compton will be used for compositing

# Panel plugins
# sudo pacman -S --no-confirm --needed xfce4-cpufreq-plugin
# sudo pacman -S --no-confirm --needed xfce4-datetime-plugin