# scripts/ (internal)

Implementation behind the [platform interface](../README.md#interface). Not entry points — use `dotfiles.sh macos sync|bootstrap` or [`../apply.sh`](../apply.sh).

## Layout

```
macos/
├── apply.sh                # interface (platform root)
└── scripts/
    ├── sync.sh             # apply sync + bootstrap pipeline step
    ├── bootstrap.sh        # apply bootstrap — runs install pipeline
    ├── lib/                # init (paths, HOMEBREW_CASK_OPTS)
    ├── install/            # bootstrap pipeline steps
    └── apps/               # optional modules
```

## Bootstrap pipeline (internal steps)

Fixed order — see [install/README.md](install/README.md). Orchestrated by [`bootstrap.sh`](bootstrap.sh), invoked via [`../apply.sh bootstrap`](../apply.sh):

```
install/installer.sh → install/packages.sh → sync.sh → install/postinstall.sh
```

Core `install/packages.sh` installs CLI essentials and rsync only. Step 4 (`postinstall.sh`) is a **stub**.

## Recommended run

Fresh macOS install with dev tooling:

```bash
./dotfiles.sh macos bootstrap

cd macos/scripts
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
