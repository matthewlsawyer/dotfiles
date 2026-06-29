# Dotfiles

Personal bootstrap repo — profiles (reusable runbooks), hosts (machine identity), and shared cross-platform config.

---

## Entry point

[`dotfiles.sh`](dotfiles.sh) routes **sync** and **bootstrap** to a **profile** or **host** target:

```bash
# Profiles — generic runbooks
./dotfiles.sh arch sync
./dotfiles.sh arch_xfce4 bootstrap
./dotfiles.sh macos bootstrap
./dotfiles.sh pi_omv bootstrap          # OMV 7 on Pi — see pi_omv/README.md

# Hosts — resolves profile from hosts/<name>/profile; uses host apply.sh
./dotfiles.sh arch-desktop bootstrap
./dotfiles.sh macbook-pro-m1 bootstrap
```

**Env vars** — omit the target argument:

```bash
export DOTFILES_TARGET=arch_xfce4
./dotfiles.sh sync

export DOTFILES_TARGET=arch-desktop
./dotfiles.sh bootstrap
```

**Offline install:** `./make-release.sh` → `dotfiles-YYYYMMDD.tar.gz`. Extract and run `./dotfiles.sh arch bootstrap`.

**Contract tests:** `cd test && ./contract-test.sh`

---

## Layout

| Layer | Purpose | Examples |
|-------|---------|----------|
| [shared/](shared/) | Cross-profile dotfiles, libs, and shared optional scripts | `.commonrc`, `sudov.sh`, install contract, `scripts/extras/` |
| Profiles | OS / role runbooks | `arch/`, `arch_xfce4/`, `macos/`, `pi_omv/` |
| [hosts/](hosts/) | Machine-specific overlays | `arch-desktop/`, `pi-omv/` |

Each profile exposes **sync** and **bootstrap** via [`apply.sh`](arch/apply.sh) when scripted.

---

## Profiles

| Directory | Status | What's in it |
|-----------|--------|--------------|
| [arch/](arch/README.md) | **Active** | Pacman-only headless base |
| [macos/](macos/README.md) | **Active** | Homebrew bootstrap + optional `apps/`, `extras/` |
| [arch_xfce4/](arch_xfce4/README.md) | **Planned** | XFCE workstation — `bootstrap/`, `apps/`, `system/`, `extras/` |
| [pi_omv/](pi_omv/README.md) | **Active** | Pi + OMV 7 — installScript bootstrap, optional `extras/` |
| [crostini/](crostini/README.md) | **Archived** | Chrome OS Linux — EOL stack |

## Hosts

| Host | Profile | Machine-specific |
|------|---------|------------------|
| [arch-desktop/](hosts/arch-desktop/) | `arch_xfce4` | LVM, static network, Intel Xorg — host apply.sh |
| [pi-omv/](hosts/pi-omv/) | `pi_omv` | Disk layout for this NAS |
| [macbook-pro-m1/](hosts/macbook-pro-m1/) | `macos` | M1 laptop overlay |

---

## Philosophy

- **Profiles** answer: what runbook for this kind of machine?
- **Hosts** answer: what was unique about this specific box?
- **Shared** holds config reused across profiles (shell aliases, install libs).

[`dotfiles.sh`](dotfiles.sh) is the thin root router. Implementation stays under each profile's `scripts/` — tier rules below; full contract in [shared/README.md](shared/README.md#scripts-layout).

---

## Script tiers

Every profile (and host, if it adds scripts) uses same folder names under `scripts/`:

| Tier | Path | What goes here | Run how |
|------|------|----------------|---------|
| **Lib** | `lib/` | Path roots, install helpers — sourced, never executed | `init.sh` always; `functions.sh` when calling `pkg_install`/`aur_install` (includes sudov) |
| **Bootstrap** | `bootstrap/` | Fresh-machine install steps + `postinstall.sh` tail | `./dotfiles.sh <target> bootstrap` |
| **Apps** | `apps/` | Software you **use** — browser, editor, games, media | Manual after bootstrap |
| **System** | `system/` | OS/DE **plumbing** — drivers, BT, firmware, shell/DE stack | Manual after bootstrap |
| **Extras** | `extras/` | Small optional utilities — keys, flatpak, CLI helpers, odd installers | Manual after bootstrap |

Shared cross-profile extras live in [`shared/scripts/extras/`](shared/scripts/extras/) (`keys.sh`). Profile-only extras (e.g. `flatpak.sh`) live under `<profile>/scripts/extras/`.

**Bootstrap pipeline** — profile picks which `bootstrap/*.sh` files run (host can add/remove steps). Not every file in `bootstrap/` must be in default pipeline; anything pipeline-eligible still lives in `bootstrap/`, not `apps/`.

---

## Modernization

Before reviving stale stacks on real hardware, see [MODERNIZATION.md](MODERNIZATION.md).
