# Automation

Documents every GitHub Actions workflow in this repository — active and planned.

---

## Workflow Summary

| File | Name | Trigger | Status | Purpose |
|------|------|---------|--------|---------|
| `deploy-docs.yml` | Deploy Documentation | Push to `main` (docs path filter) | Active | Builds MkDocs site and deploys to GitHub Pages |
| `release-please.yml` | Release Please | Push to `main` | Active | Automates CHANGELOG and releases |
| `validate-repo-structure.yml` | Validate Repo Structure | PR to `main` | Active | Checks repo structure against org standard |
| `drift-check.yml` | Drift Check | Schedule (Mon 09:00 UTC) + manual | Active | Detects missing required files |
| `add-to-project.yml` | Add to Project | Issues/PRs opened or labeled | Active | Adds work items to AzureLocal GitHub Project (prefix: TRN) |
| `validate-labs.yml` | Validate Labs | PR to `main` (labs path filter) | **Planned** | Validates lab frontmatter, step format, and IaC template presence |
| `content-lint.yml` | Content Lint | PR to `main` (docs/labs filter) | **Planned** | Prose lint + broken link check on all Markdown |
| `iac-cleanup.yml` | IaC Validation | PR to `main` (labs/iac filter) | **Planned** | Bicep/Terraform lint and what-if dry-run validation |
| `slide-export.yml` | Slide Export | Push to `main` (slides/ filter) | **Planned** | Exports .pptx to PDF and slide images for web preview |
| `ai-tutor-deploy.yml` | AI Tutor Deploy | Push to `main` (app/ filter) | **Planned** | Builds and deploys the Next.js AI tutor application |

---

## Active Workflows

### deploy-docs.yml

**Trigger:** Push to `main` touching `docs/**` or `mkdocs.yml`  
**Permissions:** `contents: read`, `pages: write`, `id-token: write`  
**Concurrency group:** `pages` (cancel-in-progress: false)

Two-job pipeline:

**build:**
1. Sets up Python 3.12
2. Installs `mkdocs-material` and plugins
3. `mkdocs build --strict` — fails on any warning
4. Uploads `site/` as a pages artifact

**deploy:**
1. Uses `actions/deploy-pages@v4` to publish to GitHub Pages

---

### release-please.yml

**Trigger:** Push to `main`  
**Permissions:** `contents: write`, `pull-requests: write`

Uses `googleapis/release-please-action@v4`. Maintains an automated release PR that updates `CHANGELOG.md` and bumps the version. Merging it creates the GitHub release and tag.

Configuration is in `release-please-config.json` at repo root.

---

### validate-repo-structure.yml

**Trigger:** Pull request to `main`  
**Permissions:** Default read

Calls the shared reusable workflow `AzureLocal/.github/.github/workflows/reusable-validate-structure.yml@main`. Checks that the repo contains all org-required files and directory shapes. Failure blocks merge.

---

### drift-check.yml

**Trigger:** Schedule (every Monday 09:00 UTC) + `workflow_dispatch`  
**Permissions:** Default read

Calls `AzureLocal/platform/.github/workflows/reusable-drift-check.yml@main`.

Required files checked: `CHANGELOG.md`, `mkdocs.yml`, `.github/workflows/deploy-docs.yml`

Opens a GitHub issue if any required file is missing. Designed to catch accidental deletions between PRs.

---

### add-to-project.yml

**Trigger:** Issues or PRs — `opened`, `reopened`, `labeled`  
**Permissions:** Inherited secrets (`ADD_TO_PROJECT_PAT` required)

Calls `AzureLocal/.github/.github/workflows/reusable-add-to-project.yml@main`.

- ID prefix: `TRN`
- Solution option ID: `9c6e8126`

Automatically adds any new issue or PR to the AzureLocal GitHub Project board under the Training solution.

---

## Planned Workflows

### validate-labs.yml

**Trigger:** Pull request to `main` touching `docs/labs/**` or `labs/**`  
**Purpose:** Enforce lab file format before merge — catches missing frontmatter, broken step structure, or labs that reference IaC templates that don't exist.

Checks:
- Each lab `.md` has required frontmatter keys: `title`, `difficulty`, `duration`, `module`, `lab`
- Step headers follow the `## Step N: Title` pattern
- Any `iac/` reference in a lab has a matching file in `labs/iac/`
- Lab file is in the correct path: `docs/labs/<module>/<lab-name>.md`

**Secrets required:** None  
**Blocks merge:** Yes

---

### content-lint.yml

**Trigger:** Pull request to `main` touching `docs/**` or `labs/**`  
**Purpose:** Prose quality and link integrity. Catches style issues and broken links before they reach `main`.

Checks:
- `markdownlint` — enforces consistent Markdown style
- `vale` (prose linter) with Microsoft style guide — catches passive voice, jargon, etc.
- `lychee` or `markdown-link-check` — validates all internal and external links

**Secrets required:** None  
**Blocks merge:** Yes (on broken links and critical linting failures)

---

### iac-cleanup.yml

**Trigger:** Pull request to `main` touching `labs/iac/**`  
**Purpose:** Validate IaC templates so broken Bicep or Terraform never lands on `main`.

Checks:
- **Bicep:** `az bicep build` — compile check, no external connectivity needed
- **Terraform:** `terraform init` + `terraform validate` — syntax only, no provider credentials
- Future: `az deployment what-if` against a sandbox subscription for deeper validation

**Secrets required:** None for lint phase. `AZURE_CREDENTIALS` (planned) for what-if phase.  
**Blocks merge:** Yes

---

### slide-export.yml

**Trigger:** Push to `main` touching `slides/**`  
**Purpose:** Convert `.pptx` files to PDF and PNG slide images so the MkDocs site can show deck previews without requiring PowerPoint.

Process:
1. Download `.pptx` from Git LFS
2. Use LibreOffice headless or a cloud conversion API to produce PDF + per-slide PNGs
3. Commit exported assets to `docs/slides-export/` (or upload to a CDN)

**Secrets required:** TBD — depends on conversion approach  
**Blocks merge:** No (post-merge artifact generation)

---

### ai-tutor-deploy.yml

**Trigger:** Push to `main` touching `app/**`  
**Purpose:** Build and deploy the Next.js AI tutor application to its hosting target (Vercel or Azure Static Web Apps at `app.training.azurelocal.cloud`).

Process:
1. Install Node.js dependencies
2. Run `next build`
3. Deploy to Vercel (or Azure SWA)
4. Post deployment URL as a PR comment

**Secrets required:** `VERCEL_TOKEN` or `AZURE_STATIC_WEB_APPS_API_TOKEN` (TBD based on hosting decision), `ANTHROPIC_API_KEY` (production key for AI tutor)  
**Blocks merge:** No (post-merge deployment)

See [ADR-0003](adr/0003-ai-tutor-platform.md) for the AI tutor platform decision.
