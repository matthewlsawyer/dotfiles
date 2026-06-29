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

NVIDIA (optional): `arch_xfce4/scripts/system/graphics-nvidia.sh`

## This machine

- WiFi USB `wlp0s26u1u2` — `192.168.1.69`
- Intel TearFree — `files/etc/X11/xorg.conf.d/20-intel.conf`
- Disks: [disk-layout.md](disk-layout.md)

## Post-install

Bootstrap adds the install user to the `input` group and refreshes fontconfig — see [postinstall.sh](../../arch_xfce4/scripts/bootstrap/postinstall.sh).

Display → Power Manager → "Blank after" → Never.

```bash
sudo hdparm -B 255 /dev/sdb
sudo hdparm -B 255 /dev/sdc
```

**lm_sensors / fancontrol** — see [lm_sensors and fancontrol](#lm_sensors-and-fancontrol) below.

**Hibernate** — see [Hibernate (GRUB resume)](#hibernate-grub-resume) below.

## lm_sensors and fancontrol

Intel DX79TO board. Optional packages: run `arch_xfce4/scripts/apps/utilities.sh` (includes `lm_sensors`) or `sudo pacman -S lm_sensors`.

References: [Arch lm_sensors](https://wiki.archlinux.org/title/Lm_sensors), [fan speed control](https://wiki.archlinux.org/title/Fan_speed_control).

### 1. GRUB kernel parameters

Add to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub` (combine with `resume=UUID=...` from [hibernate setup](#hibernate-grub-resume) if enabled):

```text
acpi_enforce_resources=lax pcie_aspm=force i915.i915_enable_rc6=1
```

Regenerate GRUB and reboot:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### 2. Load sensor modules

```bash
sudo modprobe nct6775
sudo modprobe i2c-i801
sudo modprobe w83627ehf
sudo sensors-detect --auto
```

Create `/etc/modules-load.d/sensors.conf`:

```text
coretemp
nct6775
w83627ehf
i2c-i801
```

```bash
sudo systemctl restart systemd-modules-load.service
```

Verify: `sensors` should show temps and fan RPMs.

### 3. DX79TO sensor mapping

| Reading | Points to |
|---------|-----------|
| `temp1_input` | SYSTIN (system) |
| `temp2_input` | CPUTIN (CPU) |
| `fan1_input` | Front fans |
| `fan2_input` | CPU fan |
| `fan3_input` | Rear fan |

### 4. Fan curve (`pwmconfig`)

```bash
sudo pwmconfig
```

`pwmconfig` writes `/etc/fancontrol`. Confirm fan↔PWM pairings in the prompts using the [DX79TO mapping](#3-dx79to-sensor-mapping) above.

Tune for Noctua fans — edit the generated file and adjust paths to match your `pwmconfig` output (example from this board):

```text
MINTEMP=hwmon1/pwm2=20 hwmon1/pwm1=20 hwmon1/pwm3=20
MAXTEMP=hwmon1/pwm2=60 hwmon1/pwm1=60 hwmon1/pwm3=60
MINSTART=hwmon1/pwm2=40 hwmon1/pwm1=40 hwmon1/pwm3=40
MINSTOP=hwmon1/pwm2=20 hwmon1/pwm1=20 hwmon1/pwm3=20
MINPWM=hwmon1/pwm2=20 hwmon1/pwm1=20 hwmon1/pwm3=20
```

Enable the service:

```bash
sudo systemctl enable --now fancontrol.service
```

Check: `sensors`, `systemctl status fancontrol`, listen for fan speed changes under load.

## Hibernate (GRUB resume)

Hibernate saves RAM to swap and powers off. On resume, the kernel reloads RAM from that swap partition. This machine uses LVM swap at `/dev/hdd_vg/swap_lv` (8G — see [disk-layout.md](disk-layout.md)).

**Prerequisite:** swap size must be **≥ installed RAM**. With 8G swap, hibernate only works if the machine has 8G RAM or less. If RAM is larger, enlarge `swap_lv` before enabling hibernate.

### 1. Get the swap UUID

```bash
sudo blkid /dev/hdd_vg/swap_lv
```

Copy the `UUID=` value from the output (example placeholder: `UUID=a1b2c3d4-e5f6-7890-abcd-ef1234567890`).

### 2. Enable the resume hook in initramfs

Edit `/etc/mkinitcpio.conf` — add `resume` to `HOOKS` after `udev` and before `filesystems`:

```text
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt resume filesystems fsck)
```

Regenerate initramfs:

```bash
sudo mkinitcpio -P
```

### 3. Tell GRUB which swap holds the hibernation image

Edit `/etc/default/grub` — append `resume=UUID=<swap-lv-uuid>` to `GRUB_CMDLINE_LINUX_DEFAULT` (keep existing options):

```text
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=<swap-lv-uuid>"
```

Regenerate GRUB config:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### 4. Test

Save all work first — hibernate powers off the machine.

```bash
systemctl hibernate
```

Power on; the session should restore. If the machine cold-boots instead, recheck UUID, `resume` hook, and that swap ≥ RAM.

### Rollback

Remove `resume=UUID=...` from `/etc/default/grub`, remove `resume` from `HOOKS`, then:

```bash
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
