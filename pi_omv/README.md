# pi_omv

**Active** — OMV 7 on Raspberry Pi OS Lite Bookworm via [installScript](https://github.com/OpenMediaVault-Plugin-Developers/installScript). [MODERNIZATION.md](../MODERNIZATION.md)

```bash
./dotfiles.sh pi_omv sync | bootstrap
```

## Prerequisites

- Raspberry Pi OS **Lite** Bookworm (64-bit recommended for Pi 3+)
- Wired Ethernet during install
- SSH access
- Run `sudo raspi-config` for locale, SSH, boot options before or after phase 1

## Two-phase bootstrap

| Phase | Action | Then |
|-------|--------|------|
| 1 | `./dotfiles.sh pi_omv bootstrap` (runs `setup.sh` + preinstall) | **Reboot** |
| 2 | Re-run bootstrap **or** `pi_omv/scripts/bootstrap/omv.sh` | OMV web UI |

Pipeline: `bootstrap/setup.sh` → `bootstrap/omv.sh` → `run_sync` → `bootstrap/postinstall.sh`

On first run, `omv.sh` may fail if preinstall requires reboot — reboot and run phase 2.

**Manual after OMV install:**

```bash
adduser -m <user>
```

Configure storage and services in the OMV web UI (admin / openmediavault).

## After bootstrap (optional)

```bash
cd pi_omv/scripts
./extras/omv-extras.sh   # if not already installed by installScript
SAMBA_USER=... SAMBA_SERVER=... SAMBA_MOUNT=... ./extras/samba.sh
```

## Validation

- `cd test && ./contract-test.sh`
- `test/pi_omv/integration-test.sh` — phase 1 (setup + preinstall) in Debian Bookworm Docker
- Full `omv.sh` — validate on real Pi hardware only

## Archive

Legacy arrakis-era nginx/monit troubleshooting scripts removed (PHP 7.0 / arrakis repo).
