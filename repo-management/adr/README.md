# Architecture Decision Records

Lightweight records of significant technical and platform decisions. Each ADR captures what was decided, why, and what alternatives were considered.

## Index

| ADR | Title | Status |
|-----|-------|--------|
| [0001](0001-monorepo-strategy.md) | Monorepo vs multi-repo for training content | Accepted |
| [0002](0002-subdomain-training.md) | Custom subdomain training.azurelocal.cloud | Accepted |
| [0003](0003-ai-tutor-platform.md) | AI tutor platform — Next.js + Claude API | Accepted |
| [0004](0004-git-lfs-binaries.md) | Git LFS for binary assets (.pptx, video) | Accepted |
| [0005](0005-curriculum-21-module-framework.md) | 21-module curriculum framework with 5 tracks | Accepted |
| [0006](0006-track-ordering-foundations-first.md) | Track ordering — Foundations before Deployment | Accepted |
| [0007](0007-post-deployment-configurations-module.md) | Post-Deployment Configurations as its own module | Accepted |
| [0008](0008-delivery-formats-three-modes.md) | Delivery formats — three modes | Accepted |
| [0009](0009-lab-environments-three-targets.md) | Lab environments — three targets | Accepted |

## Format

```markdown
# ADR-NNNN: Title

**Date:** YYYY-MM-DD  
**Status:** Proposed | Accepted | Superseded by [ADR-XXXX]  
**Deciders:** @kristopherjturner

## Context

What problem are we solving and why does it matter?

## Decision

What we decided to do.

## Consequences

What becomes easier, harder, or constrained by this decision.

## Alternatives considered

What else was evaluated and why it was not chosen.
```

## Status values

- **Proposed** — under discussion, not yet final
- **Accepted** — decided and being implemented
- **Superseded** — replaced by a newer ADR (link to it)
- **Deprecated** — no longer relevant
