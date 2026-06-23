# Contract tests

Validates root routing and per-platform install layout — not a separate install path.

```bash
cd test
./contract-test.sh
```

Checks:

- `dotfiles.sh` routing (help, arch/macos help, unknown platform fails)
- Platform entry scripts and bootstrap pipeline scripts exist and are executable
- Key arch_xfce4 dotfiles and `files/etc` paths exist

Not included in release tarballs (see `make-release.sh`).
