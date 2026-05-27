# ADR-0002: Custom Subdomain training.azurelocal.cloud

**Date:** 2026-05-27  
**Status:** Accepted  
**Deciders:** @kristopherjturner

## Context

The `azurelocal.cloud` domain is owned and managed in Cloudflare. The training platform was previously reachable at `azurelocal.cloud/azurelocal-training` (a path under the main GitHub Pages site). Two options were considered for the training platform's permanent URL.

## Decision

Use `training.azurelocal.cloud` as the canonical URL for the training platform's static docs/marketing site.

The AI tutor interactive app will be hosted at `app.training.azurelocal.cloud` (separate subdomain, separate deployment target).

## Consequences

**Easier:**
- Clean, brandable URL — easier to put on marketing materials and event slides
- Decouples the training site from the main `azurelocal.cloud` site — can deploy independently
- Consistent with the pattern used by other AzureLocal sub-products

**Harder:**
- Requires Cloudflare CNAME + GitHub Pages custom domain configuration (documented in [setup.md](../setup.md))
- TLS certificate provisioning takes up to 24 hours on first setup
- Cloudflare proxy must be **disabled** (DNS only) for GitHub Pages TLS to work — cannot use Cloudflare CDN features on this subdomain

## Alternatives Considered

**Path-based (`azurelocal.cloud/training`):** Rejected. Requires coordinating deploys with the main site repo. Training should be independently deployable.

**Separate apex domain (`training-azurelocal.cloud` or similar):** Rejected. We already own `azurelocal.cloud` — a subdomain is free and keeps branding coherent.

## Implementation

See [setup.md — Domain Setup](../setup.md#domain-setup-trainingazurelocalcloud) for step-by-step Cloudflare and GitHub Pages configuration.
