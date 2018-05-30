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

# Get the base-devel group and yaourt
# sudo pacman -S --noconfirm base-devel \
#                            yaourt

## Install libraries needed for video

# Xorg utils for `startx` command
sudo pacman -S --noconfirm xorg-server \
                           xorg-server-utils \
                           xorg-utils

# Nvidia
sudo pacman -S --noconfirm nvidia \
                           nvidia-libgl \
                           lib32-nvidia-libgl \
                           nvidia-settings

# Set up Xorg file for our nvidia configs
sudo nvidia-xconfig

# Firmware
yaourt -S aic94xx-firmware \ # SATA port chip
          wd719x-firmware    # WD hdd

# Install media players and codecs
sudo pacman -S --noconfirm vlc \
                           ffmpeg \
                           smplayer \
                           ncmpcpp
yaourt -S --noconfirm codecs64

# Install audio packages
sudo pacman -S --noconfirm lib32-libpulse \
                           lib32-alsa-plugins

# Install XFCE and related packages.
sudo pacman -S --noconfirm xfce4 \
                           thunar-archive-plugin \ # Right-click menu for unzipping
                           conky \                 # Conky
                           plank \                 # Plank
                           compton \               # Compton will be used for compositing
                           i3lock                  # i3lock is used to lock the screen

# Panel plugins
# sudo pacman -S --noconfirm xfce4-cpufreq-plugin
# sudo pacman -S --noconfirm xfce4-datetime-plugin

## Install tools for development

sudo pacman -S --noconfirm vim \
                           git \                   # Git will be installed by this point if you are using this repo
                           source-highlight \      # Used in the LESSOPEN env var
                           pygmentize \            # Generic source highlighting
                           docker \
                           go \
                           ruby                    # Ruby for Sass install
sudo gem install sass --no-user-install

# MySQL
# sudo pacman -S --noconfirm mariadb
# sudo pacman -S --noconfirm mysql-workbench

# Configure MySQL
# sudo mysql_install_db \
#   --user=mysql \
#   --basedir=/usr \
#   --datadir=/var/lib/mysql             # Install DB
# sudo systemctl start mysqld.service    # Start
# sudo systemctl enable mysqld.service   # Enable

# Node
sudo pacman -S --noconfirm nodejs \
                           npm
sudo npm install -g gulp \
                    less \
                    typescript \
                    @angular/cli

## Install editors

# Atom
# yaourt -S --noconfirm atom-editor
# Atom packages
# apm install atom-beautify
# apm install atom-typescript
# apm install color-picker
# apm install linter
# apm install minimap

# IntelliJ
# sudo pacman -S --noconfirm intellij-idea-community-edition

# VS Code
yaourt -S --noconfirm code

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

## Install various software and utility programs

sudo pacman -S --noconfirm htop \
                           iotop \
                           powertop \
                           atop \
                           lm_sensors \      # Fans and PWM sensors
                           hardinfo \
                           lvm2 \
                           brasero \         # Disc burnings
                           viewnior \        # Image viewer
                           rsync \           # File syncing
                           imagemagick \     # Image conversion
                           scrot \           # Screenshots
                           google-chrome \
                           firefox \
                           lesspipe \        # Less utilities
                           bluez \           # Bluetooth
                           bluez-plugins \
                           bluez-utils \
                           transmission-qt \ # Torrents
                           gparted \
                           tilix             # Tiling terminal emulator
yaourt -S --noconfirm etcher                 # SD card writer

# yaourt -S --noconfirm android-file-transfer-linux-git

# Zsh
sudo pacman -S --noconfirm zsh \
                           zsh-completions
# Oh-my-zsh
source ./oh-my-zsh.sh

# Archive programs like 7z, unzip, unrar
sudo pacman -S --noconfirm unzip \
                           p7zip \
                           unrar

## Install packages needed for theming, fonts etc.

sudo pacman -S --noconfirm adobe-source-sans-pro-fonts \
                           adobe-source-code-pro-fonts \
                           ttf-droid \
                           ttf-fira-mono \
                           awesome-terminal-fonts
yaourt -S --noconfirm otf-fira-code \
                      ttf-fira-code \
                      awesome-terminal-fonts-patched

# Install packages used for gaming.
sudo pacman -S --noconfirm steam \
                           steam-native-runtime

# Stuff for WINE
sudo pacman -S --noconfirm wine-staging \          # WINE staging, for that bleeding edge
                           lib32-libldap \         # LDAP, needed for some games in WINE
                           lib32-gnutls            # Transport layer, needed for some games in WINE

# Microsoft fonts for WINE games
yaourt -S --noconfirm ttf-ms-fonts

# Samba winbind client library
# yaourt -S --noconfirm lib32-libwbclient # pull in pgp key from PKGBUILD

# WINE wrapper useful for managing wine versions and bottles
# sudo pacman -S --noconfirm playonlinux
# yaourt -S --noconfirm q4wine