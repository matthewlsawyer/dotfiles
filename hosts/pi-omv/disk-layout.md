# pi-omv — disk layout

Install `openmediavault-lvm` plugin first. Single VG, single LV — OMV mounts via its config.

## Layout

| Device | Size | Role |
|--------|------|------|
| `/dev/sda` | ~930G | `main-vg` PV |
| `/dev/sdb` | ~930G | `main-vg` PV |
| `/dev/sdc` | ~3.64T | `main-vg` PV |

| LV | VG | Size |
|----|-----|------|
| `main-lv` | main-vg | ~5.5T |
