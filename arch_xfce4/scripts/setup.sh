#!/bin/bash

# This file should be used to start up networking and other things that are 
# useful to do up-front, before installing a bunch of packages.

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable the internal PC speaker, cause it's super annoying
sudo rmmod pcspkr
sudo touch /etc/modprobe.d/nobeep.conf
echo 'blacklist pcspkr' | sudo tee /etc/modprobe.d/nobeep.conf > /dev/null

# Start up the networking service
if [[ "$(systemctl is-active dhcpcd@eno1.service)" == "inactive" ]]; then
    sudo systemctl start dhcpcd@eno1.service
    sudo systemctl enable dhcpcd@eno1.service
fi
