# macos

**Active** — Homebrew bootstrap. Dotfiles: `macos/dotfiles/.zprofile` (brew shellenv). See [MODERNIZATION.md](../MODERNIZATION.md).

## Commands

```bash
./dotfiles.sh macos sync
./dotfiles.sh macos bootstrap
./dotfiles.sh macbook-pro-m1 bootstrap   # macos profile + host overlay
```

**Prerequisite:** Xcode CLT (`xcode-select --install`).

## Pipeline

```
install/installer.sh → install/packages.sh → sync.sh → install/postinstall.sh
```

Details: [scripts/install/README.md](scripts/install/README.md)

## After bootstrap

```bash
cd macos/scripts
./apps/dev.sh && ./apps/browsers.sh
./apps/python.sh      # python@3.14 runtime
./apps/awscli.sh      # optional
```

On `macbook-pro-m1`, also run `hosts/macbook-pro-m1/scripts/pipx.sh` for pipx.

## Python

- **Profile** (`apps/python.sh`) installs `python@3.14` — project deps always in `python3 -m venv`
- **Host** (`hosts/macbook-pro-m1/scripts/pipx.sh`) installs pipx for ad-hoc CLIs
- **Personal** — `brew install` or `pipx install` for tools like yt-dlp; not tracked in repo

Optional modules: [scripts/README.md](scripts/README.md)
