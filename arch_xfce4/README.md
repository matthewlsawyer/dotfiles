# arch_xfce4

**Planned** — contract-tested but stale stack. [MODERNIZATION.md](../MODERNIZATION.md)

XFCE workstation profile. Host overlay: [hosts/arch-desktop/](../hosts/arch-desktop/).

## Commands

```bash
./dotfiles.sh arch_xfce4 sync
./dotfiles.sh arch_xfce4 bootstrap
./dotfiles.sh arch-desktop bootstrap   # host apply.sh — see hosts/arch-desktop/
```

**Prerequisite:** network before bootstrap (configure during base Arch install or via NetworkManager).

## Bootstrap pipeline

```
install/installer.sh → install/packages.sh → install/desktop.sh → run_sync → install/postinstall.sh
```

## After bootstrap

```bash
cd arch_xfce4/scripts
./hardware/graphics-nvidia.sh    # optional — NVIDIA hardware
./apps/dev.sh && ./apps/utilities.sh
```

Copy host system files: [hosts/arch-desktop/](../hosts/arch-desktop/).

## Dotfiles

Shell (shared `.commonrc` + `.commonrc.local`), XFCE/Compton/Plank, Tilix, VS Code settings, NVIDIA pacman hook.

## Notes

- SSH/GPG keys — optional `./scripts/extras/keys.sh` after bootstrap
- LVM layout: [hosts/arch-desktop/disk-layout.md](../hosts/arch-desktop/disk-layout.md)
- Stack dated: yaourt, compton, powerlevel9k — see MODERNIZATION P0
