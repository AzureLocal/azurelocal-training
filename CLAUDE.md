# CLAUDE.md — azurelocal-training

Claude Code session context for this repository. Read before doing non-trivial work here.

## What this repo is

`azurelocal-training` is the source for **Azure Local Operator Training** — published to [azurelocal.github.io/azurelocal-training](https://azurelocal.github.io/azurelocal-training/) (planned move to [training.azurelocal.cloud](https://training.azurelocal.cloud)).

This is a **workshop-first** training platform — 20 modules organized as five learning tracks (Foundations, Infrastructure, Operations, Workloads, Adoption). Most modules include hands-on labs with IaC templates (Bicep/Terraform), demo scripts, and an AI tutor session. The MkDocs site is the static reference/marketing layer; the AI tutor (Next.js + Claude API) lives at `app.training.azurelocal.cloud` (planned).

Use the `training-content-author` agent and the `/new-lab`, `/new-workshop`, and `/review-lab` slash commands for content work. The strategic plan is at [`repo-management/training-platform-plan.md`](repo-management/training-platform-plan.md).

## ADO project details

- **ADO org:** https://dev.azure.com/hybridcloudsolutions
- **ADO project:** AzureLocal
- **Area path:** AzureLocal\Training
- **Work item format:** AB#<id> in commit messages

## Standards

This repo follows all HCS/AzureLocal platform standards. Canonical reference:
- [AzureLocal/platform/docs/standards/](https://github.com/AzureLocal/platform/tree/main/docs/standards)
- Rendered: [azurelocal.cloud/standards](https://azurelocal.cloud/standards/)

See `STANDARDS.md` for the local pointer. Changes to standards are PRs against `AzureLocal/platform`, not this repo.

Key conventions that affect editing here:
- **Conventional commits:** `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`
- **release-please** manages `CHANGELOG.md` — never edit manually
- **MkDocs admonitions:** `!!! note "Title"` syntax, not GitHub-flavored `> [!NOTE]`
- **Never commit** real subscription IDs, tenant IDs, hostnames, or credentials

## Key facts

- **Stack:** MkDocs Material (Python) — no npm, no bundler for the docs site
- **AI tutor app stack:** Next.js + Anthropic Claude API (in `app/` — to be scaffolded)
- **Serve docs locally:** `pip install mkdocs-material && mkdocs serve`
- **Build:** `mkdocs build` (output → `site/` — gitignored)
- **Site URL:** https://azurelocal.github.io/azurelocal-training/ (planned: https://training.azurelocal.cloud/)
- **Repo URL:** https://github.com/AzureLocal/azurelocal-training
- **Platform descriptor:** `.azurelocal-platform.yml` (type: training-site)
- **Reusable workflows:** mkdocs-deploy, drift-check, release-please, validate-structure, add-to-project
- **Git LFS:** `.pptx`, `.mp4`, `.pdf`, images — see `.gitattributes`
- When adding a page, always update the `nav:` section in `mkdocs.yml`
- Use placeholder syntax `<subscription-id>`, `<cluster-name>`, `<node-name>` — never real values

## Repo structure (20-module framework)

```
azurelocal-training/
├── docs/                              — MkDocs source (published content)
│   ├── index.md                       — Curriculum landing page
│   ├── 00-introduction/               — Foundations
│   ├── 01-planning-sizing/
│   ├── 02-deployment/
│   ├── 03-management/
│   ├── 04-azure-arc/
│   ├── 05-compute/                    — Infrastructure
│   ├── 06-storage/
│   ├── 07-core-networking/
│   ├── 08-software-defined-networking/
│   ├── 09-security-compliance/        — Operations
│   ├── 10-observability-monitoring/
│   ├── 11-troubleshooting/
│   ├── 12-bcdr/
│   ├── 13-day-2-operations/
│   ├── 14-aks/                        — Workloads
│   ├── 15-avd/
│   ├── 16-iot-operations/
│   ├── 17-ai-foundry-local/
│   ├── 18-migration/                  — Adoption
│   ├── 19-scvmm/                      — Optional / placeholder
│   ├── labs/                          — Lab environment setup
│   ├── presentations/                 — Slide deck status board
│   └── assets/                        — Images, SVGs, icons
├── labs/iac/                          — Bicep/Terraform per module
├── slides/                            — PowerPoint source (Git LFS) + PDF exports
├── videos/                            — Scripts, chapter markers, YouTube links (no video files)
├── app/                               — Next.js AI tutor application (planned)
├── referrence/                        — Legacy training materials (read-only archive)
├── repo-management/                   — Strategic plan, ADRs, status, research, scripts
├── .github/workflows/                 — CI: mkdocs-deploy, drift-check, release-please, etc.
├── .azurelocal-platform.yml           — Platform descriptor (type: training-site)
├── mkdocs.yml                         — MkDocs configuration
├── STANDARDS.md                       — Pointer to AzureLocal/platform standards
└── .claude/                           — Agents, commands, skills, hooks, logs, settings
```

## Claude Code actions

**Run autonomously:**
- Read, search, and grep any file in this repo
- Write and edit Markdown in `docs/`
- Add or reorder nav entries in `mkdocs.yml`
- Run `mkdocs serve` and `mkdocs build`
- `git add`, `git commit`, `git push`
- `gh issue` and `gh pr` commands
- Run scripts in `repo-management/scripts/`

**Always confirm before:**
- Deleting or renaming existing content modules or lab files
- Changing `site_name`, `site_url`, or `repo_url` in `mkdocs.yml`
- Modifying `release-please-config.json` or `.release-please-manifest.json`
- Any `.github/workflows/` changes
- Any operation against the live GitHub Pages site

## Slash commands

| Command | Skill | Purpose |
|---|---|---|
| `/new-lab <topic>` | workstream-new-lab | Research topic → author structured lab → human review |
| `/new-workshop <module>` | workstream-new-workshop | Create module directory with overview page and lab stubs |
| `/review-lab <path>` | workstream-review-lab | Review lab for technical accuracy, completeness, and format |

## Agents in this repo

| Agent | Model | Purpose |
|---|---|---|
| `training-content-author` | sonnet | Writes and edits Azure Local workshop modules and labs. Knows module structure, lab format conventions, and MkDocs Material syntax. |

Additional agents are planned per the [strategic plan](repo-management/training-platform-plan.md) Section 7.3 (training-pm, lab-iac-engineer, ai-tutor-engineer, slide-content-author, video-script-writer, content-reviewer).

## Hooks

| Hook | Event | Matcher | Action |
|---|---|---|---|
| `block-secrets.ps1` | PreToolUse | Write\|Edit | Block writes containing credential patterns |
| `validate-path.ps1` | PreToolUse | Write\|Edit | Block writes to `site/`, `.git/` |
| `block-destructive.ps1` | PreToolUse | Bash | Block force-push, destructive Azure CLI operations |
| `load-memory.ps1` | UserPromptSubmit | — | Inject MEMORY.md context on first prompt of a session |
| `log-tokens.ps1` | PostToolUse | Write\|Edit | Append entry to `.claude/logs/tokens.jsonl` |
| `format-on-write.ps1` | PostToolUse | Write\|Edit | Run markdownlint on written `.md` files (no-op if not installed) |
| `log-operate.ps1` | PostToolUse | Agent | Append entry to `.claude/logs/operate.jsonl` |
| `summarize-session.ps1` | Stop | — | Append entry to `.claude/logs/sessions.jsonl` |

## Subagents available in this repo

- `training-content-author` (model: sonnet) — Azure Local training content authoring; workshop modules, lab guides, MkDocs nav and structure

User-level agents (available in every repo): triage-lookup, markdown-prose-editor, azurelocal-domain-expert, mkdocs-material-doctor, turner-module-scaffold-engineer, mms-2026-demo-presenter.

## Owner

Kris Turner — kristopherjturner@outlook.com
