# Scripts

Repo-management helper scripts. These are local tools for maintaining the repo — not CI workflows.

## Planned Scripts

| Script | Language | Status | Purpose |
|--------|----------|--------|---------|
| `New-GitAttributes.ps1` | PowerShell | Planned | Writes the root `.gitattributes` with Git LFS tracking patterns and runs `git lfs install` |
| `New-Codeowners.ps1` | PowerShell | Planned | Generates `.github/CODEOWNERS` from a contributor list — useful when onboarding new team members |
| `Get-ModuleStatus.ps1` | PowerShell | Planned | Reads `status/module-status.md` and outputs a summary table to the terminal |
| `Export-Slides.ps1` | PowerShell | Planned | Wraps LibreOffice headless or a conversion API to export `.pptx` → PDF + PNG per module |
| `Sync-Labels.ps1` | PowerShell | Planned | Triggers the `sync-labels.yml` workflow via `gh workflow run` — shortcut for label sync |
| `Invoke-ContentLint.ps1` | PowerShell | Planned | Runs markdownlint + lychee link check locally — mirrors what `content-lint.yml` does in CI |

## Conventions

- All scripts are PowerShell (`.ps1`) — consistent with the repo's platform (Windows / GitHub Actions on ubuntu with pwsh step)
- Scripts are idempotent where possible — safe to run more than once
- No secrets in scripts — use environment variables or `az keyvault secret show` at runtime
- Scripts that modify repo files must be run from the repo root

## Usage

Scripts are not yet implemented. When a script is created:
1. Drop it in this folder
2. Add a row to the table above
3. Add a `## script-name.ps1` section below with usage examples
