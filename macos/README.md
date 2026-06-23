# macOS

**Status:** Active — primary development machine.

Homebrew-based bootstrap for a fresh macOS install. Core bootstrap installs CLI essentials; optional `apps/` modules add dev tooling, editors, and GUI apps. Dotfiles are not managed here yet — `sync.sh` is a stub until `macos/dotfiles/` exists.

---

## Quick start

From repo root:

```bash
./dotfiles.sh macos bootstrap    # bootstrap pipeline (core packages only)
./dotfiles.sh macos              # apply (sync dotfiles — none yet)
```

**Prerequisites:** Xcode Command Line Tools (`xcode-select --install`).

---

## Bootstrap pipeline (contract)

Fixed order — orchestrated by `bootstrap.sh` / `./apply.sh bootstrap`. See [scripts/install/README.md](scripts/install/README.md).

```
installer.sh → packages.sh → sync.sh → postinstall.sh
```

| Step | Script | What it does |
|------|--------|--------------|
| 1 | `install/installer.sh` | Homebrew |
| 2 | `install/packages.sh` | Core CLI — git, wget, htop, jq, httpie, mac2unix, rsync |
| 3 | `sync.sh` | Dotfiles → `$HOME` (stub until `dotfiles/` exists) |
| 4 | `install/postinstall.sh` | **Stub** — post-bootstrap tuning |

### Recommended run

```bash
cd macos/scripts

./apply.sh bootstrap

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

- **Same entry contract as arch_xfce4** — apply / sync / bootstrap; tiered packages like Arch.
- **Core bootstrap is minimal** — Homebrew + CLI essentials + rsync; everything else is optional.
- **Casks to `/Applications`** — `HOMEBREW_CASK_OPTS` set in `lib/init.sh`.
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
