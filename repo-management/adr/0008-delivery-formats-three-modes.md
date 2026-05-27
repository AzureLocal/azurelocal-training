# ADR-0008: Delivery Formats — Three Modes

**Date:** 2026-05-27
**Status:** Accepted
**Deciders:** @kristopherjturner

## Context

The earlier strategic plan listed four delivery modes:
- In-Person Workshop
- Online Live
- On-Demand Self-Paced (AI-narrated video + slides)
- AI-Led On-Demand (interactive AI tutor)

In practice the last two are a single offering — the on-demand learner consumes both the AI-narrated video AND can interact with the AI tutor for questions, lab walkthroughs, and assessment. Splitting them into separate formats invented a distinction that doesn't exist for the learner.

## Decision

**Three delivery formats**:

| Format | Description |
|---|---|
| **In-Person Workshop** | Multi-day on-site delivery with dedicated lab environment per participant |
| **Online Live** | Scheduled virtual delivery via Teams/Zoom — same content and labs as in-person |
| **On-Demand Self-Paced** | Module library with AI-narrated video, hands-on labs, and the interactive AI tutor (Claude-powered) that teaches modules and guides through labs |

The AI tutor and the AI-narrated video are not separate formats — they are both part of the on-demand self-paced experience.

## Consequences

**Easier:**
- One marketing message per format
- One pricing decision per format
- AI tutor and video content reinforce each other in the same delivery channel

**Harder:**
- On-demand format has TWO content artifacts to produce per module (video + tutor system prompt). Both must be in sync. Acceptable cost because both reinforce learning.

## Alternatives considered

**Four formats (split AI tutor and video):** rejected. The split was artificial — learners don't pick "AI tutor only" vs "video only."

**Two formats (collapse In-Person and Online Live):** rejected. Logistics, pricing, and lab provisioning differ enough between physical and virtual delivery to warrant separate formats.

## Related

- ADR-0005 — 21-module curriculum framework
- [training-platform-plan.md](../training-platform-plan.md) Section 1
