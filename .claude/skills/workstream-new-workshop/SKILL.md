# Skill: workstream-new-workshop

Scaffolds a new workshop module directory with an overview page and placeholder lab stubs.

## Invoked by

`/new-workshop <module-spec>`

Example: `/new-workshop Module 11: Azure Local monitoring with Azure Monitor`

## Inputs

`$ARGUMENTS` — module number and title. May also include a list of intended labs.

## Pipeline

### Stage 1 — Plan (training-content-author, read-only)

Spawn `training-content-author` in read-only mode with:

```
Plan a new workshop module for azurelocal-training.

Module spec: {{ARGUMENTS}}

Produce a module plan covering:
1. Recommended module number and directory name (following the 00–10 pattern)
2. Module overview: 2–3 sentences describing what operators will learn
3. List of 3–5 labs with suggested titles, objectives, and estimated times
4. Prerequisites for the module (what modules should come before it)
5. Proposed mkdocs.yml nav entries

Do not create any files yet — output the plan only.
```

**Gate:** Present the plan to the user. Confirm before scaffolding.

### Stage 2 — Scaffold (training-content-author)

Spawn `training-content-author` to create:

1. `docs/<module-dir>/index.md` — module overview page with:
   - Module title (H1)
   - Learning objectives (bulleted list)
   - Prerequisites
   - Lab index table (lab number, title, estimated time)

2. One stub file per planned lab: `docs/<module-dir>/lab-<N>-<slug>.md` — skeleton with all required sections, `TODO` placeholders in the body

3. `mkdocs.yml` nav entries for the new module and all stubs

```
Scaffold the module using this plan:
{{STAGE_1_OUTPUT}}

Create all files now. Use TODO placeholders for lab body content.
Add nav entries to mkdocs.yml.
Do not commit — leave for human review.
```

**Gate:** Present the scaffolded files to the user for review.

### Stage 3 — Commit

After human approval:

```
git add docs/<module-dir>/ mkdocs.yml
git commit -m "feat(<module>): scaffold workshop module — <title> (AB#<id>)"
```

## Notes

- Module numbers beyond 10 are allowed; pick the next available number
- The module directory name must follow the pattern `<NN>-<kebab-title>/`
- Stub labs should be immediately usable as targets for `/new-lab` to fill in
