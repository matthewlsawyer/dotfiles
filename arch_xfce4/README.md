# arch_xfce4

Arch/Antergos installation running XFCE.

---

## Initial setup

To start networking, run the following command.

```bash
sudo systemctl start dhcpcd@eno1.service
```

---

## LVM configuration

Below is a breakdown of the LVM configuration based on my current disk setup. In general the pattern I follow
is a single volume group for all hard disks and another one for all solid state disks, and then logical volumes
for each mount point I intend to add.

Make sure `boot` is located outside of the LVM config.

```
/dev/sda1 -- 512M
```

### LVM physical volumes

The solid state disks will be put into a "ssd_vg" `volume group`.

```
/dev/sda2 -- ~120G
/dev/sdd  -- ~250G
```

The hard disks will be put into a "hdd_vg" `volume group`.

```
/dev/sdb -- ~750G
/dev/sdc -- ~750G
```

### LVM logical volumes

These basically follow the mount points but define which volume group they should live on.

```
# On the SSD
root_lv     -- ssd_vg -- 20G    # TODO: 20G is too small
var_lv      -- ssd_vg -- 40G
sdata_lv    -- ssd_vg -- ~300G  # The remaining space on ssd_vg

# On the HDD
home_lv     -- hdd_vg -- 500G
swap_lv     -- hdd_vg -- 8G
data_lv     -- hdd_vg -- ~1T    # The remaining space on hdd_vg
```

### Mount points

Again, just follow the logical volumes here.

```
/       -- root_lv
/var    -- var_lv
/home   -- home_lv
/data   -- data_lv
/sdata  -- sdata_lv
swap    -- swap_lv
```

### Sample fstab

```bash
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
#
UUID=18760778-9f4d-449b-92af-578369c5d0e0 /home ext4 defaults,noatime 0 0
UUID=3883f240-59f3-4335-818e-0db935495c13 swap swap defaults 0 0
UUID=deada21c-3b47-48a8-89a4-87d07d126008 /var ext4 defaults,noatime 0 0
UUID=b89b8e48-deb7-4160-8109-4c35b1b57c31 /data ext4 defaults,noatime 0 0
UUID=106fb8dc-c4f7-4762-bcc7-12dcddfe2575 / ext4 defaults,noatime 0 1
UUID=c05ae092-cce8-4a2a-944d-06363e2c8425 /sdata ext4 defaults,noatime 0 0
UUID=738fb1df-ba2d-4afb-be18-aae8f4442bd8 /boot ext4 defaults,noatime,discard 0 0
```

---

## Testing

You can test all the scripts in a Docker container by running the following commands from the root directory of the project.

```bash
docker build -t arch_xfce4_test -f arch_xfce4/test/Dockerfile .
docker run -it arch_xfce4_test /bin/bash

# Or if you want it running detached
docker run -itd arch_xfce4_test /bin/bash
docker exec -ti $container_id /bin/bash
```

Once you are in the container you can run whichever script you want to test.

```bash
cd arch_xfce4/scripts
./packages.sh
```

Keep in mind that the container can get pretty big, up to around 8G so far in my testing.

---

## Settings

### Display

Turn off display sleep by going to "Settings" > "Power Manager" > "Display" and setting "Blank after" to "Never".

### Hard drives

To reduce hard drive clicking, turn off power management on the hard disk drives.

```bash
# Set the power consumption up to 255 which disables APM
#  preventing the drive from parking its heads
sudo hdparm -B 255 /dev/sdb
sudo hdparm -B 255 /dev/sdc
```
