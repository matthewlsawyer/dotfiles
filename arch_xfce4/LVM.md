# LVM configuration — arch_xfce4

Pattern: one volume group for SSDs, one for HDDs, logical volumes per mount point. Boot stays outside LVM.

```
/dev/sda1 -- 512M   # /boot
```

## Physical volumes

**ssd_vg** (solid state):

```
/dev/sda2 -- ~120G
/dev/sdd  -- ~250G
```

**hdd_vg** (hard disks):

```
/dev/sdb -- ~750G
/dev/sdc -- ~750G
```

## Logical volumes

```
# SSD
root_lv     -- ssd_vg -- 20G    # TODO: 20G is too small
var_lv      -- ssd_vg -- 40G
sdata_lv    -- ssd_vg -- ~300G

# HDD
home_lv     -- hdd_vg -- 500G
swap_lv     -- hdd_vg -- 8G
data_lv     -- hdd_vg -- ~1T
```

## Mount points

```
/       -- root_lv
/var    -- var_lv
/home   -- home_lv
/data   -- data_lv
/sdata  -- sdata_lv
swap    -- swap_lv
```

## Sample fstab

Use `blkid` after partitioning to fill in UUIDs.

```bash
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
#
UUID=<home-lv-uuid> /home ext4 defaults,noatime 0 0
UUID=<swap-lv-uuid> swap swap defaults 0 0
UUID=<var-lv-uuid> /var ext4 defaults,noatime 0 0
UUID=<data-lv-uuid> /data ext4 defaults,noatime 0 0
UUID=<root-lv-uuid> / ext4 defaults,noatime 0 1
UUID=<sdata-lv-uuid> /sdata ext4 defaults,noatime 0 0
UUID=<boot-partition-uuid> /boot ext4 defaults,noatime,discard 0 0
```
