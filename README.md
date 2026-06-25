# Dotfiles

My personal bootstrap repo — one folder per machine/OS, each with its own install scripts and (sometimes) dotfiles, so I can rebuild a dev environment without starting from scratch.

---

## Entry point

[`dotfiles.sh`](dotfiles.sh) routes **sync** and **bootstrap** to each platform's [`apply.sh`](arch/apply.sh):

```bash
./dotfiles.sh arch sync              # sync dotfiles (pacman-only base)
./dotfiles.sh arch bootstrap         # headless pacman-only bootstrap
./dotfiles.sh arch_xfce4 bootstrap   # full XFCE workstation pipeline
./dotfiles.sh macos sync             # sync dotfiles (stub until macos/dotfiles/ exists)
./dotfiles.sh macos bootstrap        # Homebrew bootstrap pipeline
./dotfiles.sh crostini sync          # archived — no-op
```

**`DOTFILES_PLATFORM`** — when set, you omit the platform argument:

```bash
export DOTFILES_PLATFORM=arch
./dotfiles.sh sync
./dotfiles.sh bootstrap
```

Same as `./dotfiles.sh arch sync` and `./dotfiles.sh arch bootstrap`, without typing the platform each time.

**Offline install:** `./make-release.sh` packs the repo as `dotfiles-YYYYMMDD.tar.gz` (same layout as clone). Extract and run `./dotfiles.sh arch bootstrap`.

**Contract tests:** `cd test && ./contract-test.sh` (fast). Docker integration: `cd test/arch && ./integration-test.sh`.

---

## Platforms

| Directory | Status | What's in it |
|-----------|--------|--------------|
| [arch/](arch/README.md) | **Active** | Pacman-only headless base — shell, build tools, slim optional modules |
| [macos/](macos/README.md) | **Active** | Homebrew bootstrap + optional `apps/` modules (editors, casks, dev tooling) |
| [arch_xfce4/](arch_xfce4/README.md) | **Planned** | Full XFCE workstation — modular pacman/AUR scripts, dotfiles, system config |
| [pi_omv/](pi_omv/README.md) | **Stale runbook** | Manual OMV/NAS setup notes — no scripts |
| [crostini/](crostini/README.md) | **Archived** | Chrome OS Linux dev bootstrap — EOL stack, kept for reference |

---

## Philosophy

I split this by machine rather than by config type. Each active platform exposes **sync** and **bootstrap** via [`dotfiles.sh`](dotfiles.sh) → [`apply.sh`](arch/apply.sh) — see [arch/README.md](arch/README.md#interface), [macos/README.md](macos/README.md#interface), and [arch_xfce4/README.md](arch_xfce4/README.md#interface). One entry script per platform root; implementation under `scripts/`.

There is a **thin root router** ([`dotfiles.sh`](dotfiles.sh)) — platform-agnostic, execs into each OS's `apply.sh`.

---

## Modernization

Most of this repo hasn't been touched in years. Before reviving `arch_xfce4` on real hardware or refreshing macOS bootstrap, see [MODERNIZATION.md](MODERNIZATION.md) for the prioritized backlog (yaourt→paru, compton→picom, Brewfile, etc.).
