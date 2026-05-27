# ADR-0009: Lab Environments — Three Target Options

**Date:** 2026-05-27
**Status:** Accepted
**Deciders:** @kristopherjturner

## Context

Earlier drafts of the lab strategy named Azure Arc Jumpstart HCIBox as a primary lab option. That conflicts with the workshop's direction: we own and ship our own lab building solutions, not third-party Jumpstart artifacts. We also need to support learners and customers who already have Azure Local hardware or a physical Hyper-V host they want to use as a nested-virt lab.

## Decision

Every lab in the curriculum supports **three target environments**, all powered by the lab building solutions we author and ship under `labs/iac/`:

### A. Azure (cloud-hosted)

A nested-virtualization Azure Local lab built inside an Azure VM. No on-premises hardware required.

- For: self-paced learners, AI-led on-demand, online live workshops without physical lab kit
- Built by: our Bicep templates in `labs/iac/`
- Cost: the learner's (or workshop's) Azure subscription

### B. Physical Hyper-V server (nested environment)

The learner's or customer's existing physical Hyper-V host running the lab as nested VMs.

- For: students with existing hardware on a Hyper-V host, customers running labs on-prem without cloud cost, instructor-provided physical lab kit at an in-person workshop
- Built by: PowerShell + DSC scripts in `labs/iac/onprem/` (planned)
- Cost: existing hardware only

### C. Actual Azure Local hardware

The learner's or customer's own production or pilot Azure Local cluster.

- For: customers training operators against the real hardware they run in production
- Built by: N/A — environment already exists
- Cost: none beyond existing cluster

Each environment supports two deployment patterns:

- **Student-deployed** (self-guided / on-demand)
- **Moderator-deployed** (instructor-led, in-person) with a `participantCount` parameter for batch provisioning

## Consequences

**Easier:**
- Customers with existing Azure Local hardware or Hyper-V hosts don't pay Azure cost for labs
- Same lab content runs against all three target environments — author once
- HCIBox is not a dependency; we control the lab platform end-to-end

**Harder:**
- THREE deployment paths to maintain per template (Azure Bicep, on-prem PowerShell/DSC, real-hardware adapter). Mitigated by sharing as much logic as possible and accepting some divergence per target.
- The on-prem (B) path requires more authoring effort than the cloud (A) path because we own the host setup steps

## Alternatives considered

**Use Azure Arc Jumpstart HCIBox:** rejected. Third-party artifact we don't control; conflicts with the workshop's direction to own the lab platform.

**Azure-only (drop B and C):** rejected. Many enterprise customers want labs on hardware they already own.

**Hardware-only (drop A):** rejected. Self-paced and online-live learners need a cloud-deployable option.

## Related

- ADR-0005 — 21-module curriculum framework
- [docs/labs/index.md](../../docs/labs/index.md)
- [training-platform-plan.md](../training-platform-plan.md) Section 6
