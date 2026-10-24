#!/bin/bash
# One-time setup for hebrew-poc on Unraid (private image on ghcr.io).
#   bash <(curl -fsSL https://raw.githubusercontent.com/jdrudolph/unraid-templates/main/hebrew-poc/install.sh)
#
# 1. Logs Docker in to ghcr.io with a read-only GitHub token
# 2. Saves that login to the flash drive and restores it on every boot (Unraid wipes /root on reboot)
# 3. Installs the container template, so it shows up under Docker -> Add Container
# Safe to run again (e.g. to replace an expired token).
set -euo pipefail

GH_USER="jdrudolph"
IMAGE="ghcr.io/jdrudolph/hebrew-poc:latest"
RAW="https://raw.githubusercontent.com/jdrudolph/unraid-templates/main/hebrew-poc"

FLASH_CFG="/boot/config/docker-ghcr.json"
GO_FILE="/boot/config/go"
TPL_DIR="/boot/config/plugins/dockerMan/templates-user"
RESTORE_LINE="mkdir -p /root/.docker && cp $FLASH_CFG /root/.docker/config.json  # hebrew-poc: restore ghcr.io login"

bold() { printf '\033[1m%s\033[0m\n' "$*"; }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
die()  { printf '  \033[31m✗\033[0m %s\n' "$*" >&2; exit 1; }

[ -d /boot/config ] || die "This doesn't look like an Unraid server (no /boot/config)."
command -v docker >/dev/null || die "Docker isn't running. Start it under Settings -> Docker."

bold "hebrew-poc setup"
echo
echo "Paste a GitHub token (classic) with only the 'read:packages' scope."
echo "Create one at: https://github.com/settings/tokens/new?scopes=read:packages&description=unraid-hebrew-poc"
printf "Token (hidden): "
read -rs TOKEN </dev/tty
echo
[ -n "$TOKEN" ] || die "No token entered."

# 1. log in
echo "$TOKEN" | docker login ghcr.io -u "$GH_USER" --password-stdin >/dev/null 2>&1 \
  || die "GitHub rejected the token. Check that it has the read:packages scope."
ok "Logged in to ghcr.io"

# check the image is reachable (doesn't download it)
if docker manifest inspect "$IMAGE" >/dev/null 2>&1; then
  ok "Image is reachable"
else
  echo "  ! Logged in, but the image isn't there yet. If the first GitHub Actions build"
  echo "    is still running, that's expected; finish setup and install once it's done."
fi

# 2. persist across reboots
cp /root/.docker/config.json "$FLASH_CFG"
touch "$GO_FILE"
if ! grep -qF "$FLASH_CFG" "$GO_FILE"; then
  printf '\n%s\n' "$RESTORE_LINE" >> "$GO_FILE"
fi
ok "Login saved to flash and restored on every boot"

# 3. template
mkdir -p "$TPL_DIR"
curl -fsSL "$RAW/hebrew-poc.xml" -o "$TPL_DIR/my-hebrew-poc.xml" || die "Couldn't download the template."
ok "Template installed"

echo
bold "Done. Next:"
echo "  Docker tab -> Add Container -> Template: hebrew-poc -> paste an API key -> Apply"
echo
echo "Tip: if your flash drive is shared over SMB, set that share to Private."
