# Unraid templates

Container templates and helper plugins for my Unraid server. Only install forms, icons and the
installer live here; the app code and images are private.

## hebrew-poc

Hebrew learning app: text-to-speech comparison + local speech check.

### Install (no console needed)

1. **Plugins → Install Plugin**, paste this URL, click **Install**:
   ```
   https://raw.githubusercontent.com/jdrudolph/unraid-templates/main/plugin/hebrew-poc.plg
   ```
2. **Settings → User Utilities → Hebrew PoC**
   - Click *Create a token on GitHub* (only `read:packages` is pre-ticked), generate it, paste it, click **Connect**.
   - Click **Install hebrew-poc**, paste at least one API key, click **Apply**.
3. Click **Open the app** on the same page (or WebUI on the Docker tab).

The plugin restores the GitHub login on every boot, so updates keep working.
Updates for the app show up on the Docker tab; updates for the plugin under Plugins.

### Remove

Plugins → hebrew-poc → Remove. That removes the GitHub login; the container and its template stay
until you remove them on the Docker tab.
