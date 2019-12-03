#!/bin/bash

# This file will be run after the `packages.sh` file is done. This should be used
# to start up services, create symlinks, setup configurations etc.

. sudov.sh

# Clear font cache
fc-cache -f

# Enable bluetooth service
# sudo systemctl start bluetooth.service
# sudo systemctl enable bluetooth.service

# Set up Xorg file for our nvidia configs
sudo nvidia-xconfig

# Create initial ramdisk environment
#  There is also a pacman hook that will run this after every nvidia update
sudo mkinitcpio -P

# Override xflock4 with our customized version
# sudo ln -s -t /usr/local/bin ~/.local/bin/xflock4

# Symlink in our pacman hooks
sudo mkdir -p /etc/pacman.d/hooks
sudo ln -s -t /etc/pacman.d/hooks ~/.local/etc/pacman.d/hooks/nvidia.hook

# To get lm_sensors to work you need to follow these steps:
# 1. Add `acpi_enforce_resources=lax` and `pcie_aspm=force i915.i915_enable_rc6=1` to the following line in `/etc/default/grub`
#       GRUB_CMDLINE_LINUX_DEFAULT="resume=UUID=287db681-1c61-476b-919a-dde223abe55f quiet"
#       GRUB_CMDLINE_LINUX_DEFAULT="resume=UUID=287db681-1c61-476b-919a-dde223abe55f quiet acpi_enforce_resources=lax pcie_aspm=force i915.i915_enable_rc6=1"
# 2. Reconfig grub with the changes
#       grub-mkconfig -o /boot/grub/grub.cfg
# a. Reboot
# 3. Install fan driver module
#       modprobe nct6775
#       modprobe i2c-i801
#       modprobe w83627ehf
# 4. Run `lm_sensors` setup
#       sudo sensors-detect --auto
# 5. Create the file `/etc/modules-load.d/load_these.conf` with the following lines
#       coretemp
#       nct6775
#       w83627ehf
#       i2c-i801
# 6. Restart the module loading service
#       sudo systemctl restart systemd-modules-load.service
# 7. Run the fan config program
#       sudo pwmconfig
# a. Example configs for sane defaults of the Noctua fan series in /etc/fancontrol
# b. For the Intel DX79TO temp1_input points to SYSTIN while temp2_input points to CPUTIN
# c. In this case fan1_input is the front fans, fan2_input the CPU fan, and fan3_input is the back fan
# 8. Enable and start the service
#       sudo systemctl start fancontrol.service
#       sudo systemctl enable fancontrol.service
# For more info see https://wiki.archlinux.org/index.php/lm_sensors
#  and https://wiki.archlinux.org/index.php/fan_speed_control#fancontrol

# Enable a weekly package cleanup
sudo systemctl enable paccache.timer
sudo systemctl start paccache.timer

# Fix grub and tty resolution
# 1. Add the following line in `/etc/default/grub`
#    GRUB_GFXMODE=1920x1080,1024x768,auto
#    GRUB_GFXPAYLOAD_LINUX=1920x1080
# 2. Make sure to add the lvm module
#    GRUB_PRELOAD_MODULES="part_gpt part_msdos lvm"
# 3. Reconfig grub with the changes
#    grub-mkconfig -o /boot/grub/grub.cfg

# Generate your keys
ssh-keygen
gpg --full-gen-key

# To export your GPG key you can use:
# gpg --list-keys
# gpg --armor --export $key

# To import keys, use:
# gpg --recv-keys $key

# Kernel 4.18 is dumb and added native Steam controller support that breaks everything
# so let's remove that shit here
# The following command shows that the steam controller is registered as both itself and
# a "Microsoft X-Box 360 pad"
# cat /proc/bus/input/devices
sudo modprobe -r hid_steam
echo 'blacklist hid_steam' | sudo tee /etc/modprobe.d/sc.conf > /dev/null

# Add user to docker group
sudo usermod -aG docker $USER

# Add user to input group
sudo usermod -aG input $USER
