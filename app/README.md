# Azure Local Training — AI Tutor

Next.js + Anthropic Claude API application that delivers the interactive AI-led learning experience for the Azure Local Training curriculum. Lives at `app.training.azurelocal.cloud` (planned).

## Status

**Scaffold only.** This is a skeleton that proves the architecture. No production deployment yet. See [ADR-0003](../repo-management/adr/0003-ai-tutor-platform.md) for the platform decision and [`research/anthropic-github-findings.md`](../repo-management/research/anthropic-github-findings.md) before significant build-out.

## Stack

| Layer | Choice |
|-------|--------|
| Framework | Next.js 14+ (App Router) |
| AI SDK | `@anthropic-ai/sdk` (TypeScript) |
| Default model | `claude-sonnet-4-6` |
| Escalation model | `claude-opus-4-7` |
| Hosting (primary) | Vercel |
| Hosting (alternate) | Azure Static Web Apps |
| Persistence | Stateless (Supabase later if needed) |
| Auth | None initially (gated later) |

## Project structure (planned)

```
app/
├── README.md                  ← this file
├── package.json               ← deps + scripts
├── tsconfig.json
├── next.config.mjs
├── .env.example               ← documents required env vars
├── .gitignore                 ← node_modules, .next, .env.local
├── src/
│   ├── app/
│   │   ├── layout.tsx
│   │   ├── page.tsx           ← Landing / module selector
│   │   ├── learn/
│   │   │   └── [module]/
│   │   │       └── page.tsx   ← AI tutor session per module
│   │   ├── api/
│   │   │   └── chat/
│   │   │       └── route.ts   ← Claude API streaming proxy
│   │   └── globals.css
│   ├── components/
│   │   ├── ChatUI.tsx
│   │   ├── ModuleSelector.tsx
│   │   └── SystemPromptLoader.tsx
│   └── lib/
│       ├── anthropic.ts       ← SDK initialization
│       ├── prompts.ts         ← System prompt builders per module
│       └── moduleContent.ts   ← Loads module markdown into context
└── public/
    └── favicon.ico
```

## Environment variables

| Variable | Purpose |
|----------|---------|
| `ANTHROPIC_API_KEY` | Claude API key — server-side only, never exposed to browser |
| `ANTHROPIC_MODEL` | Override default model (defaults to `claude-sonnet-4-6`) |
| `NEXT_PUBLIC_SITE_URL` | Public URL for canonical links |

Copy `.env.example` to `.env.local` and fill in.

## Local development

```bash
cd app
npm install
npm run dev
# http://localhost:3000
```

## Deployment

| Target | How |
|--------|-----|
| Vercel | `vercel --prod` (or wire to GitHub via Vercel integration) |
| Azure SWA | Use the `swa` CLI or `Azure/static-web-apps-deploy@v1` action |

## Key references

- [ADR-0003: AI tutor platform](../repo-management/adr/0003-ai-tutor-platform.md)
- [Strategic plan — Section 4 (AI tutor)](../repo-management/training-platform-plan.md)
- [Research: Anthropic GitHub](../repo-management/research/anthropic-github-findings.md)
- [Anthropic TypeScript SDK](https://github.com/anthropics/anthropic-sdk-typescript)

## When you work on this app

Use the `ai-tutor-engineer` agent — it knows the conventions, the system prompt pattern, and the rate-limiting requirements.
