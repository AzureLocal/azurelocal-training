---
description: Scaffold a PowerPoint outline + narration script for a module.
---

Invoke the `workstream-new-slides` skill. Argument: module number (00–19).

The skill should:

1. Read `docs/<NN>-<slug>/index.md` for the module's topics, learning objectives, and labs
2. Spawn `slide-content-author` to produce:
   - `slides/<NN>-<slug>/outline.md` — slide-by-slide outline
   - `slides/<NN>-<slug>/narration-script.md` — per-slide timed narration
3. Human gate: stop and ask for review before proceeding
4. After approval: commit and update the status board

The actual `.pptx` is built by the human author from the outline (using Copilot in PowerPoint or manual authoring). This skill produces the source-of-truth outline only.
