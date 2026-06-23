# LVM configuration — pi_omv

Make sure to start by installing the `openmediavault-lvm` plugin.

Below is a breakdown of the LVM configuration based on my current disk setup. In general the pattern I follow
is a single volume group for all of the hard disks, and then logical volumes for each mount point I intend to add.
Since we are using openmediavault then I can put them all into a single logical volume and OMV will mount the
various points via configuration.

## Physical volumes

The hard disks will be put into a "main-vg" `volume group`.

```
/dev/sda -- ~930G
/dev/sdb -- ~930G
/dev/sdc -- ~3.64T
```

## Logical volumes

Use a single logical volume that OMV will use to mount.

```
main-lv  -- main-vg -- ~5.5T # The entire space on main-vg
```
