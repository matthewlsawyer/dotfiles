# Bootstrap pipeline contract

Fixed-order steps for a fresh Arch install. **`bootstrap.sh`** is the only supported orchestrator — do not reorder steps without updating this file and `bootstrap.sh`.

## Pipeline

```
installer.sh → packages.sh → desktop.sh → sync.sh → postinstall.sh
```

| Step | Script | Role |
|------|--------|------|
| 1 | `install/installer.sh` | AUR helper (yaourt) |
| 2 | `install/packages.sh` | Core packages |
| 3 | `install/desktop.sh` | XFCE, themes, compositor |
| 4 | `../sync.sh` | Dotfiles → `$HOME` |
| 5 | `install/postinstall.sh` | System tuning, keys, groups |

**Entry:** `./apply.sh bootstrap` or `./bootstrap.sh` from `scripts/`.

Step 4 (`sync.sh`) is also the default **apply** path on an existing machine — same script, two contexts.

## Prerequisites

Working network before step 1. See [../README.md](../README.md#bootstrap-fresh-install).

## After the contract

Optional modules are **not** part of this pipeline. See [Recommended run](../README.md#recommended-run).
