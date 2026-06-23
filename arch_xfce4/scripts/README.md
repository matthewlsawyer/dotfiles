# scripts/

Install scripts for arch_xfce4.

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
├── sync.sh               # dotfiles → $HOME (apply + bootstrap step 4)
├── bootstrap.sh          # runs install pipeline
├── lib/                  # init, sudov, functions
├── install/              # bootstrap pipeline steps 1–3, 5
├── hardware/             # optional — GPU, firmware, bluetooth
├── apps/                 # optional — dev, browsers, games, …
└── desktop/              # optional — shell, fonts, themes
```

## Bootstrap pipeline (contract)

Fixed order — see [install/README.md](install/README.md):

```
installer.sh → packages.sh → desktop.sh → sync.sh → postinstall.sh
```

```bash
./apply.sh bootstrap
```

## Recommended run

Full fresh install on NVIDIA hardware with dev tooling:

```bash
cd ~/arch_xfce4/scripts

# Contract (required)
./apply.sh bootstrap

# Recommended optional (pick what applies)
./hardware/graphics-nvidia.sh
./apps/dev.sh && ./apps/utilities.sh
```

Other common optional steps: `desktop/zsh.sh`, `desktop/fonts.sh`, `apps/browsers.sh`, `hardware/nobeep.sh`. Full list in [../README.md](../README.md#optional-modules).

## Optional modules

Not part of the bootstrap contract. Run individually from `scripts/` when needed:

```bash
./hardware/graphics-nvidia.sh
./apps/dev.sh
./desktop/zsh.sh
```
