# Repository Setup

Documents how this repository is configured. Use this as the reference when auditing settings or replicating the repo.

---

## Branch Protection

**Protected branch:** `main`

| Setting | Value |
|---------|-------|
| Require pull request before merging | Yes |
| Required approvals | 1 |
| Dismiss stale reviews on new commits | Yes |
| Require status checks to pass | Yes |
| Required checks | `validate-labs`, `drift-check`, `mkdocs-build` |
| Require branches to be up to date | Yes |
| Restrict force pushes | Yes |
| Allow admins to bypass | Yes |

**Note:** `validate-labs` and `drift-check` are planned workflows. Until they exist, remove them from the required checks list to avoid blocking merges.

---

## Labels

Labels are defined in `azurelocal.github.io/.github/labels.yml` — that is the source of truth for all repos. Labels are applied here via `workflow_dispatch` on `sync-labels.yml` in `azurelocal.github.io`.

---

## Secrets

| Secret | Used By | Description |
|--------|---------|-------------|
| `GITHUB_TOKEN` | All workflows | Built-in GitHub token — auto-provided, no setup needed |
| `ADD_TO_PROJECT_PAT` | `add-to-project.yml` | PAT with `project` scope — adds issues/PRs to the AzureLocal GitHub Project board |
| `CLOUDFLARE_API_TOKEN` | `deploy-docs.yml` (planned) | Cloudflare API token for purging CDN cache after Pages deploy |

---

## CODEOWNERS

File: `.github/CODEOWNERS`

Current state:
```
* @kristopherjturner
```

Planned additions as the team grows:

```
# All files — repo owner
* @kristopherjturner

# Lab content — requires domain review before merge
docs/labs/**         @kristopherjturner
docs/workshops/**    @kristopherjturner

# IaC templates — requires infrastructure review
labs/iac/**          @kristopherjturner

# AI tutor application — requires app review
app/**               @kristopherjturner

# Platform/CI configuration — tightly guarded
.github/**           @kristopherjturner
.claude/**           @kristopherjturner
```

Update when contributors are added. Match GitHub usernames exactly.

---

## Git LFS

PowerPoint files (`.pptx`) are tracked with Git LFS to keep clone size manageable.

### One-time repo setup

```bash
# Install Git LFS (once per machine)
git lfs install

# Track .pptx files
git lfs track "*.pptx"
git add .gitattributes
git commit -m "chore: track .pptx with Git LFS"
```

### Root .gitattributes

The repo root needs a `.gitattributes` file (distinct from `referrence/.gitattributes`):

```gitattributes
# Normalize line endings
* text=auto

# Git LFS — binary assets
*.pptx filter=lfs diff=lfs merge=lfs -text
*.mp4  filter=lfs diff=lfs merge=lfs -text
*.mov  filter=lfs diff=lfs merge=lfs -text
*.png  filter=lfs diff=lfs merge=lfs -text
*.jpg  filter=lfs diff=lfs merge=lfs -text
*.jpeg filter=lfs diff=lfs merge=lfs -text
*.gif  filter=lfs diff=lfs merge=lfs -text
*.pdf  filter=lfs diff=lfs merge=lfs -text
```

**Status:** Planned. No `.gitattributes` exists at the repo root yet. See [ADR-0004](adr/0004-git-lfs-binaries.md).

### LFS storage

GitHub Free gives 1 GB LFS storage and 1 GB/month bandwidth. PowerPoint decks for 10 modules at ~50 MB each = ~500 MB. Within the free tier for now. Revisit if video assets are stored here.

---

## GitHub Pages

| Setting | Value |
|---------|-------|
| Source | GitHub Actions (`actions/deploy-pages`) |
| Build tool | MkDocs Material |
| Deploy trigger | Push to `main` touching `docs/**` or `mkdocs.yml` |
| Custom domain | `training.azurelocal.cloud` (planned) |

### Domain setup (training.azurelocal.cloud)

**Status:** Planned. Domain `azurelocal.cloud` is owned and managed in Cloudflare.

Steps to activate:

1. **GitHub Settings → Pages → Custom domain** — enter `training.azurelocal.cloud` and save. GitHub will generate a DNS verification record and a `CNAME` target (typically `<org>.github.io`).

2. **Cloudflare DNS** — add these records:

   | Type | Name | Content | Proxy |
   |------|------|---------|-------|
   | `CNAME` | `training` | `azurelocal.github.io` | DNS only (grey cloud) |
   | `TXT` | `_github-pages-challenge-azurelocal` | `<value from GitHub>` | — |

   GitHub Pages requires the Cloudflare proxy to be **disabled** (DNS only) for the apex CNAME — proxied mode breaks the TLS certificate provisioning.

3. **Enforce HTTPS** — after the TLS certificate provisions (up to 24 hours), check "Enforce HTTPS" in GitHub Pages settings.

4. **Update mkdocs.yml** — set `site_url: https://training.azurelocal.cloud`.

See [ADR-0002](adr/0002-subdomain-training.md) for the decision rationale.

---

## Replication Checklist

Use this when creating a new repo that should match this configuration.

- [ ] Enable branch protection on `main` per settings above
- [ ] Add `ADD_TO_PROJECT_PAT` secret
- [ ] Add `CLOUDFLARE_API_TOKEN` secret (when domain is live)
- [ ] Install Git LFS and add `.gitattributes`
- [ ] Add `.github/CODEOWNERS` — start with `* @kristopherjturner`
- [ ] Add `.github/PULL_REQUEST_TEMPLATE.md`
- [ ] Copy workflow files from `.github/workflows/`
- [ ] Enable GitHub Pages (Settings → Pages → Source: GitHub Actions)
- [ ] Configure custom domain in Pages settings
- [ ] Add Cloudflare DNS records
- [ ] Enforce HTTPS after cert provisions
