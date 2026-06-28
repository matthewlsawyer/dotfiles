# Modernization Backlog

Prioritized list of updates before running stale scripts on real hardware. READMEs document what exists today; this file tracks what still needs to change.

**Maintenance:** Remove items from this file as they are completed — do not leave "done" rows behind. This backlog is temporary; when empty or obsolete, delete the file.

**Current state:** Use [`arch/`](arch/README.md) for fresh headless Arch installs. [`arch_xfce4/`](arch_xfce4/README.md) and much of [`macos/`](macos/README.md) still need refresh before real use.

---

## P0 — before arch_xfce4 revival

These block a safe rebuild on current Arch. Paths are under `arch_xfce4/` unless noted.

| Item | Current | Target | Files affected |
|------|---------|--------|----------------|
| AUR helper | yaourt + package-query | paru or yay | `arch_xfce4/scripts/install/installer.sh`, `arch_xfce4/scripts/lib/functions.sh`, `arch_xfce4/dotfiles/.yaourtrc` |
| Compositor | compton | picom | `arch_xfce4/scripts/install/desktop.sh`, `arch_xfce4/dotfiles/.config/compton.conf`, autostart desktop file |

**Use `arch/` today** for a fresh headless Arch install. Revive `arch_xfce4/` only after P0 (and a real-hardware dry run).

---

## P1 — macOS refresh

| Item | Current | Target | Files affected |
|------|---------|--------|----------------|
| Package manifest | inline `brew install` | Brewfile | `macos/scripts/apps/*.sh` |
| Homebrew install | legacy Ruby one-liner | official install script; Apple Silicon note | `macos/scripts/install/installer.sh` |
| AWS CLI | v1 bundled zip | v2 (`brew install awscli` or official pkg) | `macos/scripts/apps/awscli.sh` |
| Node | unpinned brew | nvm/fnm/mise | `macos/scripts/apps/dev.sh` |
| VS Code extensions | tslint, jslint, typescript-hero, etc. in comments | audit and replace obsolete IDs | `macos/scripts/apps/dev.sh` |
| postinstall | stub | defaults, keys, or other post-bootstrap tuning | `macos/scripts/install/postinstall.sh` |

---

## P2 — structural

| Item | Notes |
|------|-------|
| pi_omv scripts | Extract README steps into `pi_omv/scripts/` + `apply.sh` when rebuilt |
| Dotfiles fragment pattern | Profile + host rsync same filename (e.g. `.zprofile`) — later layer overwrites whole file; host duplicates profile content as workaround | Sync snippets to `~/.config/dotfiles/zprofile.d/` (or similar); thin `~/.zprofile` sources fragments; update `apply.sh` `run_sync` |

---

## P3 — nice-to-have

| Item | Current | Target | Files affected |
|------|---------|--------|----------------|
| Audio | PulseAudio stack | PipeWire | `arch_xfce4/scripts/install/packages.sh`, `desktop.sh` |
| Shell prompt | powerlevel9k | powerlevel10k | `arch_xfce4/scripts/desktop/zsh.sh`, `.powerlevelrc` |
| WINE | wine-staging-nine | wine-staging | `arch_xfce4/scripts/apps/games.sh` |
| steam-native-runtime | deprecated package | remove | `arch_xfce4/scripts/apps/games.sh` |
| GRUB resume | — | document in host post-install | `hosts/arch-desktop/README.md` |
| VS Code C# extension | `ms-vscode.csharp` | `ms-dotnettools.csharp` | `macos/scripts/apps/dev.sh` (commented) |
| reflector | — | mirror optimization before first `pacman -Syu` | new optional script or bootstrap step |
| Firewall | — | ufw or nftables baseline | optional module |

---

## Platform-specific quick notes

### arch (active)

- Headless pacman-only — no AUR, no desktop. Desktop stack lives in `arch_xfce4/` after P0.
- `install/postinstall.sh` is a stub; optional work in `scripts/apps/`, `scripts/extras/`.

### arch_xfce4 (planned)

- Contract-tested layout but **stale stack** — do not run on real hardware until P0.
- Machine-specific `files/etc/` and LVM live in [`hosts/arch-desktop/`](../hosts/arch-desktop/) — manual copy after bootstrap.
- Budgie script has TODO to relocate — clarify DE strategy before revival.

### macos (active scripts, stale content)

- Bootstrap is minimal and works; optional `apps/` content is dated.
- VS Code extensions noted to "behave weird" — investigate before re-running `apps/dev.sh`.
- Todoist CLI tap commented out in `install/packages.sh`.

### crostini (archived)

- Node 13, Python 3.7.3, PyCharm 2019.3 — all EOL.
- Real install is manual `crostini/scripts/` sequence.

### pi_omv (stale runbook)

- Pi + OMV runbook — OMV arrakis, PHP 7.0, `apt-key add` outdated.
- README-only; no `apply.sh`. Disk layout in [`hosts/pi-omv/`](../hosts/pi-omv/). Future: scripts when rebuilt.
