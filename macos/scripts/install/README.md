# Bootstrap pipeline (internal)

Fixed-order steps invoked by [`../bootstrap.sh`](../bootstrap.sh). Do not reorder without updating this file and `../bootstrap.sh`.

**User entry:** `dotfiles.sh macos bootstrap` → `apply.sh bootstrap` → [`../bootstrap.sh`](../bootstrap.sh) → these scripts.

## Pipeline

```
install/installer.sh → install/packages.sh → install/uv.sh → ../sync.sh → install/postinstall.sh
```

| Step | Script | Role |
|------|--------|------|
| 1 | `install/installer.sh` | Homebrew |
| 2 | `install/packages.sh` | Core CLI — git, wget, htop, jq, httpie, mac2unix, rsync |
| 3 | `install/uv.sh` | uv — ad-hoc CLI tools via `uv tool install` / `uvx` |
| 4 | [`../sync.sh`](../sync.sh) | Dotfiles → `$HOME` |
| 5 | `install/postinstall.sh` | **Stub** — post-bootstrap tuning |

Step 4 ([`../sync.sh`](../sync.sh)) is also reached via **sync** (`dotfiles.sh macos sync` → `apply.sh sync`).

## Prerequisites

Xcode Command Line Tools: `xcode-select --install`

## After the contract

Optional modules are **not** part of this pipeline. See [../scripts/README.md](../scripts/README.md).
