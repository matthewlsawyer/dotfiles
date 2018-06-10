# arch_xfce4

These exist for an Arch install running the xfce4 desktop environment. The `packages.sh` file shows all of the software that will be installed but below are some highlights:

* Diplay -- X, nvidia
* Media -- ffmpeg, smplayer, ncmpcpp
* Desktop -- Xfce4, Plank, Compton
* Development -- vim, git, docker, node
* Gaming -- wine, Steam

## LVM configuration

Below is a breakdown of the LVM configuration based on my current disk setup. In general the pattern I follow
is a single volume group for all hard disks and another one for all solid state disks, and then logical volumes
for each mount point I intend to add.

### LVM physical volumes

The solid state disks will be put into a "sdd-vg" `volume group`.

```
/dev/sda -- ~120G
/dev/sdd -- ~250G
```

The hard disks will be put into a "hdd-vg" `volume group`.

```
/dev/sdb -- ~750G
/dev/sdc -- ~750G
```

### LVM logical volumes

These basically follow the mount points but define which volume group they should live on.

```
# On the SDD
root-lv     -- sdd-vg -- 20G
boot-lv     -- sdd-vg -- 512M
s-data-lv   -- sdd-vg -- ~300G  # The remaining space on sdd-vg

# On the HDD
var-lv      -- hdd-vg -- 20G
tmp-lv      -- hdd-vg -- 4G
home-lv     -- hdd-vg -- 500G
data-lv     -- hdd-vg -- ~1T    # The remaining space on hdd-vg
```

### Mount points

Again, just follow the logical volumes here.

```
/       -- root-lv
/boot   -- boot-lv
/var    -- var-lv
/tmp    -- tmp-lv
/home   -- home-lv
/data   -- data-lv
/sdata  -- s-data-lv
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

Once you are in the container you will want to kick off the `entrypoint.sh` script.

```bash
./entrypoint.sh arch_xfce4
```

Keep in mind that the container can get pretty big, up to around 8G so far in my testing.
