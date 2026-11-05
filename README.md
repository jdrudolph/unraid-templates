# Unraid templates

Container templates and helper plugins for my Unraid server. Only install forms, icons and the
installer live here; the app code and images are private.

## hebrew-poc

Hebrew learning app (daily sessions, Google sign-in, local speech check).

### Install (no console needed)

1. **Plugins → Install Plugin**, paste this URL, click **Install**:
   ```
   https://raw.githubusercontent.com/jdrudolph/unraid-templates/main/plugin/hebrew-poc.plg
   ```
2. **Settings → User Utilities → Hebrew PoC**
   - Click *Create a token on GitHub* (only `read:packages` is pre-ticked), generate it, paste it, click **Connect**.
   - Click **Install hebrew-poc**, check the settings (keys are optional, the Edge voice is free), click **Apply**.
3. Click **Open the app** on the same page (or WebUI on the Docker tab).

### HTTPS with SWAG

The template puts the container on `proxynet`, the network SWAG uses.

1. Copy [`swag/hebrew.subdomain.conf`](swag/hebrew.subdomain.conf) to `appdata/swag/nginx/proxy-confs/` and restart SWAG.
2. Point `hebrew.<domain>` at the server in DNS, like the other subdomains.
3. Add `https://hebrew.<domain>` as an authorized JavaScript origin of the Google OAuth client (already done for hebrew.rdlph.de).

### Updates and backups

- **Updates**: every merge to `main` of hebrew-poc builds a new image after the tests pass. Apps → install
  *Auto Update Applications* and turn on auto-update for hebrew-poc to pick it up nightly, or click *update ready*
  on the Docker tab.
- **Backups**: the app keeps 14 daily copies of each progress file in `appdata/hebrew-poc/backups`. The
  *Appdata Backup* plugin covers the whole folder.

The plugin restores the GitHub login on every boot, so updates keep working.
Updates for the app show up on the Docker tab; updates for the plugin under Plugins.

### Remove

Plugins → hebrew-poc → Remove. That removes the GitHub login; the container and its template stay
until you remove them on the Docker tab.
