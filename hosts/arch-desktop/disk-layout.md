# arch-desktop — disk layout

Two VGs: SSDs (`ssd_vg`), HDDs (`hdd_vg`). `/boot` outside LVM.

## Layout

| Device | Size | Role |
|--------|------|------|
| `/dev/sda1` | 512M | `/boot` |
| `/dev/sda2` | ~120G | `ssd_vg` PV |
| `/dev/sdd` | ~250G | `ssd_vg` PV |
| `/dev/sdb` | ~750G | `hdd_vg` PV |
| `/dev/sdc` | ~750G | `hdd_vg` PV |

| LV | VG | Size | Mount |
|----|-----|------|-------|
| `root_lv` | ssd_vg | 50G | `/` |
| `var_lv` | ssd_vg | 40G | `/var` |
| `sdata_lv` | ssd_vg | ~280G | `/sdata` |
| `home_lv` | hdd_vg | 500G | `/home` |
| `swap_lv` | hdd_vg | 8G | swap |
| `data_lv` | hdd_vg | ~1T | `/data` |

`ssd_vg` totals ~370G (50+40+280). `root_lv` 50G — headroom for kernels and system packages; `/var` is separate.

## fstab

Fill UUIDs from `blkid`:

```
UUID=<root-lv>  /       ext4 defaults,noatime 0 1
UUID=<boot>     /boot   ext4 defaults,noatime,discard 0 0
UUID=<var-lv>   /var    ext4 defaults,noatime 0 0
UUID=<home-lv>  /home   ext4 defaults,noatime 0 0
UUID=<data-lv>  /data   ext4 defaults,noatime 0 0
UUID=<sdata-lv> /sdata  ext4 defaults,noatime 0 0
UUID=<swap-lv>  swap    swap defaults 0 0
```
