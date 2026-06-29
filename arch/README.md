# arch

**Active** — pacman-only headless Arch. No AUR. Desktop: [`arch_xfce4/`](../arch_xfce4/README.md).

## Commands

```bash
./dotfiles.sh arch sync
./dotfiles.sh arch bootstrap
```

**Prerequisite:** network before bootstrap.

## Bootstrap pipeline

```
bootstrap/installer.sh → bootstrap/packages.sh → run_sync → bootstrap/postinstall.sh
```

## After bootstrap

```bash
cd arch/scripts
./apps/dev.sh && ./apps/browsers.sh && ./apps/utilities.sh
./extras/flatpak.sh
```

## Dotfiles

Shell — shared `.commonrc` (loads `~/.commonrc.d/`) + profile `.commonrc.d/50-profile.sh` (minimal aliases, chromium browser).

## vs arch_xfce4

| | `arch` | `arch_xfce4` |
|---|--------|--------------|
| Scope | Headless base | XFCE + AUR workstation |
| Desktop | None | XFCE, Compton, Plank |
