# arch_xfce4

**Planned** — contract-tested but stale stack. [MODERNIZATION.md](../MODERNIZATION.md)

XFCE workstation profile. Host overlay: [hosts/arch-desktop/](../hosts/arch-desktop/).

## Commands

```bash
./dotfiles.sh arch_xfce4 sync
./dotfiles.sh arch_xfce4 bootstrap
./dotfiles.sh arch-desktop bootstrap   # profile + host overlay
```

**Prerequisite:** network before bootstrap (configure during base Arch install or via NetworkManager).

## Pipeline

```
install/installer.sh → install/packages.sh → install/desktop.sh → sync.sh → install/postinstall.sh
```

Details: [scripts/install/README.md](scripts/install/README.md)

## After bootstrap

```bash
cd arch_xfce4/scripts
./hardware/graphics-nvidia.sh    # optional — NVIDIA hardware
./apps/dev.sh && ./apps/utilities.sh
```

Copy host system files: [hosts/arch-desktop/](../hosts/arch-desktop/). Optional modules: [scripts/README.md](scripts/README.md)

## Dotfiles

Shell (shared `.commonrc` + `.commonrc.local`), XFCE/Compton/Plank, Tilix, VS Code settings, NVIDIA pacman hook.

## Notes

- `postinstall.sh` runs interactive `ssh-keygen` / `gpg --full-gen-key`
- LVM layout: [hosts/arch-desktop/disk-layout.md](../hosts/arch-desktop/disk-layout.md)
- Stack dated: yaourt, compton, powerlevel9k — see MODERNIZATION P0
