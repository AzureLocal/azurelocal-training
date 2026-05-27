# Research: Content Cleanup Automation Pattern

**Status:** Pending  
**Assigned:** @kristopherjturner  
**Added:** 2026-05-27

## Objective

Locate the content-cleanup automation pattern that exists in the AzureLocal platform standards and determine how to apply it to `azurelocal-training`.

The user noted this pattern was missed when implementing the platform standards for this repo. It likely lives somewhere in:

- `E:\git\platform\docs\` — platform documentation
- `E:\git\azurelocal\azurelocal.github.io\standards\` — repo standards
- A shared GitHub Actions reusable workflow in `AzureLocal/.github`

## Scope Questions

1. What exactly does "content cleanup automation" cover? Candidates:
   - Broken link scanning
   - Orphaned image/asset detection
   - Stale content flagging (pages not updated in N months)
   - Markdown formatting normalization
   - Front matter validation
2. Is it implemented as a GitHub Actions workflow, a pre-commit hook, or a CLI script?
3. Does it exist as a shared reusable workflow in `AzureLocal/.github`?

## Search Leads

```
# Search platform docs
grep -r "content-cleanup\|content cleanup\|cleanup automation" E:\git\platform\docs\
grep -r "content-cleanup\|content cleanup" E:\git\azurelocal\azurelocal.github.io\
```

## Findings

_Not yet investigated._

## Actions

_Pending findings. Once located, implement the pattern in this repo and add the workflow to automation.md._

## Related

- [automation.md](../automation.md) — where the workflow will be documented once found
- [training-platform-plan.md](../training-platform-plan.md) — Section 7 (Content Automation)
