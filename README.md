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
./dotfiles.sh pi_omv bootstrap          # runbook-only — see pi_omv/README.md

# Hosts — resolves profile from hosts/<name>/profile, then applies host overlay
./dotfiles.sh arch-desktop bootstrap
./dotfiles.sh pi-omv sync
```

**Env vars** — omit the target argument:

```bash
export DOTFILES_PLATFORM=arch_xfce4
./dotfiles.sh sync

export DOTFILES_HOST=arch-desktop
./dotfiles.sh bootstrap
```

`DOTFILES_HOST` takes precedence over `DOTFILES_PLATFORM` when both are set.

**Offline install:** `./make-release.sh` → `dotfiles-YYYYMMDD.tar.gz`. Extract and run `./dotfiles.sh arch bootstrap`.

**Contract tests:** `cd test && ./contract-test.sh`

---

## Layout

| Layer | Purpose | Examples |
|-------|---------|----------|
| [shared/](shared/) | Cross-profile dotfiles and libs | `.commonrc`, `sudov.sh`, `pinstall` |
| Profiles | OS / role runbooks | `arch/`, `arch_xfce4/`, `macos/`, `pi_omv/` |
| [hosts/](hosts/) | Machine-specific overlays | `arch-desktop/`, `pi-omv/` |

Each profile exposes **sync** and **bootstrap** via [`apply.sh`](arch/apply.sh) when scripted. Hosts add a dotfiles overlay and `files/etc/` hints after the profile runs.

---

## Profiles

| Directory | Status | What's in it |
|-----------|--------|--------------|
| [arch/](arch/README.md) | **Active** | Pacman-only headless base |
| [macos/](macos/README.md) | **Active** | Homebrew bootstrap + optional `apps/` modules |
| [arch_xfce4/](arch_xfce4/README.md) | **Planned** | Full XFCE workstation — modular pacman/AUR scripts, dotfiles |
| [pi_omv/](pi_omv/README.md) | **Stale runbook** | Pi + OMV setup notes — no `apply.sh` |
| [crostini/](crostini/README.md) | **Archived** | Chrome OS Linux — EOL stack |

## Hosts

| Host | Profile | Machine-specific |
|------|---------|------------------|
| [arch-desktop/](hosts/arch-desktop/) | `arch_xfce4` | LVM, static network, Intel Xorg |
| [pi-omv/](hosts/pi-omv/) | `pi_omv` | Disk layout for this NAS |

---

## Philosophy

- **Profiles** answer: what runbook for this kind of machine?
- **Hosts** answer: what was unique about this specific box?
- **Shared** holds config reused across profiles (shell aliases, install libs).

[`dotfiles.sh`](dotfiles.sh) is the thin root router. Implementation stays under each profile's `scripts/`.

---

## Modernization

Before reviving stale stacks on real hardware, see [MODERNIZATION.md](MODERNIZATION.md).
