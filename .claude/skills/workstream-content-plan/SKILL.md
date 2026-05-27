---
description: Produce a phased work breakdown for a delivery program.
---

# Workstream: Content Plan

End-to-end pipeline for producing a phased content work plan for a delivery program (e.g., Foundations, Full Stack, AKS Focus).

## Pipeline

```
delivery program name → training-pm reads plan + status → phased work breakdown → write to status/ → human gate → spawn agents per phase
```

## Steps

1. **Confirm the delivery program.** Read `repo-management/training-platform-plan.md` Section 3.2 — verify the named program exists. If not, ask the user to define it.

2. **Gather module list** for that program (subset of the 20 modules).

3. **Spawn `training-pm`** with:
   - Module list
   - Current status from `repo-management/status/module-status.md`
   - The user's target completion date (ask if not given)

4. **Produce a phased plan**:
   - Phase 1: framework + IaC for missing modules
   - Phase 2: lab guides + content for missing modules
   - Phase 3: slides + narration for missing modules
   - Phase 4: AI tutor sessions for missing modules
   - Each phase lists: which agent to spawn, which artifact, which module

5. **Write the plan**: `repo-management/status/plan-<program-slug>-YYYY-MM-DD.md`

6. **Human gate**: stop and ask the user to confirm the plan before any execution.

7. **On approval**: spawn the Phase 1 agents in parallel; the user re-invokes the skill to move to subsequent phases.

## Hard rules

- Never execute Phase 1 without human approval
- Never include modules outside the requested program scope
- Always include both effort estimates and prerequisite chains (Module A must be done before Module B if B depends on A)
