# macos

**Active** — Homebrew bootstrap. No dotfiles yet (sync stub). See [MODERNIZATION.md](../MODERNIZATION.md).

## Commands

```bash
./dotfiles.sh macos sync
./dotfiles.sh macos bootstrap
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
./apps/awscli.sh    # optional
```

Optional modules: [scripts/README.md](scripts/README.md)
