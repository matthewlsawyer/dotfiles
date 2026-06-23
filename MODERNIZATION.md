# Modernization Backlog

Prioritized list of updates before running stale scripts on real hardware. READMEs document what exists today; this file tracks what needs to change.

---

## P0 — before arch_xfce4 revival

These block a safe rebuild on current Arch:

| Item | Current | Target | Files affected |
|------|---------|--------|----------------|
| AUR helper | yaourt + package-query | paru or yay | `scripts/install/installer.sh`, `scripts/lib/functions.sh`, `.yaourtrc` |
| Compositor | compton | picom | `scripts/install/desktop.sh`, `dotfiles/.config/compton.conf`, autostart desktop file |
| Script flow | — | tiered optional modules | `scripts/README.md`, `bootstrap.sh` |
| Flash | pepper-flash | removed (EOL) | — |
| youtube-dl | — | yt-dlp | `scripts/apps/utilities.sh` (if re-added) |

---

## P1 — macOS refresh

| Item | Current | Target | Files affected |
|------|---------|--------|----------------|
| Package manifest | inline `brew install` | Brewfile | `macos/scripts/apps/*.sh` |
| Cask syntax | `brew cask install` | `brew install --cask` | `macos/scripts/apps/*.sh` |
| Homebrew install | legacy Ruby one-liner | official install script; Apple Silicon note | `macos/scripts/install/installer.sh` |
| AWS CLI | v1 bundled zip | v2 (`brew install awscli` or official pkg) | `macos/scripts/apps/awscli.sh` |
| Node | unpinned brew | nvm/fnm/mise | `macos/scripts/apps/dev.sh` |
| VS Code extensions | tslint, jslint, typescript-hero, etc. | audit and replace obsolete IDs | `macos/scripts/apps/dev.sh` |
| Package tiers | split | done (core + apps/) | `install/packages.sh`, `apps/` |
| Dotfiles | none | add shell/git/editor config or stow | new `macos/dotfiles/` |

---

## P2 — structural

| Item | Notes |
|------|-------|
| Per-platform orchestrator | Optional `setup.sh` at root of each active platform |
| Shared shell config | Extract `.commonrc` patterns for cross-platform use |
| pi_omv scripts | Extract README steps into `pi_omv/scripts/` |
| crostini | Leave archived or delete folder |
| macOS dotfiles | Shell, git, VS Code settings not managed yet |

---

## P3 — nice-to-have

| Item | Notes |
|------|-------|
| PipeWire | PulseAudio stack | PipeWire | `scripts/install/packages.sh`, `scripts/install/desktop.sh` |
| powerlevel9k → powerlevel10k | powerlevel9k | powerlevel10k | `scripts/desktop/zsh.sh`, `.powerlevelrc` |
| wine-staging-nine → wine-staging | wine-staging-nine | wine-staging | `scripts/apps/games.sh` |
| steam-native-runtime | deprecated package | remove | `scripts/apps/games.sh` |
| Network config | Fix `DBS` typo in `51-static.network`; parameterize interface/IP |
| Intel + NVIDIA docs | Document hybrid GPU conflict for TearFree + proprietary NVIDIA |
| GRUB root LV | Increase from 20G (flagged in README) |
| VS Code C# extension | `ms-vscode.csharp` → `ms-dotnettools.csharp` |
| reflector | Mirror optimization before first `pacman -Syu` |
| Firewall | ufw or nftables baseline |

---

## Platform-specific quick notes

### arch_xfce4

- Automated tests in `test/` (excluded from release tarballs); repo-root `make-release.sh`.
- `flatpak.sh` should source `sudov.sh` (fixed).
- `files/etc/` never deployed by scripts — consider a `deploy-system.sh` or keep manual.
- `postinstall.sh` interactive gpg/ssh-keygen blocks unattended installs.
- Budgie script has TODO to relocate — clarify DE strategy before revival.

### macos

- VS Code extensions noted to "behave weird" — investigate before re-running.
- Todoist CLI tap commented out in `packages.sh`.

### crostini (archived)

- Node 13, Python 3.7.3, PyCharm 2019.3 — all EOL.
- `packages.sh` had syntax error on `user.name` (fixed).
- No sync/stow mechanism.

### pi_omv (stale runbook)

- OMV arrakis, PHP 7.0, `apt-key add` — all outdated.
- README-only; no automation.
