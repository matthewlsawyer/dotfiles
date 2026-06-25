# scripts/ (internal)

Implementation behind the [platform interface](../README.md#interface). Not entry points — use `dotfiles.sh arch_xfce4 sync|bootstrap` or [`../apply.sh`](../apply.sh).

## Layout

```
arch_xfce4/
├── apply.sh                # interface (platform root)
└── scripts/
    ├── sync.sh             # apply sync + bootstrap pipeline step
    ├── bootstrap.sh        # apply bootstrap — runs install pipeline
    ├── lib/                # init, sudov, functions
    ├── install/            # bootstrap pipeline steps
    ├── hardware/           # optional — GPU, firmware, bluetooth
    ├── apps/               # optional — dev, browsers, games, …
    └── desktop/            # optional — shell, fonts, themes
```

## Bootstrap pipeline (internal steps)

Fixed order — see [install/README.md](install/README.md). Orchestrated by [`bootstrap.sh`](bootstrap.sh), invoked via [`../apply.sh bootstrap`](../apply.sh):

```
install/installer.sh → install/packages.sh → install/desktop.sh → sync.sh → install/postinstall.sh
```

## Recommended run

Full fresh install on NVIDIA hardware with dev tooling:

```bash
./dotfiles.sh arch_xfce4 bootstrap

cd arch_xfce4/scripts
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
