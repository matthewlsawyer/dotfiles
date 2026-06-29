# arch_xfce4

**Active** — contract-tested; bootstrap uses PipeWire, paru, picom. [MODERNIZATION.md](../MODERNIZATION.md)

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
bootstrap/installer.sh → bootstrap/packages.sh (PipeWire) → bootstrap/desktop.sh → run_sync → bootstrap/postinstall.sh
```

## After bootstrap

```bash
cd arch_xfce4/scripts
./system/graphics-nvidia.sh    # optional — NVIDIA hardware
./system/themes.sh             # optional — Arc GTK theme (AUR)
./system/icons.sh              # optional — elementary-xfce icon theme (AUR)
./system/fonts.sh              # optional — Typewolf fonts, patched terminal fonts, Nerd Fonts
./system/post-desktop-cleanup.sh  # optional — paccache timer + cache trim
./apps/dev.sh && ./apps/utilities.sh
./extras/flatpak.sh
```

Copy host system files: [hosts/arch-desktop/](../hosts/arch-desktop/).

## Dotfiles

Shell (shared `.commonrc` + `.commonrc.d/50-profile.sh`), XFCE/picom/Plank, Tilix, VS Code settings, NVIDIA pacman hook.

## Notes

- SSH/GPG keys — optional `../../shared/scripts/extras/keys.sh` after bootstrap
- Shell prompt — optional `./system/zsh.sh` installs oh-my-zsh + powerlevel10k (dotfiles `.zshrc` / `.powerlevelrc` synced at bootstrap)
- LVM layout: [hosts/arch-desktop/disk-layout.md](../hosts/arch-desktop/disk-layout.md)
- Docker validation: `cd test/arch_xfce4 && ./integration-test.sh`
