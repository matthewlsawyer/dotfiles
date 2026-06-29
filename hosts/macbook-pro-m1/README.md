# macbook-pro-m1

Apple Silicon MacBook Pro — machine-specific notes for this box.

**Profile:** `macos` — see [macos/README.md](../../macos/README.md)

## Rebuild

```bash
./dotfiles.sh macbook-pro-m1 bootstrap
```

After bootstrap:

```bash
./hosts/macbook-pro-m1/scripts/apps/bundle.sh
./macos/scripts/extras/awscli.sh
./hosts/macbook-pro-m1/scripts/apps/dev.sh   # VS Code extension reference (comments only)
```

Personal CLIs — not in repo:

```bash
brew install <tool>           # or: uv tool install <tool>
uvx <tool>                    # one-off run, no install
```

## Python

Same conventions as [macos/README.md](../../macos/README.md#python) — bootstrap installs uv and `python@3.14`.

**Workflow on this machine:**

```bash
# CLI tools — brew or uv, never global pip on 3.14
brew install <tool>
uv tool install <tool>
uvx <tool>                    # one-off

# Project deps — always in a venv
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Do **not** `pip install` globally on Homebrew Python. Legacy global pip trees are one-time manual cleanup — not automated by bootstrap.

## Sync

When ready to adopt repo-managed shell config:

```bash
./dotfiles.sh macbook-pro-m1 sync
```

Then review `~/.zshrc` / `~/.zprofile` for duplicate or conflicting lines.
