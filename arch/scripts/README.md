# scripts/ (internal)

Implementation behind the [platform interface](../README.md#interface). Not entry points — use `dotfiles.sh arch sync|bootstrap` or [`../apply.sh`](../apply.sh).

## Layout

```
arch/
├── apply.sh                # interface (platform root)
└── scripts/
    ├── sync.sh             # apply sync + bootstrap pipeline step
    ├── bootstrap.sh        # apply bootstrap — runs install pipeline
    ├── lib/                # init, sudov, pinstall helpers
    ├── install/            # bootstrap pipeline steps
    ├── apps/               # optional post-bootstrap modules
    └── extras/
```

## Bootstrap pipeline (internal steps)

Fixed order — see [install/README.md](install/README.md). Orchestrated by [`bootstrap.sh`](bootstrap.sh), invoked via [`../apply.sh bootstrap`](../apply.sh):

```
install/packages.sh → sync.sh → install/postinstall.sh
```

## Optional modules

Not part of the interface contract. Run individually from `scripts/` after bootstrap:

```bash
./apps/dev.sh
./apps/browsers.sh
./extras/flatpak.sh
```
