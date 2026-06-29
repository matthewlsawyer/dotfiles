# Agents

Guidance for AI assistants working in this repo.

## Do not run bootstrap on the host

Do **not** run `./dotfiles.sh` (or profile `apply.sh bootstrap` / `sync`) on the agent host for validation, dry runs, or exploration.

Bootstrap and sync mutate the machine (Homebrew, pacman, rsync to `$HOME`). Run those commands only via:

- **Docker** — `test/arch/integration-test.sh`, `test/arch_xfce4/integration-test.sh`
- **VM** — user-controlled isolated environment
- **Manual** — the user runs `./dotfiles.sh <target> bootstrap|sync` themselves

### Allowed in agent shell

- `cd test && ./contract-test.sh` — routing and layout only (no full bootstrap)
- Docker integration tests under `test/arch/` and `test/arch_xfce4/`
- Read-only inspection: `./dotfiles.sh help`, reading scripts, `git diff`

### Forbidden without explicit user request on their machine

- `./dotfiles.sh macos bootstrap` (or any profile/host `bootstrap` / `sync`)
- `./dotfiles.sh arch_xfce4 bootstrap`, `./dotfiles.sh arch bootstrap`, etc.
- Running `macos/scripts/apps/*.sh`, `arch_xfce4/scripts/bootstrap/*.sh`, or other install scripts directly on the host
- `brew bundle check` or `brew bundle install` on the host for validation

If validation is needed and Docker is unavailable, report that and ask the user to run manually — do not substitute a host dry run.

Include this constraint in subagent prompts that might execute shell commands.

## Code exploration

Before Read/Grep/Glob/Bash exploration, use graphify — see [`.cursor/rules/graphify.mdc`](.cursor/rules/graphify.mdc).

## Layout

- [`dotfiles.sh`](dotfiles.sh) — root router for `sync` / `bootstrap`
- Profiles: `arch/`, `arch_xfce4/`, `macos/`
- Hosts: `hosts/<name>/` — machine overlays
