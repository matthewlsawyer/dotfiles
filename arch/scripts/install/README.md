# Bootstrap pipeline (internal)

Fixed-order steps invoked by [`../bootstrap.sh`](../bootstrap.sh). Do not reorder without updating this file and `../bootstrap.sh`.

**User entry:** `dotfiles.sh arch bootstrap` → `apply.sh bootstrap` → [`../bootstrap.sh`](../bootstrap.sh) → these scripts.

## Pipeline

```
install/packages.sh → ../sync.sh → install/postinstall.sh
```

| Step | Script | Role |
|------|--------|------|
| 1 | `packages.sh` | Headless base — shell, build tools, rsync |
| 2 | [`../sync.sh`](../sync.sh) | Dotfiles → `$HOME` |
| 3 | `postinstall.sh` | **Stub** — optional tuning in `apps/`, `extras/` |

## Prerequisites

Working network before bootstrap. Pacman needs mirror access for `packages.sh`.

## After the contract

Optional modules are **not** part of this pipeline. See [Recommended run](../../README.md#recommended-run).
