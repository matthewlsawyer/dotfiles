#!/bin/bash

# This file will grab all of the packages needed for a new install. This file also
# assumes that `yaourt` is installed (for now).

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Append a repo to the end of the pacman conf file
# sudo cat <<EOT >> /etc/pacman.conf

# # Unofficial arch repo
# [archlinuxfr]
# SigLevel = Never
# Server = http://repo.archlinux.fr/$arch
# EOT

# Make sure pacman is up to date
sudo pacman -Syy
sudo pacman -Syu --noconfirm

# Get base-devel and yaourt
# sudo pacman -S --noconfirm base-devel yaourt
# sudo pacman -S git base-devel
# cd /tmp/ && git clone https://aur.archlinux.org/package-query.git \
#   && cd /tmp/package-query && makepkg -si && cd /tmp/ \
#   && git clone https://aur.archlinux.org/yaourt.git \
#   && cd /tmp/yaourt && makepkg -si

# TODO enable multilib support

## Install libraries needed for video

# Xorg utils for `startx` command and various others
sudo pacman -S --noconfirm --needed xorg-server \
                           xorg-xinit \
                           xorg-apps

# Nvidia
sudo pacman -S --noconfirm --needed nvidia \
                           nvidia-libgl \
                           lib32-nvidia-libgl \
                           nvidia-settings

# Set up Xorg file for our nvidia configs
sudo nvidia-xconfig

# Firmware
yaourt -S aic94xx-firmware # SATA port chip
yaourt -S wd719x-firmware  # WD hdd

# Install media players and codecs
sudo pacman -S --noconfirm --needed vlc \
                           ffmpeg \
                           smplayer \
                           ncmpcpp
yaourt -S --noconfirm --needed codecs64

# Install audio packages
sudo pacman -S --noconfirm --needed libpulse lib32-libpulse \
                           alsa-plugins lib32-alsa-plugins \
                           alsa-lib lib32-alsa-lib

# Install XFCE and related packages.
sudo pacman -S --noconfirm --needed xfce4 \
                           thunar-archive-plugin # Right-click menu for unzipping
sudo pacman -S --noconfirm --needed conky                 # Conky
sudo pacman -S --noconfirm --needed plank                 # Plank
sudo pacman -S --noconfirm --needed compton               # Compton will be used for compositing
sudo pacman -S --noconfirm --needed i3lock                # i3lock is used to lock the screen

# Panel plugins
# sudo pacman -S --noconfirm --needed xfce4-cpufreq-plugin
# sudo pacman -S --noconfirm --needed xfce4-datetime-plugin

## Install tools for development

sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed git        # Git will be installed by this point if you are using this repo
sudo pacman -S --noconfirm --needed pygmentize # Generic source highlighting
sudo pacman -S --noconfirm --needed docker \
                           aws-cli \
                           redis \
                           tmux \
                           go \
                           python

sudo pacman -S --noconfirm --needed ruby       # Ruby for Sass install
sudo gem install sass --no-user-install

# MySQL
# sudo pacman -S --noconfirm --needed mariadb
# sudo pacman -S --noconfirm --needed mysql-workbench

# Configure MySQL
# sudo mysql_install_db \
#   --user=mysql \
#   --basedir=/usr \
#   --datadir=/var/lib/mysql             # Install DB
# sudo systemctl start mysqld.service    # Start
# sudo systemctl enable mysqld.service   # Enable

# Node
sudo pacman -S --noconfirm --needed nodejs \
                           npm
sudo npm install -g gulp \
                    less \
                    typescript \
                    @angular/cli

## Install editors

# Atom
# yaourt -S --noconfirm --needed atom-editor
# Atom packages
# apm install atom-beautify
# apm install atom-typescript
# apm install color-picker
# apm install linter
# apm install minimap

# IntelliJ
# sudo pacman -S --noconfirm --needed intellij-idea-community-edition

# VS Code
yaourt -S --noconfirm --needed code

# VS Code extensions
code --install-extension Mikael.angular-beastcode              # Angular snippets
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension PeterJausovec.vscode-docker           # Docker
code --install-extension EditorConfig.editorconfig             # Editorconfig
code --install-extension eamodio.gitlens                       # Gitlens
code --install-extension ms-vscode.go                          # Go
code --install-extension redhat.java                           # Java
code --install-extension yzhang.markdown-all-in-one            # Markdown
code --install-extension ms-python.python                      # Python
code --install-extension robinbentley.sass-indented            # Sass
code --install-extension eg2.tslint                            # tslint
code --install-extension rbbit.typescript-hero                 # Typescript

# Install various software and utility programs
sudo pacman -S --noconfirm --needed htop \
                           iotop \
                           powertop \
                           atop
sudo pacman -S --noconfirm --needed lm_sensors      # Fans and PWM sensors
sudo pacman -S --noconfirm --needed hardinfo
sudo pacman -S --noconfirm --needed lvm2
sudo pacman -S --noconfirm --needed brasero         # Disc burnings
sudo pacman -S --noconfirm --needed viewnior        # Image viewer
sudo pacman -S --noconfirm --needed rsync           # File syncing
sudo pacman -S --noconfirm --needed imagemagick     # Image conversion
sudo pacman -S --noconfirm --needed scrot           # Screenshots
sudo pacman -S --noconfirm --needed google-chrome \
                           firefox
sudo pacman -S --noconfirm --needed lesspipe        # Less utilities
sudo pacman -S --noconfirm --needed bluez           # Bluetooth
sudo pacman -S --noconfirm --needed bluez-plugins \
                           bluez-utils
sudo pacman -S --noconfirm --needed transmission-qt # Torrents
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed tilix           # Tiling terminal emulator
yaourt -S --noconfirm --needed etcher               # SD card writer
# yaourt -S --noconfirm --needed android-file-transfer-linux-git

# Zsh
sudo pacman -S --noconfirm --needed zsh \
                           zsh-completions

# Archive programs like 7z, zip, rar
sudo pacman -S --noconfirm --needed unzip \
                           p7zip \
                           unrar

# Install packages needed for theming, fonts etc.
sudo pacman -S --noconfirm --needed adobe-source-sans-pro-fonts \
                           adobe-source-code-pro-fonts \
                           ttf-droid \
                           ttf-fira-mono \
                           awesome-terminal-fonts
yaourt -S --noconfirm --needed otf-fira-code \
                      ttf-fira-code \
                      awesome-terminal-fonts-patched

# Install packages used for gaming
sudo pacman -S --noconfirm --needed steam \
                           steam-native-runtime \
                           dolphin \
                           retroarch
yaourt -S --noconfirm --needed sc-controller \
                      steamos-xpad-dkms # Xpad kernel module included with Valve's SteamOS

# Stuff for WINE
sudo pacman -S --noconfirm --needed wine-staging                       # WINE staging, for that bleeding edge
sudo pacman -S --noconfirm --needed winetricks
sudo pacman -S --noconfirm --needed wine-devel \
                           wine-32bit-devel
sudo pacman -S --noconfirm --needed giflib lib32-giflib                # Gif support
sudo pacman -S --noconfirm --needed libpng lib32-libpng                # PNG support
sudo pacman -S --noconfirm --needed libldap lib32-libldap              # LDAP, needed for some games in WINE
sudo pacman -S --noconfirm --needed gnutls lib32-gnutls                # Transport layer, needed for some games in WINE
sudo pacman -S --noconfirm --needed mpg123 lib32-mpg123                # MPEG support
sudo pacman -S --noconfirm --needed openal lib32-openal                # 3D audio
sudo pacman -S --noconfirm --needed v4l-utils lib32-v4l-utils          # Video 4 linux support
sudo pacman -S --noconfirm --needed libjpeg-turbo lib32-libjpeg-turbo
sudo pacman -S --noconfirm --needed libxcomposite lib32-libxcomposite  # X11 Composite extension library
sudo pacman -S --noconfirm --needed libxinerama lib32-libxinerama      # X11 Xinerama extension library
sudo pacman -S --noconfirm --needed ncurses lib32-ncurses              # Curses emulation
sudo pacman -S --noconfirm --needed opencl-icd-loader                  # OpenCL Installable Client Driver (ICD) Loader
sudo pacman -S --noconfirm --needed lib32-opencl-icd-loader
sudo pacman -S --noconfirm --needed libxslt lib32-libxslt              # XSLT support
sudo pacman -S --noconfirm --needed libva lib32-libva                  # Video Acceleration (VA) API for Linux
sudo pacman -S --noconfirm --needed gtk3 lib32-gtk3
sudo pacman -S --noconfirm --needed gst-plugins-base-libs              # GStreamer Multimedia Framework Base Plugin libraries
sudo pacman -S --noconfirm --needed lib32-gst-plugins-base-libs
sudo pacman -S --noconfirm --needed vulkan-icd-loader                  # Vulkan Installable Client Driver (ICD) Loader
sudo pacman -S --noconfirm --needed lib32-vulkan-icd-loader
sudo pacman -S --noconfirm --needed cups
sudo pacman -S --noconfirm --needed samba \
                           libwbclient lib32-libwbclient      # Samba winbind client library
                                                              #  Pull in PGP key from PKGBUILD
sudo pacman -S --noconfirm --needed dosbox                             # DOS emulation

# Microsoft fonts for WINE games
yaourt -S --noconfirm --needed ttf-ms-fonts # This is deprecated but there's no better solution for now

# WINE wrapper useful for managing wine versions and bottles
# sudo pacman -S --noconfirm --needed playonlinux
# yaourt -S --noconfirm --needed q4wine
yaourt -S --noconfirm --needed lutris