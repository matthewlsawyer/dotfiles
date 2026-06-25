# Bootstrap pipeline (internal)

Fixed-order steps invoked by [`../bootstrap.sh`](../bootstrap.sh). Do not reorder without updating this file and `../bootstrap.sh`.

**User entry:** `dotfiles.sh arch_xfce4 bootstrap` → `apply.sh bootstrap` → [`../bootstrap.sh`](../bootstrap.sh) → these scripts.

## Pipeline

```
install/installer.sh → install/packages.sh → install/desktop.sh → ../sync.sh → install/postinstall.sh
```

| Step | Script | Role |
|------|--------|------|
| 1 | `install/installer.sh` | AUR helper (yaourt) |
| 2 | `install/packages.sh` | Core packages |
| 3 | `install/desktop.sh` | XFCE, themes, compositor |
| 4 | [`../sync.sh`](../sync.sh) | Dotfiles → `$HOME` |
| 5 | `install/postinstall.sh` | System tuning, keys, groups |

Step 4 ([`../sync.sh`](../sync.sh)) is also reached via **sync** (`dotfiles.sh arch_xfce4 sync` → `apply.sh sync`).

## Prerequisites

Working network before step 1. See [../../README.md](../../README.md#bootstrap-fresh-install).

## After the contract

Optional modules are **not** part of this pipeline. See [Recommended run](../../README.md#recommended-run).
