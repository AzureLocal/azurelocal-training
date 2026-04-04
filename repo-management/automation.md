# Automation

Documents every GitHub Actions workflow in this repository.

---

## Workflow Summary

| File | Name | Trigger | Purpose |
|------|------|---------|---------|
| `deploy-docs.yml` | Deploy Documentation | Push to `main` touching `docs/**` or `mkdocs.yml` | Builds MkDocs site and deploys to GitHub Pages |
| `release-please.yml` | Release Please | Push to `main` | Automates CHANGELOG and releases |

---

## deploy-docs.yml

**Trigger:** Push to `main` touching `docs/**` or `mkdocs.yml`  
**Permissions:** `contents: read`, `pages: write`, `id-token: write`  
**Concurrency group:** `pages` (cancel-in-progress: false)

Two-job pipeline:

**build:**
1. Sets up Python 3.12
2. Installs `mkdocs-material`
3. `mkdocs build --strict` — fails on any warning
4. Uploads `site/` as a pages artifact

**deploy:**
1. Uses `actions/deploy-pages@v4` to publish to GitHub Pages

---

## release-please.yml

**Trigger:** Push to `main`  
**Permissions:** `contents: write`, `pull-requests: write`

Uses `googleapis/release-please-action@v4`. Maintains an automated release PR that updates `CHANGELOG.md` and bumps the version. Merging it creates the GitHub release and tag.

Configuration is in `release-please-config.json` at repo root.
