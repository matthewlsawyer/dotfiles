#!/bin/bash

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Create initial ramdisk environment
sudo mkinitcpio -P

# Override xflock4 with our customized version
sudo chmod 755 ~/.bin/xflock4
sudo ln -sf -t /usr/local/bin ~/.bin/xflock4

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