# Contract tests

```bash
cd test && ./contract-test.sh
```

Validates `dotfiles.sh` routing, profile and host `apply.sh`, bootstrap pipeline layout per profile, `shared/dotfiles/.commonrc`, host manifests.

## Docker (optional, slow)

```bash
cd test/arch && ./integration-test.sh
```

Volume `dotfiles-pacman-cache` persists pacman cache. Apple Silicon: `DOCKER_PLATFORM=linux/amd64` (default in script).

Not included in release tarballs.
