# Bootstrap pipeline contract

Fixed-order steps for a fresh macOS install. **`bootstrap.sh`** is the only supported orchestrator — do not reorder steps without updating this file and `bootstrap.sh`.

## Pipeline

```
installer.sh → packages.sh → sync.sh → postinstall.sh
```

| Step | Script | Role |
|------|--------|------|
| 1 | `install/installer.sh` | Homebrew |
| 2 | `install/packages.sh` | Core CLI — git, wget, htop, jq, httpie, mac2unix, rsync |
| 3 | `../sync.sh` | Dotfiles → `$HOME` (stub until `macos/dotfiles/` exists) |
| 4 | `install/postinstall.sh` | **Stub** — post-bootstrap tuning |

**Entry:** `./apply.sh bootstrap` or `./bootstrap.sh` from `scripts/`.

Step 3 (`sync.sh`) is also the default **apply** path on an existing machine.

## Prerequisites

Xcode Command Line Tools: `xcode-select --install`

## After the contract

Optional modules are **not** part of this pipeline. See [Recommended run](../README.md#recommended-run).
