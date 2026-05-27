---
description: Produce a daily standup summary for azurelocal-training.
---

# Workstream: Standup

End-to-end pipeline for producing a project standup summary.

## Pipeline

```
git log + status board + ADO delta → training-pm summary → write to standups/ → commit
```

## Steps

1. **Gather inputs**
   - Run `git log --since="1 day ago" --oneline` (or the relevant window)
   - Read `repo-management/status/module-status.md`
   - Read the most recent `repo-management/status/standups/*.md` for continuity
   - (Optional) `az boards work-item list --area "AzureLocal\Training"` if ADO is configured

2. **Spawn `training-pm`** with all gathered inputs. The agent produces the standup content.

3. **Write the standup file**: `repo-management/status/standups/YYYY-MM-DD.md`
   - Use today's date in ISO format
   - Sections: **Done** / **In Progress** / **Blocked** / **Next**
   - Bullet points only — no prose
   - Tag commits with their short SHA when relevant

4. **Commit**: `docs(status): standup YYYY-MM-DD`

5. **Summarize in chat**: print the standup file content back to the user.

## Hard rules

- Never include the same item under both "Done" and "In Progress" — pick one
- Never invent work that isn't reflected in commits, files, or ADO
- Standups are factual reports, not aspirational plans
