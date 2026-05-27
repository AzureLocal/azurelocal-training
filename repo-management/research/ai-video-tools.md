# Research: AI Video Generation Tools

**Status:** Pending  
**Assigned:** @kristopherjturner  
**Added:** 2026-05-27

## Objective

Identify AI-assisted video generation tools suitable for producing on-demand lesson videos for `azurelocal-training`. The goal is to produce professional-quality instructional video without requiring a full studio production process for every module.

## Requirements

- Can ingest a narration script + slide images or screen recordings
- Produces MP4 output at ≥ 720p
- Supports a consistent presenter voice/avatar across all modules
- Reasonable per-minute cost at scale (10 modules × ~30 min average = ~300 min total)
- Ideally supports batch generation via API (so we can automate from CI or a script)

## Candidates to Evaluate

| Tool | Type | Notes |
|------|------|-------|
| HeyGen | AI avatar + voice | Popular for corporate training; supports script-to-video |
| Synthesia | AI avatar + voice | Strong enterprise features; used by Microsoft partners |
| ElevenLabs | Voice synthesis only | Could pair with screen recording + auto-edit |
| Descript | Screen recording + AI edit | Good for tutorial-style content |
| Adobe Firefly / Premiere AI | AI-assisted edit | Requires existing footage |
| Pika / Runway | Generative video | Not ideal for instructional content |

## Evaluation Criteria

1. **Output quality** — does it look professional enough for paid training?
2. **Script fidelity** — does the narration match the script accurately?
3. **Technical screencasting** — can it handle Azure Portal walkthroughs alongside slides?
4. **API/automation** — is there a programmatic way to generate at scale?
5. **Cost model** — per-minute, per-seat, or flat subscription?

## Findings

_Not yet investigated._

## Actions

_Pending findings._

## Related

- [training-platform-plan.md](../training-platform-plan.md) — Section 5 (Content Delivery)
