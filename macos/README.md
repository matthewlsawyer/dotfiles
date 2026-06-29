# macos

**Active** — Homebrew bootstrap. Dotfiles: `macos/dotfiles/.zprofile` (brew shellenv). See [MODERNIZATION.md](../MODERNIZATION.md).

## Commands

```bash
./dotfiles.sh macos sync
./dotfiles.sh macos bootstrap
./dotfiles.sh macbook-pro-m1 bootstrap   # host apply.sh — see hosts/macbook-pro-m1/
```

**Prerequisite:** Xcode CLT (`xcode-select --install`).

## Bootstrap pipeline

```
install/installer.sh → install/packages.sh → install/uv.sh → run_sync → install/postinstall.sh
```

## After bootstrap

```bash
cd macos/scripts
./apps/dev.sh && ./apps/browsers.sh
./extras/cli-utils.sh   # httpie, mac2unix
./apps/python.sh      # python@3.14 runtime
./apps/awscli.sh      # optional
```

## Python

**Runtime:** `apps/python.sh` installs `python@3.14` and links it as default `python3`.

**Do not** `pip install` globally on the Homebrew Python — no project deps on system site-packages.

| Use case | How |
|----------|-----|
| CLI tools | `brew install <tool>` or `uv tool install <tool>` (uv from bootstrap) |
| Project work | `python3 -m venv .venv` → `source .venv/bin/activate` → `pip install -r requirements.txt` |
| One-off pip | `python3 -m pip install …` inside a venv, not bare global `pip install` |

Individual uv tools stay ad hoc and out of repo — only `uv` itself is installed by bootstrap (`install/uv.sh`).
