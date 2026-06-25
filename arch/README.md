# arch

**Status:** Active — pacman-only headless Arch base.

Thin Arch Linux profile: shell, build tools, dotfiles synced via rsync, and slim optional modules. No AUR/paru. Desktops (e.g. XFCE via [`arch_xfce4/`](../arch_xfce4/README.md)) are separate.

---

## Interface

[`dotfiles.sh`](../dotfiles.sh) routes **sync** and **bootstrap** to [`apply.sh`](apply.sh):

| Command | When | What runs |
|---------|------|-----------|
| **sync** | Machine already set up | `apply.sh sync` → [`scripts/sync.sh`](scripts/sync.sh) |
| **bootstrap** | Fresh install | `apply.sh bootstrap` → [`scripts/bootstrap.sh`](scripts/bootstrap.sh) |

```bash
./dotfiles.sh arch sync
./dotfiles.sh arch bootstrap

# or directly:
./arch/apply.sh sync
./arch/apply.sh bootstrap
```

[`apply.sh`](apply.sh) is the sole entry script at the platform root. Sync, bootstrap pipeline, and optional modules live under [`scripts/`](scripts/).

### Bootstrap pipeline

Fixed order — orchestrated by [`scripts/bootstrap.sh`](scripts/bootstrap.sh), invoked via `apply.sh bootstrap`. Do not reorder without updating [`scripts/install/README.md`](scripts/install/README.md) and `scripts/bootstrap.sh`.

```
install/packages.sh → sync.sh → install/postinstall.sh
```

| Step | Script | Role |
|------|--------|------|
| 1 | `install/packages.sh` | Headless base — shell, build tools, rsync |
| 2 | [`scripts/sync.sh`](scripts/sync.sh) | Dotfiles → `$HOME` |
| 3 | `install/postinstall.sh` | **Stub** — optional tuning in `apps/`, `extras/` |

Optional modules under `scripts/` are **not** part of this pipeline.

### Contract test

[`test/contract-test.sh`](../test/contract-test.sh) validates `apply.sh` and bootstrap pipeline scripts. Docker integration: [`test/arch/integration-test.sh`](../test/arch/integration-test.sh).

---

## Install path

Checkout location is flexible — paths resolve relative to the platform root.

```bash
git clone git@github.com:matthewlsawyer/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
./dotfiles.sh arch sync
# ./dotfiles.sh arch bootstrap  # fresh hardware
```

---

## Quick start

| Flow | When | Command |
|------|------|---------|
| **Sync** | System already set up; pull in dotfiles | `./dotfiles.sh arch sync` |
| **Bootstrap** | Fresh Arch install | `./dotfiles.sh arch bootstrap` |

**Prerequisite:** working network before bootstrap.

### Recommended run

After bootstrap, optional internal modules (not part of the interface contract):

```bash
./dotfiles.sh arch bootstrap

cd arch/scripts
./apps/dev.sh && ./apps/browsers.sh
./apps/utilities.sh
./extras/flatpak.sh
```

### Optional modules

Run from `scripts/` after bootstrap — see [scripts/README.md](scripts/README.md).

| Script | Purpose |
|--------|---------|
| `apps/dev.sh` | Docker, Node.js |
| `apps/browsers.sh` | Chromium |
| `apps/media.sh` | ffmpeg |
| `apps/utilities.sh` | htop, iotop, gparted |
| `extras/flatpak.sh` | flatpak (add remotes manually if needed) |
| `extras/keys.sh` | Interactive ssh + gpg key setup |

---

## What's covered

### Dotfiles (`dotfiles/` → `$HOME` via `apply.sh sync`)

- **Shell:** `.zshrc`, `.bashrc`, `.commonrc` — minimal aliases and env (no oh-my-zsh, no AUR helpers)

---

## arch vs arch_xfce4

| | `arch/` | `arch_xfce4/` |
|---|---------|---------------|
| Bootstrap | Pacman-only headless base | Full XFCE workstation + AUR |
| Desktop | None — add separately | XFCE, Compton, Plank, themes |
| Entry | `dotfiles.sh arch sync \| bootstrap` | `dotfiles.sh arch_xfce4 sync \| bootstrap` |

---

## Testing

```bash
cd test && ./contract-test.sh
cd test/arch && ./integration-test.sh      # Docker — arch bootstrap
```

See [test/README.md](../test/README.md).