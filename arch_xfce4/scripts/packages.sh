#!/bin/bash

# This file will grab all of the packages needed for a new install.

. sudov.sh

# Enable multilib support
if [[ -z "$(grep -n "^\[multilib\]" /etc/pacman.conf)" ]]; then
    echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee --append /etc/pacman.conf > /dev/null
fi

# Make sure pacman is up to date
sudo pacman -Syy
sudo pacman -Syu --noconfirm

. functions.sh

# Networking
pinstall networkmanager network-manager-applet

##
## Install libraries needed for video and audio
##

# Xorg utils for `startx` command and various others
pinstall xorg-server \
            xorg-xinit \
            xorg-apps

# Nvidia
pinstall nvidia \
            nvidia-utils \
            lib32-nvidia-utils \
            nvidia-settings

# Make sure nvidia-utils is already installed or else
#  there's a prompt for which version of the dependency
pinstall nvidia-libgl \
            lib32-nvidia-libgl

# Firmware
yinstall aic94xx-firmware # SATA port chip
yinstall wd719x-firmware  # WD HDDs

# Initramfs
pinstall mkinitcpio

# Install media players and codecs
pinstall vlc \
            ffmpeg \
            smplayer \
            ncmpcpp
yinstall codecs64

# Install audio packages
pinstall pulseaudio libpulse lib32-libpulse \
            alsa-plugins lib32-alsa-plugins \
            alsa-lib lib32-alsa-lib

pinstall pavucontrol

pinstall plank
pinstall conky
#yinstall polybar-git

##
## Install tools for development
##

pinstall vim
pinstall git
# Generic source highlighting
pinstall pygmentize
pinstall docker \
            aws-cli \
            redis \
            tmux \
            go \
            python \
            jq

# Ruby for Sass install
pinstall ruby ruby-sass

# MySQL
#pinstall mariadb
#pinstall mysql-workbench

# Configure MySQL
#sudo mysql_install_db \
#   --user=mysql \
#   --basedir=/usr \
#   --datadir=/var/lib/mysql
#sudo systemctl start mysqld.service
#sudo systemctl enable mysqld.service

# Node
pinstall nodejs npm
sudo npm install -g gulp less
sudo npm install -g typescript @angular/cli
sudo npm install -g tslint eslint jslint

# PhantomJS -- used by youtube-dl
sudo npm install -g phantomjs@2.1.1 --unsafe-perm

##
## Install editors and plugins
##

# Atom
# yinstall atom-editor
# Atom packages
#apm install atom-beautify
#apm install atom-typescript
#apm install color-picker
#apm install linter
#apm install minimap

# IntelliJ
#pinstall intellij-idea-community-edition

# VS Code
yinstall visual-studio-code-bin

# VS Code extensions
code --install-extension mikael.angular-beastcode               # Angular
code --install-extension PeterJausovec.vscode-docker            # Docker
code --install-extension EditorConfig.editorconfig              # Editorconfig
code --install-extension ms-vscode.go                           # Go
code --install-extension redhat.java                            # Java
code --install-extension mathiasfrohlich.kotlin                 # Kotlin
code --install-extension yzhang.markdown-all-in-one             # Markdown
code --install-extension ms-python.python                       # Python
code --install-extension robinbentley.sass-indented             # Sass
code --install-extension rbbit.typescript-hero                  # Typescript
code --install-extension eg2.vscode-npm-script                  # NPM
code --install-extension ms-vscode.csharp                       # C#
code --install-extension eg2.tslint
code --install-extension ajhyndman.jslint
code --install-extension dbaeumer.vscode-eslint
# Commented because they're disruptive
#code --install-extension eamodio.gitlens
#code --install-extension streetsidesoftware.code-spell-checker

##
## Install various software and utility programs
##

pinstall htop \
            iotop \
            powertop \
            atop
pinstall pacman-contrib
pinstall lm_sensors         # Fans and PWM sensors
pinstall hardinfo
pinstall lvm2
pinstall viewnior           # Image viewer
pinstall rsync              # File syncing
pinstall imagemagick        # Image conversion
pinstall scrot              # Screenshots
pinstall firefox
pinstall chromium
pinstall lesspipe           # Less utilities
pinstall bluez              # Bluetooth
pinstall bluez-plugins \
            bluez-utils
# Torrents -- use blocklist https://silo.glasz.org/antip2p.list.gz a daily updated
#  dump of I-Blocklist by https://github.com/glaszig
pinstall transmission-qt
pinstall gparted
pinstall tilix              # Tiling terminal emulator
pinstall filezilla
pinstall gnuplot
pinstall youtube-dl
pinstall file-roller
pinstall bookworm           # PDF reader
pinstall alacarte           # Menu editor

# Night mode
pinstall geoclue2
pinstall redshift

# HD tools
pinstall hdparm
pinstall smartmontools

# WhatsApp client
yinstall whatsie
# Spotify client
yinstall spotify

# Commenting these for now because they take forever
#yinstall google-chrome
# SD card writer
#yinstall etcher
#yinstall android-file-transfer-linux-git

# Removed because it depends on "tracker" which I don't want
# Disc burning
#pinstall brasero

# Archive programs like 7z, zip, rar
pinstall unzip \
            p7zip \
            unrar

##
## Install packages needed for theming, fonts etc.
##

# The package `ttf-google-fonts-typewolf` provides the following:
# ttf-fira-sans
# otf-fira-sans
# adobe-source-sans-pro-fonts
pinstall ttf-google-fonts-typewolf \
            adobe-source-code-pro-fonts \
            ttf-droid \
            ttf-fira-code \
            otf-fira-code \
            ttf-fira-mono \
            otf-fira-mono \
            awesome-terminal-fonts
yinstall awesome-terminal-fonts-patched

# Install packages used for gaming
pinstall steam \
            steam-native-runtime \
            dolphin-emu \
            retroarch
# Xpad kernel module included with Valve's SteamOS
yinstall sc-controller steamos-xpad-dkms

# Emulators
#  Make sure to add user to the `games` group
#  Might need to receive key for ncurses dependency
yinstall epsxe

# Might need to receive key
yinstall discord
