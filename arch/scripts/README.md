# scripts/ (internal)

Not entry points — use [`dotfiles.sh`](../dotfiles.sh) or [`apply.sh`](../apply.sh).

## Pipeline

```
install/packages.sh → sync.sh → install/postinstall.sh
```

See [install/README.md](install/README.md).

## Optional modules

Run from `scripts/` after bootstrap:

| Script | Purpose |
|--------|---------|
| `apps/dev.sh` | Docker, Node.js |
| `apps/browsers.sh` | Chromium |
| `apps/media.sh` | ffmpeg |
| `apps/utilities.sh` | htop, iotop, gparted |
| `extras/flatpak.sh` | flatpak |
| `extras/keys.sh` | ssh + gpg key setup |
