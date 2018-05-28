### File structure

```sh
# the various configuration files
dotfiles/
  _base/             # distro-agnostic
  $distro/
    _base/           # desktop-env-agnostic
    $desktop_env/

# shell scripts for getting packages etc.
# follows the same structure as above
scripts/
  _base/
  $distro/
    _base/
    $desktop_env/
```