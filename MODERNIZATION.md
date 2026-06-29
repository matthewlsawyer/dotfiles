# Modernization Backlog

Prioritized list of updates before running stale scripts on real hardware. READMEs document what exists today; this file tracks what still needs to change.

**Maintenance:** Remove items from this file as they are completed — do not leave "done" rows behind. This backlog is temporary; when empty or obsolete, delete the file.

**Current state:** Use [`arch/`](arch/README.md) for fresh headless Arch installs. [`arch_xfce4/`](arch_xfce4/README.md) P0 complete — validate with `test/arch_xfce4/integration-test.sh` before bare-metal use. Much of [`macos/`](macos/README.md) still needs refresh.

---

## P1 — macOS refresh

| Item | Current | Target | Files affected |
|------|---------|--------|----------------|
| Package manifest | inline `brew install` | Brewfile | `macos/scripts/apps/*.sh` |
| Homebrew install | legacy Ruby one-liner | official install script; Apple Silicon note | `macos/scripts/bootstrap/installer.sh` |
| AWS CLI | v1 bundled zip | v2 (`brew install awscli` or official pkg) | `macos/scripts/extras/awscli.sh` |
| Node | unpinned brew | nvm/fnm/mise | `macos/scripts/apps/dev.sh` |
| VS Code extensions | tslint, jslint, typescript-hero, etc. in comments | audit and replace obsolete IDs | `macos/scripts/apps/dev.sh` |
| postinstall | stub | defaults, keys, or other post-bootstrap tuning | `macos/scripts/bootstrap/postinstall.sh` |

---

## P2 — structural

| Item | Notes |
|------|-------|
| pi_omv scripts | Extract README steps into `pi_omv/scripts/` + `apply.sh` when rebuilt |

---

## P3 — nice-to-have

| Item | Current | Target | Files affected |
|------|---------|--------|----------------|
| Audio | PulseAudio stack | PipeWire | `arch_xfce4/scripts/bootstrap/packages.sh`, `bootstrap/desktop.sh` |
| Shell prompt | powerlevel9k | powerlevel10k | `arch_xfce4/scripts/system/zsh.sh`, `.powerlevelrc` |
| WINE | wine-staging-nine | wine-staging | `arch_xfce4/scripts/apps/games.sh` |
| steam-native-runtime | deprecated package | remove | `arch_xfce4/scripts/apps/games.sh` |
| GRUB resume | — | document in host post-install | `hosts/arch-desktop/README.md` |
| VS Code C# extension | `ms-vscode.csharp` | `ms-dotnettools.csharp` | `macos/scripts/apps/dev.sh` (commented) |
| reflector | — | mirror optimization before first `pacman -Syu` | new optional script or bootstrap step |
| Firewall | — | ufw or nftables baseline | optional module |

---

## Platform-specific quick notes

### arch (active)

- Headless pacman-only — no AUR, no desktop. Desktop stack lives in `arch_xfce4/`.
- `bootstrap/postinstall.sh` is a stub; optional work in `scripts/apps/`, `shared/scripts/extras/`.

### arch_xfce4 (planned)

- P0 done (paru, picom). Run Docker integration test before real hardware.
- Machine-specific `files/etc/` and LVM live in [`hosts/arch-desktop/`](../hosts/arch-desktop/) — manual copy after bootstrap.
- Budgie script has TODO to relocate — clarify DE strategy before revival.

### macos (active scripts, stale content)

- Bootstrap is minimal and works; optional `apps/` content is dated.
- VS Code extensions noted to "behave weird" — investigate before re-running `apps/dev.sh`.
- Todoist CLI tap commented out in `bootstrap/packages.sh`.

### crostini (archived)

- Node 13, Python 3.7.3, PyCharm 2019.3 — all EOL.
- Real install is manual `crostini/scripts/` sequence.

### pi_omv (stale runbook)

- Pi + OMV runbook — OMV arrakis, PHP 7.0, `apt-key add` outdated.
- README-only; no `apply.sh`. Disk layout in [`hosts/pi-omv/`](../hosts/pi-omv/). Future: scripts when rebuilt.
