# ADR-0004: Git LFS for Binary Assets

**Date:** 2026-05-27  
**Status:** Accepted  
**Deciders:** @kristopherjturner

## Context

The `azurelocal-training` project will produce PowerPoint decks (`.pptx`), slide export images (`.png`), and potentially video assets (`.mp4`). These binary files are large and do not diff meaningfully in Git. Storing them as regular Git objects would bloat the repository history and make clones slow.

## Decision

Use **Git Large File Storage (Git LFS)** for all binary assets.

Files tracked via LFS:
- `*.pptx` — PowerPoint source files
- `*.mp4`, `*.mov` — video assets (if stored in this repo)
- `*.png`, `*.jpg`, `*.jpeg`, `*.gif` — images above a trivial size
- `*.pdf` — exported slide PDFs

Configuration goes in a `.gitattributes` file at the repo root (not in `referrence/`, which has its own `.gitattributes`).

## Consequences

**Easier:**
- Repository clone is fast — large binaries are replaced by small LFS pointer files
- Git history stays clean — binary file changes don't bloat `.git/objects`
- GitHub supports LFS natively — works with all existing workflows

**Harder:**
- Every developer machine must have `git lfs install` run once
- GitHub Free tier: 1 GB LFS storage + 1 GB/month bandwidth. 10 modules × ~50 MB .pptx = ~500 MB — within free tier now, but video assets would exceed it quickly
- If video assets grow large, a CDN or dedicated storage (Azure Blob, S3) is a better fit than LFS
- CI runners that clone the repo need LFS support — `actions/checkout@v4` supports this with `lfs: true`

## Alternatives Considered

**Store binaries in regular Git:** Rejected. Acceptable for a handful of small images; not acceptable for multiple 50 MB .pptx files.

**CDN / Azure Blob Storage:** Better for large videos. Could be used for `.mp4` while keeping `.pptx` in LFS. Deferred — implement if/when video assets are created.

**Submodule with dedicated assets repo:** Adds coordination complexity. Rejected in favor of monorepo (see ADR-0001).

## Implementation

See [setup.md — Git LFS](../setup.md#git-lfs) for one-time setup commands and the `.gitattributes` content.

**Current status:** Planned. No `.gitattributes` exists at the repo root yet. Implement when the first `.pptx` file is added.
