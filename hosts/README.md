# hosts

Machine-specific config — not generic runbooks. Each host points at a profile via `profile` file.

```bash
./dotfiles.sh arch-desktop bootstrap   # reads profile → runs arch_xfce4 + overlay
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
├── dotfiles/        # optional — rsync overlay after profile
└── files/etc/       # optional — manual copy to / (never auto-deployed)
```

New host: pick name (no collision with profile dirs), add `profile` manifest, move machine-specific files out of the profile.
