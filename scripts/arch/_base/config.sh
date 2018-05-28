#!/bin/bash

# Initialize the new system with some basics, such as networking and package
# management

# Disable the internal PC speaker, cause it's super annoying
rmmod pcspkr
sudo touch /etc/modprobe.d/nobeep.conf
echo 'blacklist pcspkr' | sudo tee /etc/modprobe.d/nobeep.conf > /dev/null

# Start up the networking service
sudo systemctl start dhcpcd@eno1.service
sudo systemctl enable dhcpcd@eno1.service
