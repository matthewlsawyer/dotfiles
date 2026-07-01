# pi-omv

Raspberry Pi NAS host — machine-specific notes for this box.

**Profile:** `pi_omv` — see [pi_omv/README.md](../../pi_omv/README.md) for Pi + OMV procedure.

## Rebuild

```bash
./dotfiles.sh pi-omv bootstrap   # profile apply.sh (manifest-only host — no hosts/pi-omv/apply.sh)
```

Then complete manual steps in [pi_omv/README.md](../../pi_omv/README.md) (raspi-config, adduser) and apply [disk-layout.md](disk-layout.md) via OMV UI.

## This machine

- Three-disk `main-vg` layout — see [disk-layout.md](disk-layout.md)
- Install `openmediavault-lvm` plugin before applying LVM config
