# ADR-0005: 21-Module Curriculum Framework with Five Learning Tracks

**Date:** 2026-05-27
**Status:** Accepted
**Deciders:** @kristopherjturner

## Context

The Azure Local Operator Training curriculum needs a structural framework that scales across all delivery formats (in-person workshops, online live, on-demand self-paced) and supports a workshop-first approach with hands-on labs, IaC, slides, and an AI tutor for every module.

The legacy Azure Stack HCI workshop had ~10 modules with significant bundling (Compute included Hyper-V, VM mobility, Backups, DR, Troubleshooting all in one module). The original draft for the Azure Local curriculum had 11 modules in the current stubs. The user's review concluded the curriculum needs more discrete modules covering the actual breadth of Azure Local operations.

## Decision

The curriculum is **21 modules organized into 5 learning tracks**:

**Foundations (6)** — what Azure Local is and the technology underneath:
- 00 Introduction to Azure Local
- 01 Azure Arc — Infrastructure Deep Dive
- 02 Compute (Hyper-V + Failover Clustering + Arc VMs)
- 03 Storage
- 04 Core Networking
- 05 Software Defined Networking (Arc-managed)

**Deployment (3)** — plan, deploy, and configure the cluster for workload use:
- 06 Planning & Sizing
- 07 Deployment
- 08 Post-Deployment Configurations

**Operations (6)** — run the platform:
- 09 Management
- 10 Security & Compliance
- 11 Observability & Monitoring
- 12 Troubleshooting
- 13 BCDR
- 14 Day-2 Operations & Lifecycle

**Workloads (4)** — add workloads:
- 15 AKS on Azure Local
- 16 Azure Virtual Desktop on Azure Local
- 17 IoT Operations on Azure Local
- 18 Azure AI Foundry Local

**Adoption (2)** — bring existing estates in, support special enterprise paths:
- 19 Migration (VMware / Hyper-V → Azure Local)
- 20 SCVMM (Optional / Placeholder)

## Consequences

**Easier:**
- Each module is a discrete unit with its own slides, lab, IaC, narration, and AI tutor session
- Delivery programs (Foundations, Full Stack, Migration Track, etc.) are curated subsets of modules — no content duplication
- Maps cleanly to the artifact set in Section 3.3 of the strategic plan
- Five tracks let learners self-select a focused path instead of consuming all 21 modules

**Harder:**
- More modules = more content to author. Mitigated by agent-driven content authoring (training-pm, training-content-author, lab-iac-engineer, slide-content-author).
- Renumbering modules later breaks links — every rename has a ripple effect across `docs/`, `mkdocs.yml`, ADO work-item titles, IaC paths, slide paths

## Alternatives considered

**Keep the 11-module legacy bundling:** rejected — bundles too many disciplines (e.g. Compute + Backups + DR + Troubleshooting in one module), forces learners to consume more than they need

**Mirror the Splitbrain 3-day workshop (Foundations / Deployment / Workloads):** rejected — too coarse; Splitbrain bundles many Azure Local disciplines into single days, fine for a 3-day sales-led workshop but not for a comprehensive operator curriculum

**20 modules without Post-Deployment Configurations:** initial proposal but rejected by user — the cluster-deployment workflow ends with Arc Resource Bridge + infrastructure logical network created; configuring the cluster for workload use (storage paths, VM images, tenant logical networks, RBAC for VM management) is a distinct discipline worth its own module. See ADR-0007.

## Related

- ADR-0006 — Track ordering (Foundations first, Deployment second, Operations third)
- ADR-0007 — Post-Deployment Configurations as its own module
- [training-platform-plan.md](../training-platform-plan.md) Section 3.1
