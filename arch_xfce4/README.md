# arch_xfce4

> **Planned** — hardware exists; entry scripts and bootstrap pipeline are contract-tested but the stack is stale before revival on real hardware. See [MODERNIZATION.md](../MODERNIZATION.md).

Arch Linux workstation running XFCE4. Modular install scripts, dotfiles synced via rsync, and a handful of system config files copied manually to `/etc`.

The checkout is an **installer tree** — scripts plus source dotfiles. After sync, live config lives in `$HOME` (and selected paths under `/etc`). The checkout path does not need to stay fixed unless you keep it for updates or re-running optional modules.

---

## Interface

[`dotfiles.sh`](../dotfiles.sh) routes **sync** and **bootstrap** to [`apply.sh`](apply.sh):

| Command | When | What runs |
|---------|------|-----------|
| **sync** | Machine already set up | `apply.sh sync` → [`scripts/sync.sh`](scripts/sync.sh) |
| **bootstrap** | Fresh install | `apply.sh bootstrap` → [`scripts/bootstrap.sh`](scripts/bootstrap.sh) |

```bash
./dotfiles.sh arch_xfce4 sync
./dotfiles.sh arch_xfce4 bootstrap

# or directly:
./arch_xfce4/apply.sh sync
./arch_xfce4/apply.sh bootstrap
```

[`apply.sh`](apply.sh) is the sole entry script at the platform root. Sync, bootstrap pipeline, and optional modules live under [`scripts/`](scripts/).

### Bootstrap pipeline

Fixed order — orchestrated by [`scripts/bootstrap.sh`](scripts/bootstrap.sh), invoked via `apply.sh bootstrap`. Do not reorder without updating [`scripts/install/README.md`](scripts/install/README.md) and `scripts/bootstrap.sh`.

```
install/installer.sh → install/packages.sh → install/desktop.sh → sync.sh → install/postinstall.sh
```

| Step | Script | Role |
|------|--------|------|
| 1 | `install/installer.sh` | AUR helper (yaourt) |
| 2 | `install/packages.sh` | Core packages |
| 3 | `install/desktop.sh` | XFCE, Compton, Arc, elementary icons, base fonts |
| 4 | [`scripts/sync.sh`](scripts/sync.sh) | Dotfiles → `$HOME` |
| 5 | `install/postinstall.sh` | Font cache, paccache timer, keys, groups |

Optional modules under `scripts/` are **not** part of this pipeline.

### Contract test

[`test/contract-test.sh`](../test/contract-test.sh) validates `apply.sh` and bootstrap pipeline scripts.

---

## Install path

Checkout location is flexible — scripts resolve paths relative to their own location (`scripts/../dotfiles/`).

### Git clone (permanent checkout)

```bash
git clone git@github.com:matthewlsawyer/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
./dotfiles.sh arch_xfce4 sync
# ./dotfiles.sh arch_xfce4 bootstrap  # fresh hardware
```

Keep the repo for `git pull`, optional modules, and dotfile diffs.

### Release tarball (disposable checkout)

```bash
./make-release.sh                          # from repo root, writes dotfiles-YYYYMMDD.tar.gz
tar xzf dotfiles-20250622.tar.gz -C ~/
cd ~/dotfiles && ./dotfiles.sh arch_xfce4 bootstrap
```

---

## Quick start

| Flow | When | Command |
|------|------|---------|
| **Sync** | System already set up; pull in dotfiles | `./dotfiles.sh arch_xfce4 sync` |
| **Bootstrap** | Fresh Arch install | `./dotfiles.sh arch_xfce4 bootstrap` |

### Sync (existing machine)

`./dotfiles.sh arch_xfce4 sync` — rsyncs `dotfiles/` to `$HOME`. Requires `rsync` on the system (installed via `packages.sh` during bootstrap, or already present).

Run optional modules individually if needed (`zsh.sh`, `apps/dev.sh`, …).

### Bootstrap (fresh install)

**Prerequisite:** working network before bootstrap. Pacman needs mirror access for `install/installer.sh` and `install/packages.sh`. This repo does not configure networking — handle that during the base Arch install or manually first. A minimal Arch install often has no NetworkManager yet; if you're stuck offline after install:

```bash
sudo pacman -S networkmanager
sudo systemctl enable --now NetworkManager
nmcli device wifi connect "SSID" password "pass"   # or use nmtui
```

Wired DHCP, `systemd-networkd`, or `dhcpcd` from your install medium work too — bootstrap only needs reachability to mirrors, not a specific stack.

#### Recommended run

Typical fresh install on NVIDIA hardware with dev tooling:

```bash
./dotfiles.sh arch_xfce4 bootstrap

cd arch_xfce4/scripts
./hardware/graphics-nvidia.sh
./apps/dev.sh && ./apps/utilities.sh
```

Add other optional modules as needed — [full list below](#optional-modules). Manual copy of `files/etc/` to `/etc` is still bootstrap-only — see [What's covered](#whats-covered).

### Optional modules

Run from `scripts/` after bootstrap (or after sync on an existing machine):

**Hardware** (`scripts/hardware/`)

| Script | Purpose |
|--------|---------|
| `graphics-nvidia.sh` | NVIDIA driver, `nvidia-xconfig`, mkinitcpio, pacman hook |
| `firmware-extra.sh` | Niche SATA/HDD firmware (aic94xx, wd719x) |
| `bluetooth.sh` | bluez stack |
| `nobeep.sh` | Blacklist internal PC speaker (`pcspkr`) |

**Apps and dev** (`scripts/apps/`)

| Script | Purpose |
|--------|---------|
| `dev.sh` | VS Code, Docker, Node (+ optional extensions, langs, npm globals) |
| `media.sh` | VLC, ffmpeg, smplayer, codecs |
| `browsers.sh` | Firefox, Chromium |
| `utilities.sh` | htop, tilix, transmission, gparted, archives, … |
| `games.sh` | WINE, Lutris, Steam, emulators |

**Desktop / shell extras** (`scripts/desktop/`)

| Script | Purpose |
|--------|---------|
| `zsh.sh` | zsh, oh-my-zsh, powerlevel9k, syntax highlighting |
| `fonts.sh` | Nerd Fonts from GitHub releases |
| `base16.sh` | Base16 Ocean theme for Tilix, Xfce terminal, Xresources |
| `flatpak.sh` | flatpak + Flathub remote |
| `samba.sh` | Samba + gvfs-smb |
| `budgie.sh` | Alternate Budgie DE (TODO: move elsewhere) |
| `cleanup.sh` | `paccache` cache trim |

Most optional scripts source `lib/sudov.sh` and `lib/functions.sh` via `lib/init.sh`. Not part of the bootstrap pipeline contract.

---

## What's covered

### Dotfiles (`dotfiles/` → `$HOME` via `apply.sh sync`)

- **Shell:** `.zshrc`, `.bashrc`, `.commonrc` (aliases, XDG dirs, npm local prefix, `pinstall`/`yinstall`)
- **Desktop:** Compton config, Plank autostart, XFCE terminal + Tilix (Base16 Ocean, FuraCode Nerd Font)
- **Apps:** VS Code settings, `.Xresources`, `.xinitrc` → `startxfce4`
- **System hooks:** NVIDIA pacman hook (dotfiles) — activated by optional `graphics-nvidia.sh`

### System files (`files/etc/` — manual copy)

- `X11/xorg.conf.d/20-intel.conf` — Intel TearFree
- `systemd/network/51-static.network` — static IP config

These are **not** deployed by any script.

---

## Key decisions

- **XFCE4 + Plank + Compton** — Arc GTK theme, elementary-xfce icons, Base16 Ocean palette across terminals.
- **NVIDIA (optional)** — `hardware/graphics-nvidia.sh` after bootstrap on discrete NVIDIA hardware. Intel TearFree snippet in `files/etc/` (may conflict on hybrid GPU).
- **yaourt for AUR** — `install/installer.sh` runs first; optional modules use `yinstall`.
- **LVM split** — SSD volume group for `/`, `/var`, `/sdata`; HDD volume group for `/home`, swap, `/data`. Boot partition outside LVM.
- **Dev stack (optional)** — `apps/dev.sh` (editors, Docker, optional Node/langs) — not part of core bootstrap.

---

## Customization

- Adjust LVM layout before install — see [LVM.md](LVM.md). Root LV at 20G was flagged as too small.
- Edit `files/etc/systemd/network/51-static.network` for your interface and IP.
- Comment out optional modules you don't need (games, budgie, samba).
- `install/postinstall.sh` runs interactive `ssh-keygen` and `gpg --full-gen-key` — expect prompts.

---

## Post-install manual steps

**Display:** Settings → Power Manager → Display → set "Blank after" to "Never".

**Hard drives:** Disable APM to reduce clicking on HDDs:

```bash
sudo hdparm -B 255 /dev/sdb
sudo hdparm -B 255 /dev/sdc
```

**GRUB resume, lm_sensors, fancontrol** — instructions in `install/postinstall.sh` comments.

---

## Testing

```bash
cd test && ./contract-test.sh
```

Validates routing and bootstrap pipeline layout. See [test/README.md](../test/README.md).

## Known limitations

Much of this stack is dated: yaourt, compton, wine-staging-nine, powerlevel9k.

See [MODERNIZATION.md](../MODERNIZATION.md) for the full migration backlog before running on real hardware.

Disk layout and sample fstab: [LVM.md](LVM.md).
