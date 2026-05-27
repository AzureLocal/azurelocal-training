# Research: Content Cleanup Automation Pattern

**Status:** Complete
**Assigned:** @kristopherjturner
**Added:** 2026-05-27
**Updated:** 2026-05-27

---

## Finding

**No canonical reusable "content cleanup" workflow exists in `azurelocal-platform`.** Platform CI only lints platform's own docs — it is not exposed as a reusable workflow for consumer repos like `azurelocal-training`.

## What exists

### Platform's own (non-reusable) CI

- **Path:** `E:\git\azurelocal\azurelocal-platform\.github\workflows\platform-ci.yml`
- **Type:** GitHub Actions workflow (not reusable — runs only on the platform repo)
- **What it does:** Three jobs:
  - `markdownlint` — DavidAnson/markdownlint-cli2-action@v17 against `.markdownlint.json`
  - `link-check` — lycheeverse/lychee-action@v2 (non-blocking)
  - yamllint and Pester

The standards page (`docs/standards/contributing.md` line 106) explicitly says enforcement should be propagated through `.markdownlint.json` + `_common` template rather than via a shared workflow.

### The training repo already has a local equivalent

- **Path:** `.github/workflows/content-lint.yml` (this repo)
- **Type:** GitHub Actions workflow (local, not reusable)
- **Jobs:**
  - `markdownlint` (markdownlint-cli 0.41.0)
  - `link-check` (lychee-action@v2 with 7d cache, non-failing)
  - `mkdocs-strict-build` (`mkdocs build --strict`)

The local `content-lint.yml` mirrors what platform does for itself. **No further action needed** — the training repo already has the right pattern in place.

## What is NOT covered (anywhere)

- Orphaned-page detection (pages in `docs/` not in `mkdocs.yml` nav)
- Frontmatter validation
- Stale-content pruning (pages not updated in N months)

`mkdocs build --strict` is the closest proxy — it catches broken intra-site refs and missing nav entries.

## Action

**Use the existing `content-lint.yml` workflow.** It is the canonical pattern. If a reusable cross-repo version is wanted in the future, author it in `azurelocal-platform/.github/workflows/reusable-content-lint.yml` — but that does not exist today and is not needed for the training repo.

## Related

- `.github/workflows/content-lint.yml` (this repo)
- `azurelocal-platform/.github/workflows/platform-ci.yml`
- `azurelocal-platform/docs/standards/contributing.md`
