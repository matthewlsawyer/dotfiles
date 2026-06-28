# pi-omv

Raspberry Pi NAS host — machine-specific notes for this box.

**Profile:** `pi_omv` — see [pi_omv/README.md](../../pi_omv/README.md) for full Pi + OMV procedure.

## Rebuild

```bash
./dotfiles.sh pi-omv bootstrap   # prints runbook pointers (no apply.sh yet)
```

Follow [pi_omv/README.md](../../pi_omv/README.md), then apply [disk-layout.md](disk-layout.md).

## This machine

- Three-disk `main-vg` layout — see [disk-layout.md](disk-layout.md)
- Install `openmediavault-lvm` plugin before applying LVM config
