#!/bin/bash

# This file is responsible for configuring and setting up samba.

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo pacman -S --noconfirm --needed samba \
                                    smbclient \
                                    cifs-utils
sudo pacman -S --noconfirm --needed gvfs gvfs-smb

# Get samba configuration
sudo wget -O smb.conf -P /etc/samba/ \
    "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD"

# Enable the cifs module
sudo modprobe cifs

# sudo mount -t cifs //$server/Public /mnt/path/to/Public -o user=$user,uid=$user,gid=users
