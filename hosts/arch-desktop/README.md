# arch-desktop

**Profile:** `arch_xfce4` — [arch_xfce4/README.md](../../arch_xfce4/README.md)

## Rebuild

```bash
./dotfiles.sh arch-desktop bootstrap
```

After bootstrap:

```bash
sudo cp hosts/arch-desktop/files/etc/systemd/network/51-static.network /etc/systemd/network/
sudo cp hosts/arch-desktop/files/etc/X11/xorg.conf.d/20-intel.conf /etc/X11/xorg.conf.d/
```

NVIDIA (optional): `arch_xfce4/scripts/hardware/graphics-nvidia.sh`

## This machine

- WiFi USB `wlp0s26u1u2` — `192.168.1.69`
- Intel TearFree — `files/etc/X11/xorg.conf.d/20-intel.conf`
- Disks: [disk-layout.md](disk-layout.md)

## Post-install

Display → Power Manager → "Blank after" → Never.

```bash
sudo hdparm -B 255 /dev/sdb
sudo hdparm -B 255 /dev/sdc
```

GRUB resume, lm_sensors, fancontrol — see `arch_xfce4/scripts/install/postinstall.sh` comments.
