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
├── scripts/         # optional — machine-only scripts (same tier names as profiles)
│   ├── lib/init.sh  # path vars (when apply.sh present)
│   ├── bootstrap/   # machine-only pipeline steps
│   ├── apps/        # machine-only optional apps
│   ├── extras/      # machine-only optional extras
│   └── system/      # machine-only OS/DE/hardware tweaks
├── dotfiles/        # optional — third rsync layer (host apply only)
└── files/etc/       # optional — manual copy to / (never auto-deployed)
```

New host: pick name (no collision with profile dirs), add `profile` manifest, move machine-specific files out of the profile.

## Pipeline overrides

Edit `bootstrap_pipeline` in the host's `apply.sh` to add, remove, or reorder bootstrap steps. Profile scripts use `DOTFILES_SCRIPTS_ROOT`; host-only steps can reference `DOTFILES_HOST_ROOT/scripts/bootstrap/…`.

Example — generic macOS profile bootstrap uses only `Brewfile.bootstrap` via `packages.sh`; host-specific apps live in `hosts/<name>/Brewfile.apps`.

Post-bootstrap optional hints in `apply.sh` should list scripts **not** already in the host pipeline. Hosts may also add machine-only optional scripts under `hosts/<name>/scripts/{apps,extras,system}/` and reference them from README or apply hints.
