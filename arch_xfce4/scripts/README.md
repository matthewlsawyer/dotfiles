# scripts/ (internal)

Not entry points — use [`dotfiles.sh`](../dotfiles.sh) or [`apply.sh`](../apply.sh).

## Pipeline

```
install/installer.sh → install/packages.sh → install/desktop.sh → sync.sh → install/postinstall.sh
```

See [install/README.md](install/README.md).

## Optional modules

Run from `scripts/` after bootstrap:

**hardware/**

| Script | Purpose |
|--------|---------|
| `graphics-nvidia.sh` | NVIDIA driver, nvidia-xconfig, pacman hook |
| `firmware-extra.sh` | aic94xx, wd719x firmware |
| `bluetooth.sh` | bluez |
| `nobeep.sh` | blacklist pcspkr |

**apps/**

| Script | Purpose |
|--------|---------|
| `dev.sh` | VS Code, Docker, Node |
| `media.sh` | VLC, ffmpeg, smplayer |
| `browsers.sh` | Firefox, Chromium |
| `utilities.sh` | htop, tilix, transmission, gparted |
| `games.sh` | WINE, Lutris, Steam |

**desktop/**

| Script | Purpose |
|--------|---------|
| `zsh.sh` | zsh, oh-my-zsh, powerlevel9k |
| `fonts.sh` | Nerd Fonts |
| `base16.sh` | Base16 Ocean theme |
| `flatpak.sh` | flatpak + Flathub |
| `samba.sh` | Samba + gvfs-smb |
| `budgie.sh` | Budgie DE (TODO: relocate) |
| `cleanup.sh` | paccache trim |
