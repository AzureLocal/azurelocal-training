---
description: Print the artifact status for a single module (or all modules if no arg given).
---

Invoke the `training-pm` agent. Argument: module number (00–19) or "all".

The agent should:

1. Read `repo-management/status/module-status.md` for the canonical status
2. Inspect the live module folder: `docs/<NN>-<slug>/`, `slides/<NN>-<slug>/`, `labs/iac/<NN>-<slug>/`
3. Cross-check what's documented vs. what actually exists on disk — flag discrepancies
4. Print a table per module: `Module | Module Page | Lab | IaC | Slides | Video | AI Tutor | Notes`

If a single module argument is given, deep-dive that module: what's complete, what's missing, what's the next concrete action.
