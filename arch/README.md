# arch

**Active** — pacman-only headless Arch. No AUR. Desktop: [`arch_xfce4/`](../arch_xfce4/README.md).

## Commands

```bash
./dotfiles.sh arch sync
./dotfiles.sh arch bootstrap
```

**Prerequisite:** network before bootstrap.

## Pipeline

```
install/packages.sh → sync.sh → install/postinstall.sh
```

Details: [scripts/install/README.md](scripts/install/README.md)

## After bootstrap

```bash
cd arch/scripts
./apps/dev.sh && ./apps/browsers.sh && ./apps/utilities.sh
./extras/flatpak.sh
```

Optional modules: [scripts/README.md](scripts/README.md)

## Dotfiles

Shell — shared `.commonrc` + profile `.commonrc.local` (minimal aliases, chromium browser).

## vs arch_xfce4

| | `arch` | `arch_xfce4` |
|---|--------|--------------|
| Scope | Headless base | XFCE + AUR workstation |
| Desktop | None | XFCE, Compton, Plank |
