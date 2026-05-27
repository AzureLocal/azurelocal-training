# Skill: workstream-new-lab

Orchestrates research and authoring of a new Azure Local operations lab guide.

## Invoked by

`/new-lab <topic>`

Example: `/new-lab creating Storage Spaces Direct volumes with tiering`

## Inputs

`$ARGUMENTS` — the lab topic as a plain-text description. May include a target module number (e.g. "Module 3") or let the author place it based on content.

## Pipeline

### Stage 1 — Research (azurelocal-domain-expert)

Spawn `azurelocal-domain-expert` with:

```
Research the following topic for an Azure Local operator training lab:

Topic: {{ARGUMENTS}}

Produce a structured research brief covering:
1. What the operator is actually doing (what Azure Local components are involved)
2. Prerequisites (hardware, OS version, roles/permissions, prior configuration)
3. Step-by-step technical procedure — exact PowerShell cmdlets, WAC paths, or portal steps with expected outputs
4. Common failure modes and their resolutions
5. Validation commands and expected output
6. Links to official Microsoft Learn documentation

Format the brief in Markdown. Cite every Microsoft Learn reference.
```

**Gate:** Present the research brief to the user. Confirm before proceeding to Stage 2.

### Stage 2 — Author (training-content-author)

Spawn `training-content-author` with the research brief from Stage 1 plus:

```
Using the research brief below, write a complete lab guide for the azurelocal-training site.

Research brief:
{{STAGE_1_OUTPUT}}

Requirements:
- Follow the lab format defined in your system prompt exactly (all sections present)
- Target module: determine from topic context or place in docs/labs/ if cross-module
- File name: lab-<N>-<slug>.md (e.g. lab-3-create-s2d-volumes.md)
- Use placeholder syntax for operator-supplied values (<cluster-name>, <node-name>, etc.)
- Include a Troubleshooting table with at least 2 rows
- Add the new file to mkdocs.yml nav in the correct module section
- Do not commit — leave staged for human review
```

**Gate:** Present the authored lab to the user for review. Confirm before Stage 3.

### Stage 3 — Commit

After human approval, commit with:

```
git add docs/<module>/<lab-file>.md mkdocs.yml
git commit -m "docs(<module>): add lab — <topic> (AB#<id>)"
```

If no ADO work item is associated, omit the `AB#<id>` suffix.

## Cycle limit

Maximum 1 revision round between Stage 2 and the human gate. If the lab needs substantial rework after one round, surface the specific issues to the user rather than looping again.

## Failure path

If `azurelocal-domain-expert` cannot find authoritative documentation for the topic, surface that to the user before authoring. Do not write a lab based on uncertain or unverified technical steps.
