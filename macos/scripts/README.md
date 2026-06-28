# scripts/ (internal)

Not entry points — use [`dotfiles.sh`](../dotfiles.sh) or [`apply.sh`](../apply.sh).

## Pipeline

```
install/installer.sh → install/packages.sh → install/uv.sh → sync.sh → install/postinstall.sh
```

See [install/README.md](install/README.md). Prerequisite: Xcode CLT.

## Optional modules (`apps/`)

| Script | Purpose |
|--------|---------|
| `dev.sh` | VS Code, Cursor, Docker, Node |
| `browsers.sh` | Google Chrome |
| `python.sh` | `python@3.14` runtime — project deps in venv only, not global pip |
| `awscli.sh` | AWS CLI v1 bundled installer |

Run individually after bootstrap — not part of pipeline contract.
