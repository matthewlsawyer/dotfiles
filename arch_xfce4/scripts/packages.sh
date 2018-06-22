#!/bin/bash

# This file will grab all of the packages needed for a new install.

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Enable multilib support
if [[ -z "$(grep -n "^\[multilib\]" /etc/pacman.conf)" ]]; then
    echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee --append /etc/pacman.conf > /dev/null
fi

# Make sure pacman is up to date
sudo pacman -Syy
sudo pacman -Syu --noconfirm

# Helper install functions
function pinstall() {
    sudo pacman -S --noconfirm --needed -q $@
}

function yinstall() {
    yaourt -S --noconfirm --needed $@
}

## Networking
pinstall networkmanager \
            network-manager-applet

## Install libraries needed for video

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
pinstall libpulse lib32-libpulse \
            alsa-plugins lib32-alsa-plugins \
            alsa-lib lib32-alsa-lib

pinstall pavucontrol

pinstall plank                  # Plank
pinstall conky                  # Conky
# yinstall polybar-git            # Polybar

## Install tools for development

pinstall vim
pinstall git            # Git will be installed by this point if you are using this repo
pinstall pygmentize     # Generic source highlighting
pinstall docker \
            aws-cli \
            redis \
            tmux \
            go \
            python \
            jq

pinstall ruby         # Ruby for Sass install
pinstall ruby-sass    # Sass
# sudo gem install sass --no-user-install

# MySQL
# pinstall mariadb
# pinstall mysql-workbench

# Configure MySQL
# sudo mysql_install_db \
#   --user=mysql \
#   --basedir=/usr \
#   --datadir=/var/lib/mysql             # Install DB
# sudo systemctl start mysqld.service    # Start
# sudo systemctl enable mysqld.service   # Enable

# Node
pinstall nodejs \
            npm
sudo npm install -g gulp \
                    less \
                    typescript \
                    @angular/cli

## Install editors

# Atom
# yinstall atom-editor
# Atom packages
# apm install atom-beautify
# apm install atom-typescript
# apm install color-picker
# apm install linter
# apm install minimap

# IntelliJ
# pinstall intellij-idea-community-edition

# VS Code
yinstall visual-studio-code-bin

# VS Code extensions
code --install-extension mikael.angular-beastcode               # Angular
code --install-extension PeterJausovec.vscode-docker            # Docker
code --install-extension EditorConfig.editorconfig              # Editorconfig
code --install-extension ms-vscode.go                           # Go
code --install-extension redhat.java                            # Java
code --install-extension yzhang.markdown-all-in-one             # Markdown
code --install-extension ms-python.python                       # Python
code --install-extension robinbentley.sass-indented             # Sass
code --install-extension rbbit.typescript-hero                  # Typescript
code --install-extension ms-vscode.csharp                       # C#
code --install-extension eg2.tslint
code --install-extension ajhyndman.jslint
# Commented because it's disruptive
# code --install-extension eamodio.gitlens
# code --install-extension streetsidesoftware.code-spell-checker

# Install various software and utility programs
pinstall htop \
            iotop \
            powertop \
            atop
pinstall pacman-contrib
pinstall lm_sensors         # Fans and PWM sensors
pinstall hardinfo
pinstall lvm2
pinstall brasero            # Disc burnings
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
pinstall transmission-qt    # Torrents -- use blocklist https://silo.glasz.org/antip2p.list.gz a daily updated
                            #  dump of I-Blocklist by https://github.com/glaszig
pinstall gparted
pinstall tilix              # Tiling terminal emulator
pinstall filezilla
pinstall gnuplot
pinstall youtube-dl
pinstall file-roller

# Commenting these for now because they take forever
# yinstall google-chrome
# yinstall etcher             # SD card writer
# yinstall android-file-transfer-linux-git

# Archive programs like 7z, zip, rar
pinstall unzip \
            p7zip \
            unrar

# Install packages needed for theming, fonts etc. The package
#  `ttf-google-fonts-typewolf` provides the following:
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

yinstall elementary-xfce-icons-git
pinstall arc-gtk-theme

# Install packages used for gaming
pinstall steam \
            steam-native-runtime \
            dolphin-emu \
            retroarch
yinstall sc-controller \
            steamos-xpad-dkms               # Xpad kernel module included with Valve's SteamOS

# Emulators
#  Make sure to add user to the `games` group
#  Might need to receive key for ncurses dependency
yinstall epsxe

# Might need to receive key
yinstall discord

# Stuff for WINE
pinstall wine-staging-nine                  # WINE staging with the gallium-nine patches, for that bleeding edge
pinstall winetricks
pinstall giflib lib32-giflib                # Gif support
pinstall libpng lib32-libpng                # PNG support
pinstall libldap lib32-libldap              # LDAP, needed for some games in WINE
pinstall gnutls lib32-gnutls                # Transport layer, needed for some games in WINE
pinstall mpg123 lib32-mpg123                # MPEG support
pinstall openal lib32-openal                # 3D audio
pinstall v4l-utils lib32-v4l-utils          # Video 4 linux support
pinstall libjpeg-turbo lib32-libjpeg-turbo
pinstall libxcomposite lib32-libxcomposite  # X11 Composite extension library
pinstall libxinerama lib32-libxinerama      # X11 Xinerama extension library
pinstall ncurses lib32-ncurses              # Curses emulation
pinstall opencl-icd-loader                  # OpenCL Installable Client Driver (ICD) Loader
pinstall lib32-opencl-icd-loader
pinstall libxslt lib32-libxslt              # XSLT support
pinstall libva lib32-libva                  # Video Acceleration (VA) API for Linux
pinstall gtk3 lib32-gtk3
pinstall gst-plugins-base-libs              # GStreamer Multimedia Framework Base Plugin libraries
pinstall lib32-gst-plugins-base-libs
pinstall vulkan-icd-loader                  # Vulkan Installable Client Driver (ICD) Loader
pinstall lib32-vulkan-icd-loader
pinstall cups
pinstall samba
pinstall libwbclient                        # Samba winbind client library -- might need to pull in PGP key from PKGBUILD
# yinstall lib32-libwbclient                  # Multilib samba winbind client library
pinstall dosbox                             # DOS emulation

# Microsoft fonts for WINE games
# This is deprecated but there's no better solution for now
yinstall ttf-ms-fonts

# WINE wrapper useful for managing wine versions and bottles
# pinstall playonlinux
# yinstall q4wine
yinstall lutris

unset -f pinstall
unset -f yinstall
