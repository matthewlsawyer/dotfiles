# macOS

**Status:** Active — primary development machine.

Homebrew-based bootstrap for a fresh macOS install. Core bootstrap installs CLI essentials; optional `apps/` modules add dev tooling, editors, and GUI apps. Dotfiles are not managed here yet — sync is a stub until `macos/dotfiles/` exists.

---

## Interface

[`dotfiles.sh`](../dotfiles.sh) routes **sync** and **bootstrap** to [`apply.sh`](apply.sh):

| Command | When | What runs |
|---------|------|-----------|
| **sync** | Machine already set up | `apply.sh sync` → [`scripts/sync.sh`](scripts/sync.sh) (stub until `dotfiles/` exists) |
| **bootstrap** | Fresh install | `apply.sh bootstrap` → [`scripts/bootstrap.sh`](scripts/bootstrap.sh) |

```bash
./dotfiles.sh macos sync
./dotfiles.sh macos bootstrap

# or directly:
./macos/apply.sh sync
./macos/apply.sh bootstrap
```

[`apply.sh`](apply.sh) is the sole entry script at the platform root. Sync, bootstrap pipeline, and optional modules live under [`scripts/`](scripts/).

### Bootstrap pipeline

Fixed order — orchestrated by [`scripts/bootstrap.sh`](scripts/bootstrap.sh), invoked via `apply.sh bootstrap`. Do not reorder without updating [`scripts/install/README.md`](scripts/install/README.md) and `scripts/bootstrap.sh`.

```
install/installer.sh → install/packages.sh → sync.sh → install/postinstall.sh
```

| Step | Script | Role |
|------|--------|------|
| 1 | `install/installer.sh` | Homebrew |
| 2 | `install/packages.sh` | Core CLI — git, wget, htop, jq, httpie, mac2unix, rsync |
| 3 | [`scripts/sync.sh`](scripts/sync.sh) | Dotfiles → `$HOME` (stub until `dotfiles/` exists) |
| 4 | `install/postinstall.sh` | **Stub** — post-bootstrap tuning |

Optional modules under `scripts/apps/` are **not** part of this pipeline.

### Contract test

[`test/contract-test.sh`](../test/contract-test.sh) validates `apply.sh` and bootstrap pipeline scripts.

---

## Quick start

| Flow | When | Command |
|------|------|---------|
| **Sync** | Pull in dotfiles (none yet) | `./dotfiles.sh macos sync` |
| **Bootstrap** | Fresh macOS install | `./dotfiles.sh macos bootstrap` |

**Prerequisites:** Xcode Command Line Tools (`xcode-select --install`).

### Recommended run

```bash
./dotfiles.sh macos bootstrap

cd macos/scripts
./apps/dev.sh && ./apps/browsers.sh
./apps/awscli.sh            # optional
```

---

## Optional modules (`apps/`)

| Script | Purpose |
|--------|---------|
| `dev.sh` | VS Code, Cursor, Docker, Node (+ optional extensions, langs, npm globals) |
| `browsers.sh` | Google Chrome |
| `awscli.sh` | AWS CLI v1 bundled installer |

---

## Key decisions

- **Same sync/bootstrap contract as arch and arch_xfce4** — root router plus tiered optional modules.
- **Core bootstrap is minimal** — Homebrew + CLI essentials + rsync; everything else is optional.
- **Casks to `/Applications`** — `HOMEBREW_CASK_OPTS` set in `scripts/lib/init.sh`.
- **AWS CLI separate** — optional `apps/awscli.sh`, not Homebrew.
- **No dotfiles** — unlike `arch_xfce4/`, nothing synced to `$HOME` yet.

---

## Customization

- Pick optional modules after bootstrap — comment out apps you don't want.
- Update VS Code extensions in `apps/dev.sh` (optional section) before uncommenting — several are dated.
- Consider pinning Node via nvm/fnm/mise — uncomment in `apps/dev.sh` if using Homebrew node.

---

## Known limitations

- Homebrew install uses the legacy Ruby one-liner — may need updating for Apple Silicon or recent macOS.
- AWS CLI v1 is outdated; v2 is the current standard.
- `install/postinstall.sh` is a stub — Brewfile migration still on the backlog.

See [MODERNIZATION.md](../MODERNIZATION.md) for the macOS refresh backlog.

---

## Testing

```bash
cd test && ./contract-test.sh
```

See [test/README.md](../test/README.md).
