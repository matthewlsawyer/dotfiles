# crostini

> **Archived** — preserved for reference, not maintained. Stack is end-of-life (Node 13, Python 3.7, PyCharm 2019.3). Do not run without updating versions.

Chrome OS Linux (Crostini) dev environment. Debian-based, bootstrapped for Python and Node development with PyCharm CE and VS Code integrated into the Chrome OS app launcher via Garcon.

---

## Quick start

Run from `crostini/scripts/` in order:

```bash
./packages.sh    # apt update, vim/git, git identity
./nodejs.sh      # NodeSource Node 13.x
./python37.sh    # Python 3.7.3 compiled from source
./pycharm.sh     # PyCharm CE 2019.3 tarball to /opt/
./vscode.sh      # VS Code .deb
./desktop.sh     # Refresh Garcon launcher icons
```

Then copy or symlink dotfiles from `crostini/dotfiles/` to `$HOME`.

---

## What's covered

| Layer | Details |
|-------|---------|
| Base apt | vim, git, build-essential |
| Node | NodeSource 13.x |
| Python | 3.7.3 from source (`altinstall`), pip upgrade |
| IDE | PyCharm CE 2019.3 at `/opt/pycharm-community-2019.3/` |
| Editor | VS Code via Microsoft .deb |
| Launcher | `.desktop` entries for PyCharm and VS Code in `dotfiles/.local/share/applications/` |
| Shell | Minimal `.bashrc` — stock Debian template plus `$HOME/.local/bin` in PATH |

---

## Key decisions

- **Python compiled from source** — `--enable-optimizations`, `make -j 4`, removes system `pip3.7` after install.
- **PyCharm manual tarball** — not via snap/flatpak; JBR downgrade via "Choose Runtime" plugin documented in `pycharm.sh` comments for Crostini Java compatibility.
- **Garcon integration** — `desktop.sh` touches `/usr/share/applications/.garcon_trigger` to refresh Chrome OS launcher icons after installing IDEs.
- **Git identity in script** — `packages.sh` sets global git config during bootstrap.

---

## Customization

- Update NodeSource and Python versions before running — current pins are EOL.
- PyCharm path in `.desktop` file must match installed version directory under `/opt/`.
- Most scripts lack shebangs; run explicitly with `bash` if needed.

---

## Known limitations

- No orchestration script, stow, or sync mechanism (unlike `arch_xfce4/`).
- `python37.sh` does not return to original directory — re-runs may fail.
- No venv/pipenv/poetry setup after Python build.
- No Node version manager.

See [MODERNIZATION.md](../MODERNIZATION.md) if revisiting this platform.
