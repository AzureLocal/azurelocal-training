# Skill: workstream-review-lab

Reviews a lab file for technical accuracy, completeness, and MkDocs Material format compliance.

## Invoked by

`/review-lab <path>`

Example: `/review-lab docs/03-storage/lab-3-create-volumes.md`

## Inputs

`$ARGUMENTS` — path to the lab Markdown file (relative to repo root).

## Pipeline

### Stage 1 — Technical review (azurelocal-domain-expert)

Spawn `azurelocal-domain-expert` with:

```
Review the following Azure Local training lab for technical accuracy.

File: {{ARGUMENTS}}

Check:
1. Are all PowerShell cmdlets and parameters correct for Azure Local 23H2/2411?
2. Are prerequisite requirements accurate (OS version, hardware, permissions)?
3. Are expected command outputs realistic?
4. Are any steps missing, out of order, or technically incorrect?
5. Are the validation steps sufficient to confirm success?
6. Does the troubleshooting table address realistic failure modes?

Report findings as a numbered list: finding, severity (critical/major/minor), recommended fix.
If no issues found, say so explicitly.
```

### Stage 2 — Format and structure review (training-content-author)

Spawn `training-content-author` with:

```
Review the following lab for format compliance and content completeness.

File: {{ARGUMENTS}}
Technical findings from domain expert: {{STAGE_1_OUTPUT}}

Check:
1. Are all required sections present? (Overview, Prerequisites, Objectives, Estimated time, Lab steps, Validation, Troubleshooting, Summary, Next steps)
2. Is MkDocs Material admonition syntax correct? (not GitHub-flavored)
3. Are code blocks using language specifiers?
4. Are placeholder values used for operator-supplied inputs?
5. Is the file registered in mkdocs.yml nav?
6. Is the estimated time realistic?

Produce a combined review report:
- List of issues from both the technical review (Stage 1) and format review (this stage)
- For each issue: file location (line number if possible), severity, recommended fix
- Overall recommendation: APPROVE / APPROVE WITH MINOR FIXES / REVISE
```

**Gate:** Present the combined review report to the user.

### Stage 3 — Apply fixes (optional, on user request)

If the user asks to apply the fixes:

Spawn `training-content-author` with the review report and instruction to apply all non-controversial fixes inline, then present a diff for human approval before committing.

Do not auto-commit. Always let the user see the changes before committing.

## Cycle limit

One review pass only. If the lab has extensive issues after fixes are applied, surface that to the user rather than re-running the pipeline.
