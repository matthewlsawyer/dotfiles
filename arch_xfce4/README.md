# arch_xfce4

These exist for an Arch install running the Xfce4 desktop environment. The `packages.sh` file shows all of the
software that will be installed but below are some highlights:

* Diplay -- X, nvidia
* Media -- ffmpeg, smplayer, ncmpcpp
* Desktop -- Xfce4, Plank, Compton
* Development -- vim, git, docker, node
* Gaming -- wine, Steam

## Initial setup

To start networking, run the following command.

```bash
sudo systemctl start dhcpcd@eno1.service
```

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
root_lv     -- ssd_vg -- 20G
sdata_lv    -- ssd_vg -- ~300G  # The remaining space on ssd_vg

# On the HDD
var_lv      -- hdd_vg -- 20G
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
