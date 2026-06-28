# shared

Cross-profile dotfiles and install libs. Synced/sourced by Linux profiles — not a `dotfiles.sh` target.

## dotfiles/

| File | Role |
|------|------|
| `.commonrc` | Base shell aliases, PATH, EDITOR — sources `~/.commonrc.local` after sync |

Profile overlays live in `<profile>/dotfiles/.commonrc.local` (e.g. `BROWSER`, XDG dirs).

## scripts/lib/

| File | Role |
|------|------|
| `sudov.sh` | Keep sudo creds alive during long installs |
| `pacman.sh` | `pinstall()` — sourced by arch / arch_xfce4 `functions.sh` |

Rsync order: `shared/dotfiles/` → profile `dotfiles/` → `$HOME` (profile wins on conflicts).
