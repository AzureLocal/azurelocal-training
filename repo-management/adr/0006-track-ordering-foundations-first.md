# ADR-0006: Track Ordering — Foundations First, Then Deployment, Then Operations

**Date:** 2026-05-27
**Status:** Accepted
**Deciders:** @kristopherjturner

## Context

With 21 modules organized into 5 tracks (see ADR-0005), the ordering of those tracks affects how learners experience the curriculum and how the modules relate to each other.

Two competing orderings were considered:

**Option A: Deployment first** — get the cluster up, then teach the underlying tech, then run it. Mirrors how an operator usually encounters Azure Local in real life ("I just deployed this thing, how do I use it?").

**Option B: Foundations first** — explain what Azure Local is and the technology underneath BEFORE walking through deployment. The chosen option.

## Decision

**Foundations comes first.** Track ordering is:

1. **Foundations** — what Azure Local is + the underlying technology (Hyper-V, Failover Clustering, Arc VMs, S2D, Network ATC, SDN, Arc Resource Bridge)
2. **Deployment** — planning, deployment methods (S2D vs SAN vs both; AD vs local identities; Portal vs ARM vs Microsoft cloud-managed deployment), and post-deployment configurations
3. **Operations** — running the platform (management, security/compliance, observability, troubleshooting, BCDR, day-2 ops)
4. **Workloads** — AKS, AVD, IoT Operations, AI Foundry Local
5. **Adoption** — migration paths, SCVMM coexistence

## Consequences

**Easier:**
- Learners understand the technology decisions they're making during deployment because they've already seen the underlying tech (e.g. they know what S2D is when choosing storage architecture)
- Aligns with the educational principle "teach the what before the how"
- Operator persona — the audience — already operates infrastructure, so the foundational technology mapping is the natural entry point
- The Operations track depends on a deployed cluster but doesn't depend on having walked through the deployment workflow personally (the docs cover it)

**Harder:**
- Foundations labs may demonstrate against a pre-deployed cluster the learner didn't build themselves. This is the standard pattern (instructor-provided or pre-built lab) and is supported by the lab environment options (see ADR-0009).
- Some learners come for "how do I deploy this" specifically — they may want to skip ahead. The delivery-program design accommodates this by allowing Foundations to be a separate offering from Deployment.

## Alternatives considered

**Deployment first (Option A above):** rejected. While it mirrors the real-world entry point, it forces learners to make architectural decisions (S2D vs SAN, AD vs local identity, Network ATC intents) before they understand the underlying technology. That produces shallow understanding and worse decisions.

**Mixed ordering (Intro → Deployment → Foundations → Operations):** rejected. The Foundations content is foundational to Operations as well; separating Intro and Foundations across the deployment boundary makes the curriculum feel split.

## Related

- ADR-0005 — 21-module curriculum framework
- ADR-0007 — Post-Deployment Configurations as its own module
