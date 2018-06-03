#!/bin/bash

# This file will be run after the `packages.sh` file is done. This should be used
# to start up services, create symlinks, setup configurations etc.

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Clear font cache
fc-cache -f

# Enable bluetooth service
# sudo systemctl start bluetooth.service
# sudo systemctl enable bluetooth.service

# Create initial ramdisk environment
# There is also a pacman hook that will run this after every nvidia update
sudo mkinitcpio -P

# Override xflock4 with our customized version
sudo chmod 755 ~/.local/bin/xflock4
sudo mv /usr/local/bin/xflock4 /usr/local/bin/xflock4.bak
sudo ln -s -t /usr/local/bin ~/.local/bin/xflock4

# Symlink in our pacman hooks
sudo mkdir -p /etc/pacman.d/hooks
sudo ln -s -t /etc/pacman.d/hooks ~/.local/etc/pacman.d/hooks/nvidia.hook

# To get lm_sensors to work you need to follow these steps:
# 1. Add `acpi_enforce_resources=lax` to the following line in `/etc/default/grub`
#    GRUB_CMDLINE_LINUX_DEFAULT="resume=UUID=287db681-1c61-476b-919a-dde223abe55f quiet"
#    GRUB_CMDLINE_LINUX_DEFAULT="resume=UUID=287db681-1c61-476b-919a-dde223abe55f quiet acpi_enforce_resources=lax"
# 2. Reconfig grub with the changes
#    grub-mkconfig -o /boot/grub/grub.cfg
# i. Reboot
# 3. Install fan driver module
#    sudo modprobe w83627ehf
# 4. Run `lm_sensors` setup
#    sudo sensors-detect --auto
# 5. Create the file `/etc/modules-load.d/load_these.conf` with the following lines
#    coretemp
#    w83627ehf
# 6. Restart the module loading service
#    sudo systemctl restart systemd-modules-load.service
# 7. Run the fan config program
#    sudo pwnconfig
# i. Example configs for sane defaults of the Noctua fan series
#    MINTEMP=hwmon1/device/pwm2=20 hwmon1/device/pwm1=20
#    MAXTEMP=hwmon1/device/pwm2=60 hwmon1/device/pwm1=60
#    MINSTART=hwmon1/device/pwm2=40 hwmon1/device/pwm1=40
#    MINSTOP=hwmon1/device/pwm2=20 hwmon1/device/pwm1=20
#    MINPWM=hwmon1/device/pwm2=20 hwmon1/device/pwm1=20
# 8. Enable and start the service
#    sudo systemctl enable fancontrol.service
#    sudo systemctl start fancontrol.service
# For more info see https://wiki.archlinux.org/index.php/lm_sensors
# and https://wiki.archlinux.org/index.php/fan_speed_control#fancontrol