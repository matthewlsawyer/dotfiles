# Modernization Backlog

Prioritized list of updates before running stale scripts on real hardware. READMEs document what exists today; this file tracks what still needs to change.

**Maintenance:** Remove items from this file as they are completed — do not leave "done" rows behind. This backlog is temporary; when empty or obsolete, delete the file.

**Current state:** Use [`arch/`](arch/README.md) for fresh headless Arch installs. [`arch_xfce4/`](arch_xfce4/README.md) P0 + P3 cluster complete (PipeWire, p10k, games) — validate with `test/arch_xfce4/integration-test.sh` before bare-metal use. [`macos/`](macos/README.md) P1 complete. [`pi_omv/`](pi_omv/README.md) OMV 7 modernization complete — phase-1 Docker test; full `omv.sh` on hardware only.

---

## P3 — nice-to-have

| Item | Current | Target | Files affected |
|------|---------|--------|----------------|
| VS Code C# extension | — | `ms-dotnettools.csharp` if C# extension added to dev.sh | `hosts/macbook-pro-m1/scripts/apps/dev.sh` |
| reflector | — | mirror optimization before first `pacman -Syu` | new optional script or bootstrap step |
| Firewall | — | ufw or nftables baseline | optional module |
| Node version manager | brew `node` in host Brewfile.apps | mise/fnm/nvm if multi-version needed | `hosts/macbook-pro-m1/Brewfile.apps` |

---

## Platform-specific quick notes

### arch (active)

- Headless pacman-only — no AUR, no desktop. Desktop stack lives in `arch_xfce4/`.
- `bootstrap/postinstall.sh` is a stub; optional work in `scripts/apps/`, `shared/scripts/extras/`.

### arch_xfce4 (active)

- P0 done (paru, picom). P3 cluster done (PipeWire, powerlevel10k, games.sh). Run Docker integration test before real hardware.
- Machine-specific `files/etc/` and LVM live in [`hosts/arch-desktop/`](../hosts/arch-desktop/) — manual copy after bootstrap.
- Budgie script has TODO to relocate — clarify DE strategy before revival.

### macos (active)

- P1 done — `Brewfile.bootstrap`, awscli v2; host apps on `macbook-pro-m1`.
- `bootstrap/postinstall.sh` intentional stub.
- Optional profile: `./extras/awscli.sh`. Host: `./scripts/apps/bundle.sh`, `./scripts/apps/dev.sh`.

### crostini (archived)

- Node 13, Python 3.7.3, PyCharm 2019.3 — all EOL.
- Real install is manual `crostini/scripts/` sequence.

### pi_omv (active)

- OMV 7 via installScript on Raspberry Pi OS Lite Bookworm.
- Two-phase bootstrap: `setup.sh` (preinstall) → reboot → `omv.sh`.
- Optional: `./extras/omv-extras.sh`, `./extras/samba.sh`.
- `test/pi_omv/integration-test.sh` — phase 1 in Docker; full stack on Pi hardware.
