# ADR-0001: Monorepo Strategy for Training Content

**Date:** 2026-05-27  
**Status:** Accepted  
**Deciders:** @kristopherjturner

## Context

The `azurelocal-training` project will produce multiple distinct artifact types: MkDocs documentation, PowerPoint slide decks, Bicep/Terraform IaC templates, Next.js AI tutor application, narration scripts, and exported video assets. These could live in separate repositories (one per artifact type) or in a single monorepo.

The project is currently a single GitHub repo maintained by one owner, with no external contributors yet.

## Decision

Keep all training content in a single monorepo under `AzureLocal/azurelocal-training`.

Directory layout:
```
docs/          — MkDocs lab guides and marketing/info pages
labs/iac/      — Bicep, Terraform, ARM templates per module
slides/        — PowerPoint source files (.pptx via Git LFS)
app/           — Next.js AI tutor application
content/       — Narration scripts, storyboards, raw video assets
referrence/    — Legacy workshop materials (read-only, migrating out)
repo-management/ — PM documents, ADRs, status, research
```

## Consequences

**Easier:**
- One PR can update the lab guide, the IaC template, and the slide deck together — atomicity across artifact types
- Single CODEOWNERS file, single CI pipeline, single issue tracker
- Claude Code agents can reference all artifact types in one context

**Harder:**
- Git LFS storage counts against a single repo quota — large video assets could become a problem
- Next.js app and MkDocs site live in the same repo — `deploy-docs.yml` and `ai-tutor-deploy.yml` must have careful path filters to avoid triggering each other
- Repository clone size will grow as .pptx and video assets accumulate

## Alternatives Considered

**Multi-repo (one per artifact type):** Rejected. Too much cross-repo coordination friction for a one-person project at this stage. Can revisit if the team grows beyond 3-4 contributors.

**Separate app repo:** Keep `azurelocal-training-app` for the Next.js AI tutor. Reasonable if the app grows into a significant engineering project. Left as a future option.
