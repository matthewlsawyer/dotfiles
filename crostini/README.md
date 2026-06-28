# crostini

**Archived** — EOL stack (Node 13, Python 3.7, PyCharm 2019.3). [`apply.sh`](apply.sh) is no-op stub.

Chrome OS Linux dev env. Real install: manual `scripts/` sequence below.

## Install

Run from `crostini/scripts/` in order:

```bash
./packages.sh
./nodejs.sh
./python37.sh
./pycharm.sh
./vscode.sh
./desktop.sh     # refresh Garcon launcher icons
```

Copy dotfiles from `crostini/dotfiles/` to `$HOME`.

## What's covered

vim/git, NodeSource 13.x, Python 3.7.3 (source build), PyCharm CE 2019.3, VS Code `.deb`, Garcon `.desktop` entries.
