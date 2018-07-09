#!/bin/bash

# This file should be used to start up networking and other things that are 
# useful to do up-front, before installing a bunch of packages.

. sudov.sh

# Disable the internal PC speaker, cause it's super annoying
if [[ "$(modinfo pcspkr)" != "modinfo: ERROR: Module alias pcspkr not found." ]]; then
    sudo rmmod pcspkr
    sudo touch /etc/modprobe.d/nobeep.conf
    echo 'blacklist pcspkr' | sudo tee /etc/modprobe.d/nobeep.conf > /dev/null
fi

# Start up the networking service
# if [[ "$(systemctl is-active dhcpcd@eno1.service)" == "inactive" ]]; then
#     sudo systemctl start dhcpcd@eno1.service
#     sudo systemctl enable dhcpcd@eno1.service
# fi
if [[ "$(systemctl is-active NetworkManager.service)" == "inactive" ]]; then
    sudo systemctl start NetworkManager.service
    sudo systemctl enable NetworkManager.service
fi
