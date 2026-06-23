# scripts/

Install scripts for macOS.

## Contracts

| Contract | Scripts | Entry |
|----------|---------|-------|
| **Apply** | `sync.sh` | `./apply.sh` |
| **Bootstrap** | [install pipeline](install/README.md) | `./apply.sh bootstrap` |

Root router: [`dotfiles.sh`](../../dotfiles.sh) → `./apply.sh`.

## Layout

```
scripts/
├── apply.sh              # apply / bootstrap / help
├── sync.sh               # dotfiles → $HOME (apply + bootstrap step 3)
├── bootstrap.sh          # runs install pipeline
├── lib/                  # init (paths, HOMEBREW_CASK_OPTS)
├── install/              # bootstrap pipeline steps 1–2, 4
└── apps/                 # optional modules
```

## Bootstrap pipeline (contract)

Fixed order — see [install/README.md](install/README.md):

```
installer.sh → packages.sh → sync.sh → postinstall.sh
```

Core `install/packages.sh` installs CLI essentials and rsync only. Step 4 (`postinstall.sh`) is a **stub**.

```bash
./apply.sh bootstrap
```

## Recommended run

Fresh macOS install with dev tooling:

```bash
cd ~/Code/dotfiles/macos/scripts

./apply.sh bootstrap

./apps/dev.sh && ./apps/browsers.sh
./apps/awscli.sh
```

Prerequisite: Xcode Command Line Tools (`xcode-select --install`).

## Optional modules (`apps/`)

| Script | Purpose |
|--------|---------|
| `dev.sh` | VS Code, Cursor, Docker, Node (+ optional extensions, langs, npm globals) |
| `browsers.sh` | Google Chrome |
| `awscli.sh` | AWS CLI v1 bundled installer |

Not part of the bootstrap contract — run individually as needed.
