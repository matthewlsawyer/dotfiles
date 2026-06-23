# Dotfiles

My personal bootstrap repo — one folder per machine/OS, each with its own install scripts and (sometimes) dotfiles, so I can rebuild a dev environment without starting from scratch.

---

## Entry point

[`dotfiles.sh`](dotfiles.sh) routes to each platform's `scripts/apply.sh`:

```bash
./dotfiles.sh arch              # sync dotfiles (default apply)
./dotfiles.sh arch bootstrap    # full fresh-install pipeline
./dotfiles.sh macos             # Homebrew packages
./dotfiles.sh macos bootstrap   # Homebrew + packages
```

**`DOTFILES_PLATFORM`** — when set, you omit the platform argument. The router reads the platform from the environment instead of argv. Useful in a shell profile or script on a machine that never changes context:

```bash
export DOTFILES_PLATFORM=arch   # or macos on your Mac
./dotfiles.sh                   # → arch_xfce4/scripts/apply.sh
./dotfiles.sh bootstrap         # → arch_xfce4/scripts/apply.sh bootstrap
```

Same as `./dotfiles.sh arch` and `./dotfiles.sh arch bootstrap`, without typing the platform each time.

**Offline install:** `./make-release.sh` packs the repo as `dotfiles-YYYYMMDD.tar.gz` (same layout as clone). Extract and run `./dotfiles.sh arch bootstrap`.

**Contract tests:** `cd test && ./contract-test.sh`

---

## Platforms

| Directory | Status | What's in it |
|-----------|--------|--------------|
| [macos/](macos/README.md) | **Active** | Homebrew scripts — CLI tools, casks, VS Code extensions, npm globals |
| [arch_xfce4/](arch_xfce4/README.md) | **Planned** | Modular pacman/AUR scripts, dotfiles, system config snippets |
| [pi_omv/](pi_omv/README.md) | **Stale runbook** | Manual OMV/NAS setup notes — no scripts |
| [crostini/](crostini/README.md) | **Archived** | Chrome OS Linux dev bootstrap — EOL stack, kept for reference |

---

## Philosophy

I split this by machine rather than by config type. Each platform follows the same entry contract — **apply / sync / bootstrap** — with pipeline docs under `$platform/scripts/install/README.md` (Arch: [arch_xfce4/scripts/install/README.md](arch_xfce4/scripts/install/README.md), macOS: [macos/scripts/install/README.md](macos/scripts/install/README.md)).

There is a **thin root router** ([`dotfiles.sh`](dotfiles.sh)) — platform-agnostic, execs into each OS's `scripts/apply.sh`. Each platform tree is self-contained.

---

## Modernization

Most of this repo hasn't been touched in years. Before reviving `arch_xfce4` on real hardware or refreshing macOS bootstrap, see [MODERNIZATION.md](MODERNIZATION.md) for the prioritized backlog (yaourt→paru, compton→picom, Brewfile, etc.).
