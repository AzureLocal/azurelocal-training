---
description: Produce a work breakdown plan for a delivery program (e.g., "Foundations", "Full Stack", "AKS Focus").
---

Invoke the `workstream-content-plan` skill. Argument: the name of a delivery program.

The skill should:

1. Read `repo-management/training-platform-plan.md` Section 3.2 (delivery programs) to find the module list for that program
2. Read current module status from `repo-management/status/module-status.md`
3. Identify which artifacts (slides, labs, IaC, narration, AI tutor) are missing per included module
4. Produce a phased work plan: which agent to spawn, which artifact, in what order
5. Write the plan to `repo-management/status/plan-<program>-YYYY-MM-DD.md`

Output should be actionable — every line should answer "who does what next."
