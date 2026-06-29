# shared

Cross-profile dotfiles and install helpers. Dotfiles synced to `$HOME`; profile scripts run from the repo — not a `dotfiles.sh` target.

## dotfiles/

| Path | Role |
|------|------|
| `.commonrc` | Thin loader — glob-sources `~/.commonrc.d/*.sh` in lexical order |
| `.commonrc.d/` | Ordered shell fragments (see layering below) |
| `.local/bin/` | Reserved scaffolding for future profile executables (on PATH via `init.sh`; rsync'd to `~/.local/bin` with exec bit preserved) |

## rc file contract

Profiles and hosts **own their entry rc files** (`.bashrc` / `.zshrc` / `.zprofile`), which **override wholesale** down the chain (same filename = later layer replaces the whole file, no merge). To **layer** config shared → profile → host, an rc file must `. ~/.commonrc` and place fragments in `~/.commonrc.d/` (`NN-` prefixed by layer). `.commonrc` is the only additive path; cross-platform guarding lives in `00-base.sh` so it applies to every layer below.

Two mechanisms:

- **Entry rc files** — owned per layer, wholesale override. A layer ships one only to own that shell's startup.
- **`.commonrc.d/` fragments** — additive merge by filename, later wins (`00-base` shared, `50-profile`, `90-host`).

An rc file that does **not** source `~/.commonrc` silently opts out of all shared → profile → host layering.

macOS sources `.commonrc` via `macos/dotfiles/.zshrc` (Linux profiles use `.bashrc`/`.zshrc`).

**Fragment layering** (source order, later wins on conflicts):

| Prefix | Layer | Repo path | Target |
|--------|-------|-----------|--------|
| `00-` | shared | `shared/dotfiles/.commonrc.d/00-base.sh` | `~/.commonrc.d/00-base.sh` |
| `50-` | profile | `<profile>/dotfiles/.commonrc.d/50-profile.sh` | `~/.commonrc.d/50-profile.sh` |
| `90-` | host | `hosts/<name>/dotfiles/.commonrc.d/90-host.sh` | `~/.commonrc.d/90-host.sh` |

Fragments from each layer merge additively via the wholesale `dotfiles/` rsync (distinct filenames = no clobber).

## scripts/lib/

| File | Role |
|------|------|
| `sudov.sh` | Keep sudo creds alive during long installs (arch profiles) |

## Install contract

Profiles that install packages define install helpers in their own `scripts/lib/` — not in `shared/`.

| Profile | Implementation | File |
|---------|----------------|------|
| `arch`, `arch_xfce4` | `pkg_install`: pacman; `aur_install`: yaourt (AUR) | `<profile>/scripts/lib/functions.sh` |
| `macos` | `brew install` inline in install/app scripts | — |

**Contract:** arch profiles source `functions.sh` and call `pkg_install <packages…>`. macOS scripts call `brew install` directly. Pass-through args (`--cask`, etc.) are profile-specific. Package names are **not** shared across profiles.

`aur_install()` (yaourt) is defined alongside `pkg_install()` in each profile's `functions.sh` — pending replacement with paru/yay per MODERNIZATION P0.

Duplicating `functions.sh` across `arch` and `arch_xfce4` is intentional; each profile is self-contained.

**Rsync order:** `shared/dotfiles/` → profile `dotfiles/` → (host `dotfiles/` when host `apply.sh` runs) → `$HOME`. Later layers win on conflicts. Executables under `dotfiles/.local/bin/` are rsync'd separately (without `--no-perms`) to `~/.local/bin/` so the committed exec bit is preserved.
