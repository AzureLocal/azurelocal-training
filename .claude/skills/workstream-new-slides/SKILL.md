---
description: Scaffold a PowerPoint outline + narration script for a module.
---

# Workstream: New Slides

End-to-end pipeline for scaffolding a slide deck for a training module.

## Pipeline

```
module number → slide-content-author writes outline + narration → human gate → commit → update presentations status
```

## Steps

1. **Validate input.** Module number must be 00–19. Verify `docs/<NN>-<slug>/index.md` exists.

2. **Spawn `slide-content-author`** with:
   - The module's `index.md` content
   - Reference deck conventions (Title / Agenda / LOs / Topics / Lab Intro / Recap / Q&A)
   - Output paths: `slides/<NN>-<slug>/outline.md` and `slides/<NN>-<slug>/narration-script.md`

3. **Spawn `azurelocal-domain-expert`** in parallel to validate technical accuracy of the outline before committing.

4. **Human gate**: present the outline + narration to the user for review.

5. **On approval**:
   - Commit: `docs(slides): scaffold outline for module NN`
   - Update `docs/presentations/index.md` status to "In Progress"
   - Update `repo-management/status/module-status.md` slides column

6. **Optional follow-up**: spawn `video-script-writer` to refine the narration for AI video generation.

## Hard rules

- Never produce a slide outline without first reading the module's `index.md`
- Never claim a feature exists without learn.microsoft.com support — flag uncertainties for domain-expert review
- Outline lives in the repo as the source of truth; the `.pptx` is built from it
