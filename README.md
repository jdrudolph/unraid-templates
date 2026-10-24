# Unraid templates

Container templates for my Unraid server. Only the install form and icons live here;
the app code and images are private.

## hebrew-poc

Hebrew learning app: text-to-speech comparison + local speech check.

**One-time setup** (Unraid terminal):

```
bash <(curl -fsSL https://raw.githubusercontent.com/jdrudolph/unraid-templates/main/hebrew-poc/install.sh)
```

It asks for a GitHub token with only `read:packages`, logs Docker in to ghcr.io,
keeps that login across reboots, and installs the template.

**Then:** Docker → Add Container → Template: **hebrew-poc** → paste an API key → Apply.

Updates show up on the Docker tab like any other app. To replace an expired token, run the
setup command again.

**Uninstall the login:** delete `/boot/config/docker-ghcr.json` and the line marked
`hebrew-poc` in `/boot/config/go`.
