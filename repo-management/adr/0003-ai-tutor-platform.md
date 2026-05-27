# ADR-0003: AI Tutor Platform — Next.js + Claude API

**Date:** 2026-05-27  
**Status:** Accepted  
**Deciders:** @kristopherjturner

## Context

A core deliverable of the `azurelocal-training` project is an AI-powered tutor that can teach Azure Local operator training interactively — both on-demand (student self-paces) and live-scheduled (virtual sessions). The tutor must:

- Present module content and lab instructions
- Answer student questions in real time
- Adapt pace to the learner
- Guide through IaC lab steps
- Work in a browser with no install required

A static site generator (MkDocs) cannot support interactive chat. A decision was needed on what platform to build the AI tutor on.

## Decision

Build the AI tutor as a **Next.js application** using the **Anthropic Claude API** (TypeScript/Node SDK).

- Framework: **Next.js 14+** (App Router, Server Components, Server Actions)
- AI: **Anthropic Claude API** — `claude-sonnet-4-6` as the default model, `claude-opus-4-7` for complex reasoning tasks
- Hosting: **Vercel** (primary candidate) or **Azure Static Web Apps** (if Azure-native hosting is preferred)
- URL: `app.training.azurelocal.cloud`
- MkDocs remains for the static marketing/info site at `training.azurelocal.cloud`

## Consequences

**Easier:**
- Claude API gives access to the most capable available model — important for a tutoring use case that requires accurate technical knowledge
- Next.js Server Actions keep the API key server-side — never exposed to the browser
- Vercel deployment is friction-free: push to main, app is live
- Can co-locate app source in the monorepo under `app/` (see ADR-0001)

**Harder:**
- Adds a Node.js/TypeScript build pipeline alongside the Python/MkDocs pipeline
- `ANTHROPIC_API_KEY` must be managed as a production secret — costs real money per token
- Requires a separate deployment target beyond GitHub Pages
- Stateful sessions (student progress tracking, conversation history) need a backend data store — out of scope for MVP

## Alternatives Considered

**Streamlit (Python):** Simple to build, but requires a persistent Python server — not serverless-friendly. Rejected.

**Gradio:** Similar Python limitation. Rejected.

**Static HTML + client-side API calls:** Exposes API key in browser. Rejected on security grounds.

**Azure OpenAI Service:** Possible alternative to Anthropic API. Would add Azure dependency and subscription cost complexity. Claude API is simpler for a single-developer project. Can revisit if enterprise procurement requires Azure-native AI.

## Research Required

See [research/anthropic-github-findings.md](../research/anthropic-github-findings.md) — starter templates, MCP servers, and eval frameworks from `github.com/anthropics` that could seed the implementation.
