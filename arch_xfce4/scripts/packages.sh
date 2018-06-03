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

# TODO enable multilib support

## Install libraries needed for video

# Xorg utils for `startx` command and various others
sudo pacman -S --noconfirm xorg-server \
                           xorg-xinit \
                           xorg-apps

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
sudo pacman -S --noconfirm libpulse lib32-libpulse \
                           alsa-plugins lib32-alsa-plugins \
                           alsa-lib lib32-alsa-lib

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
                           git \        # Git will be installed by this point if you are using this repo
                           pygmentize \ # Generic source highlighting
                           docker \
                           aws-cli \
                           redis \
                           tmux \
                           go \
                           python \
                           ruby         # Ruby for Sass install
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

# Install various software and utility programs
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

# Archive programs like 7z, unzip, unrar
sudo pacman -S --noconfirm unzip \
                           p7zip \
                           unrar

# Install packages needed for theming, fonts etc.
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
                           steam-native-runtime \
                           dolphin
yaourt -S --noconfirm sc-controller \
                      steamos-xpad-dkms # xpad kernel module included with Valve's SteamOS

# Stuff for WINE
sudo pacman -S --noconfirm wine-staging \                       # WINE staging, for that bleeding edge
                           winetricks \
                           wine-devel \
                           wine-32bit-devel \
                           giflib lib32-giflib \                # Gif support
                           libpng lib32-libpng \                # PNG support
                           libldap lib32-libldap \              # LDAP, needed for some games in WINE
                           gnutls lib32-gnutls \                # Transport layer, needed for some games in WINE
                           mpg123 lib32-mpg123 \                # MPEG support
                           openal lib32-openal \                # 3D audio
                           v4l-utils lib32-v4l-utils \          # Video 4 linux support
                           libjpeg-turbo lib32-libjpeg-turbo \
                           libxcomposite lib32-libxcomposite \  # X11 Composite extension library
                           libxinerama lib32-libxinerama \      # X11 Xinerama extension library
                           ncurses lib32-ncurses \              # Curses emulation
                           opencl-icd-loader \                  # OpenCL Installable Client Driver (ICD) Loader
                           lib32-opencl-icd-loader \
                           libxslt lib32-libxslt \              # XSLT support
                           libva lib32-libva \                  # Video Acceleration (VA) API for Linux
                           gtk3 lib32-gtk3 \
                           gst-plugins-base-libs \              # GStreamer Multimedia Framework Base Plugin libraries
                           lib32-gst-plugins-base-libs \
                           vulkan-icd-loader \                  # Vulkan Installable Client Driver (ICD) Loader
                           lib32-vulkan-icd-loader \
                           cups \
                           samba \
                           libwbclient lib32-libwbclient \      # Samba winbind client library
                                                                #  Pull in PGP key from PKGBUILD
                           dosbox                               # DOS emulation

# Microsoft fonts for WINE games
yaourt -S --noconfirm ttf-ms-win10

# WINE wrapper useful for managing wine versions and bottles
# sudo pacman -S --noconfirm playonlinux
# yaourt -S --noconfirm q4wine
yaourt -S --noconfig lutris