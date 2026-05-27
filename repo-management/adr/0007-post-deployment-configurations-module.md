# ADR-0007: Post-Deployment Configurations as a Dedicated Module

**Date:** 2026-05-27
**Status:** Accepted
**Deciders:** @kristopherjturner

## Context

The cluster-deployment workflow (Module 07) ends when cluster deployment completes via the chosen method (Portal / ARM Template, S2D / SAN, AD / Local identity). After that, there is a distinct set of operator tasks the cluster needs before any workload can be deployed. The canonical source of truth is the **azurelocal.cloud implementation guide, Phase 06: Post-Deployment Cluster Configuration**:

https://azurelocal.cloud/docs/next/implementation/04-cluster-deployment/phase-06-post-deployment/

Per that implementation runbook, the post-deployment tasks are:

1. Task 01 — Deploy SDN (Network Controller, Software Load Balancer, RAS Gateway)
2. Task 02 — Cluster Quorum Configuration (Cloud Witness / File Share Witness / Disk Witness)
3. Task 03 — Security Groups Applied to Nodes (RBAC, administrative access control)
4. Task 04 — SSH Connectivity to Nodes
5. Task 05 — Storage Configuration (S2D pool review, CSV volume creation, storage path creation)
6. Task 06 — Image Downloads (Marketplace and custom images staged to storage paths)
7. Task 07 — Configure Network Security Groups
8. Task 08 — Logical Network Creation (workload VLANs, IP pools, network properties)
9. Task 09 — Post-Deployment Verification

Initial draft of the curriculum had these collapsed inside Module 09 Management or Module 07 Deployment. Both fits were poor:

- **Inside Management:** mixes one-time-setup with day-to-day operational tasks. Confuses learners about when these things happen.
- **Inside Deployment:** Deployment module is already large (planning, methods, identity, automation paths). Bundling post-deploy makes it unwieldy and obscures the discipline boundary.

## Decision

Post-Deployment Configurations is **Module 08**, its own module under the Deployment track. It immediately follows Module 07 (Deployment) and precedes the Operations track.

Scope mirrors the 9 tasks of implementation Phase 06:

- Deploy SDN infrastructure (Network Controller, SLB, RAS Gateway)
- Cluster quorum configuration
- Security groups applied to nodes (RBAC)
- SSH connectivity to nodes
- Storage configuration (S2D pool review, CSV volumes, storage paths)
- Image downloads (Marketplace + custom)
- Network Security Groups
- Logical network creation (workload VLANs, IP pools)
- Post-deployment verification

Scope is bounded by "things the operator does once, after deployment completes, before workloads land." Things that happen continuously (monitoring, updates, security drift remediation) map to the Operations track (Modules 09–14) and to the implementation guide's Phase 05: Operational Foundations.

## Consequences

**Easier:**
- Clear discipline boundary between cluster deployment (Module 07) and cluster configuration for workload use (Module 08)
- Learners understand WHY they're doing each step because the module exists as a focused unit
- Maps directly to the official Microsoft VM management workflow, which is the canonical reference
- Workloads modules (15-18) can assume Module 08 is complete — they don't have to re-teach storage paths or logical networks

**Harder:**
- One more module to author (21 total vs 20)
- Requires the Module 07 lab to leave the cluster in a "deployed but not yet configured" state so Module 08's lab has something to do

## Alternatives considered

**Fold into Module 07 Deployment:** rejected. Deployment is already wide (methods + identity + storage architecture + automation paths). Adding storage paths + VM images + logical networks + RBAC for VMs makes it sprawl.

**Fold into Module 09 Management:** rejected. Management is about day-to-day operator tasks (Portal navigation, CLI, WAC, OMSWAC), not one-time post-deploy setup.

**Spread across the Workloads modules (15-18):** rejected. Every workload module would have to re-teach storage paths, logical networks, VM images. Duplicative and brittle.

## Related

- ADR-0005 — 21-module curriculum framework
- ADR-0006 — Foundations first, then Deployment
- [azurelocal.cloud — Phase 06: Post-Deployment Cluster Configuration](https://azurelocal.cloud/docs/next/implementation/04-cluster-deployment/phase-06-post-deployment/)
- [azurelocal.cloud — Implementation Guide overview](https://azurelocal.cloud/docs/next/implementation/)
