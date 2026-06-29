# Modernization Backlog

Prioritized list of updates before running stale scripts on real hardware. READMEs document what exists today; this file tracks what still needs to change.

**Maintenance:** Remove items from this file as they are completed — do not leave "done" rows behind. This backlog is temporary; when empty or obsolete, delete the file.

**Current state:** Use [`arch/`](arch/README.md) for fresh headless Arch installs. [`arch_xfce4/`](arch_xfce4/README.md) P0 complete — validate with `test/arch_xfce4/integration-test.sh` before bare-metal use. [`macos/`](macos/README.md) P1 complete (Brewfiles, awscli v2).

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
| VS Code C# extension | — | `ms-dotnettools.csharp` if C# extension added to dev.sh | `hosts/macbook-pro-m1/scripts/apps/dev.sh` |
| reflector | — | mirror optimization before first `pacman -Syu` | new optional script or bootstrap step |
| Firewall | — | ufw or nftables baseline | optional module |
| Node version manager | brew `node` in host Brewfile.apps | mise/fnm/nvm if multi-version needed | `hosts/macbook-pro-m1/Brewfile.apps` |

---

## Platform-specific quick notes

### arch (active)

- Headless pacman-only — no AUR, no desktop. Desktop stack lives in `arch_xfce4/`.
- `bootstrap/postinstall.sh` is a stub; optional work in `scripts/apps/`, `shared/scripts/extras/`.

### arch_xfce4 (planned)

- P0 done (paru, picom). Run Docker integration test before real hardware.
- Machine-specific `files/etc/` and LVM live in [`hosts/arch-desktop/`](../hosts/arch-desktop/) — manual copy after bootstrap.
- Budgie script has TODO to relocate — clarify DE strategy before revival.

### macos (active)

- P1 done — `Brewfile.bootstrap`, awscli v2; host apps on `macbook-pro-m1`.
- `bootstrap/postinstall.sh` intentional stub.
- Optional profile: `./extras/awscli.sh`. Host: `./scripts/apps/bundle.sh`, `./scripts/apps/dev.sh`.

### crostini (archived)

- Node 13, Python 3.7.3, PyCharm 2019.3 — all EOL.
- Real install is manual `crostini/scripts/` sequence.

### pi_omv (stale runbook)

- Pi + OMV runbook — OMV arrakis, PHP 7.0, `apt-key add` outdated.
- README-only; no `apply.sh`. Disk layout in [`hosts/pi-omv/`](../hosts/pi-omv/). Future: scripts when rebuilt.
