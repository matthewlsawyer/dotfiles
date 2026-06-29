# macos

**Active** — Homebrew bootstrap via Brewfiles. Dotfiles: `macos/dotfiles/.zprofile` (brew shellenv).

## Commands

```bash
./dotfiles.sh macos sync
./dotfiles.sh macos bootstrap
./dotfiles.sh macbook-pro-m1 bootstrap   # host apply.sh — see hosts/macbook-pro-m1/
```

**Prerequisite:** Xcode CLT (`xcode-select --install`).

## Bootstrap pipeline

```
bootstrap/installer.sh → bootstrap/packages.sh (Brewfile.bootstrap) → run_sync → bootstrap/postinstall.sh
```

Manifests: [`Brewfile.bootstrap`](Brewfile.bootstrap) (bootstrap pipeline only).

## After bootstrap

```bash
cd macos/scripts
./extras/awscli.sh        # optional — AWS CLI v2
```

Machine-specific apps (editors, browser, node, etc.) live on the host — see [hosts/macbook-pro-m1/](../hosts/macbook-pro-m1/).

## Python

**Runtime:** `python@3.14` in `Brewfile.bootstrap`; `packages.sh` runs `brew link python@3.14`.

**Do not** `pip install` globally on the Homebrew Python — no project deps on system site-packages.

| Use case | How |
|----------|-----|
| CLI tools | `brew install <tool>` or `uv tool install <tool>` (uv from bootstrap) |
| Project work | `python3 -m venv .venv` → `source .venv/bin/activate` → `pip install -r requirements.txt` |
| One-off pip | `python3 -m pip install …` inside a venv, not bare global `pip install` |

Individual uv tools stay ad hoc and out of repo — only `uv` itself is in bootstrap.

## postinstall

`bootstrap/postinstall.sh` is an intentional stub — no macOS defaults encoded in bootstrap.
