# shared

Cross-profile dotfiles and install libs. Dotfiles synced to `$HOME`; profile scripts source their own libs from the repo — not a `dotfiles.sh` target.

## dotfiles/

| File | Role |
|------|------|
| `.commonrc` | Base shell aliases, PATH, EDITOR — sources `~/.commonrc.local` after sync |

Profile overlays live in `<profile>/dotfiles/.commonrc.local` (e.g. `BROWSER`, XDG dirs).

## scripts/lib/

| File | Role |
|------|------|
| `sudov.sh` | Keep sudo creds alive during long installs (arch profiles) |

## Install contract

Profiles that install packages define `pkg_install()` in their own `scripts/lib/` — not in `shared/`.

| Profile | Implementation | File |
|---------|----------------|------|
| `arch`, `arch_xfce4` | `sudo pacman -S --noconfirm --needed -q "$@"` | `<profile>/scripts/lib/pacman.sh` |
| `macos` | `brew install "$@"` | `macos/scripts/lib/brew.sh` |

**Contract:** install scripts source `functions.sh` and call `pkg_install <packages…>`. Pass-through args (`--cask`, etc.) are profile-specific. Package names are **not** shared across profiles.

`arch_xfce4` also defines `yinstall()` for AUR (yaourt) — outside this contract.

Duplicating `pacman.sh` across `arch` and `arch_xfce4` is intentional; each profile is self-contained.

Rsync order: `shared/dotfiles/` → profile `dotfiles/` → (host `dotfiles/` when host `apply.sh` runs) → `$HOME`. Later layers win on conflicts.
