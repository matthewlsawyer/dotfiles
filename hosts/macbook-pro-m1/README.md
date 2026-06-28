# macbook-pro-m1

Apple Silicon MacBook Pro — machine-specific notes for this box.

**Profile:** `macos` — see [macos/README.md](../../macos/README.md)

## Rebuild

```bash
./dotfiles.sh macbook-pro-m1 bootstrap
```

After bootstrap:

```bash
./macos/scripts/apps/dev.sh
./macos/scripts/apps/python.sh
./hosts/macbook-pro-m1/scripts/pipx.sh
```

Personal CLIs — not in repo:

```bash
brew install yt-dlp    # or: pipx install <tool>
```

## This machine

- Apple Silicon (M1)
- Python 3.14 via Homebrew (`macos/scripts/apps/python.sh`)
- pipx via `hosts/macbook-pro-m1/scripts/pipx.sh`
- One-time legacy global pip cleanup is manual — not automated by bootstrap

## Sync

When ready to adopt repo-managed shell config:

```bash
./dotfiles.sh macbook-pro-m1 sync
```

Then review `~/.zshrc` / `~/.zprofile` for duplicate or conflicting lines.
