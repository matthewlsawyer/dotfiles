# hosts

Machine-specific config — not generic runbooks. Each host points at a profile via `profile` file.

```bash
./dotfiles.sh arch-desktop bootstrap   # host apply.sh — overrides arch_xfce4
./dotfiles.sh macbook-pro-m1 bootstrap # host apply.sh — full pipeline + 3-layer sync
```

## Hosts

| Host | Profile | What's here |
|------|---------|-------------|
| [arch-desktop/](arch-desktop/) | `arch_xfce4` | LVM, static network, Intel Xorg, post-install notes |
| [pi-omv/](pi-omv/) | `pi_omv` | NAS disk layout |
| [macbook-pro-m1/](macbook-pro-m1/) | `macos` | M1 post-bootstrap notes |

## Layout per host

```
hosts/<name>/
├── profile          # one line — profile dir name
├── README.md        # rebuild steps, machine notes
├── disk-layout.md   # optional — disks / LVM
├── apply.sh         # optional — overrides profile apply.sh explicitly (no delegate)
├── scripts/lib/init.sh  # optional — host path vars (when apply.sh present)
├── dotfiles/        # optional — third rsync layer (host apply only)
└── files/etc/       # optional — manual copy to / (never auto-deployed)
```

New host: pick name (no collision with profile dirs), add `profile` manifest, move machine-specific files out of the profile.
