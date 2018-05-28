#!/bin/bash

# Make sure pacman is up to date
sudo pacman -Syy --noconfirm
sudo pacman -Syu --noconfirm

# Get the base-devel group
sudo pacman -S --noconfirm base-devel

# Get yaourt
# Append a repo to the end of the pacman conf file
# TODO fix this
cat <<EOT >> /etc/pacman.conf

# Unofficial arch repo
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
EOT
sudo pacman -S --noconfirm yaourt

# Install libraries needed for video
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

# Install video players and codecs
sudo pacman -S --noconfirm vlc \
                           ffmpeg \
                           smplayer
yaourt -S --noconfirm codecs64

# Install audio packages
sudo pacman -S --noconfirm lib32-libpulse \
                           lib32-alsa-plugins

# Install XFCE and related packages.
sudo pacman -S --noconfirm xfce4 \
                           thunar-archive-plugin \ # Right-click menu for unzipping
                           lm_sensors \
                           xfce4-sensors-plugin \
                           plank \                 # Plank
                           compton \               # Compton will be used for compositing
                           i3lock \                # i3lock is used to lock the screen
# Panel plugins
# sudo pacman -S --noconfirm xfce4-cpufreq-plugin
# sudo pacman -S --noconfirm xfce4-datetime-plugin

# Install tools for development
sudo pacman -S --noconfirm vim \
                           git \
                           source-highlight \
                           docker \
                           ruby \
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

# Install editors
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
yaourt -S --noconfirm visual-studio-code

# Install various software and utility programs
sudo pacman -S --noconfirm htop \
                           iotop \
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
                           zsh \
                           zsh-completions \
                           gparted
yaourt -S --noconfirm oh-my-zsh-git \
                      etcher                 # SD card writer

# yaourt -S --noconfirm android-file-transfer-linux-git

# Enable bluetooth service
# TODO move this into postinstall script
# sudo systemctl start bluetooth.service
# sudo systemctl enable bluetooth.service

# Archive programs like 7z, unzip, unrar
sudo pacman -S --noconfirm unzip \
                           p7zip \
                           unrar

# Install packages needed for theming, fonts etc.
sudo pacman -S --noconfirm ttf-google-fonts
yaourt -S --noconfirm otf-fira-code \
                      otf-fira-mono \
                      otf-fira-sans

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