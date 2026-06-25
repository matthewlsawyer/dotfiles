# Contract tests

Validates root routing and per-platform install layout — not a separate install path.

```bash
cd test
./contract-test.sh
```

Checks:

- `dotfiles.sh` routing (help, unknown platform fails)
- `arch/`, `macos/`, `arch_xfce4/` — `apply.sh` at platform root, `scripts/sync.sh`, `scripts/bootstrap.sh`, and bootstrap pipeline scripts under `scripts/install/`
- `crostini/` — archived `apply.sh` stub; routing smoke test (`sync` / `bootstrap` exit 0)
- `arch/dotfiles/.zshrc` and `arch_xfce4/dotfiles/.zshrc` exist
- `test/arch/integration-test.sh` harness exists (does not run Docker)

## Docker integration (optional, slow)

```bash
cd test/arch
./integration-test.sh    # arch pacman-only bootstrap
```

Uses volume `dotfiles-pacman-cache` for pacman package cache between runs. On Apple Silicon, set `DOCKER_PLATFORM=linux/amd64` (default in script).

Not included in release tarballs (see `make-release.sh`).
