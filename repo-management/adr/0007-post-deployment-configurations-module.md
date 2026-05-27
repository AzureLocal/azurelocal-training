# ADR-0007: Post-Deployment Configurations as a Dedicated Module

**Date:** 2026-05-27
**Status:** Accepted
**Deciders:** @kristopherjturner

## Context

The cluster-deployment workflow (Module 07) ends when:
- Cluster validation passes
- Arc Resource Bridge VM is created
- Infrastructure logical network is auto-created
- Cluster is registered to Arc

After that, there is a distinct set of operator tasks the cluster needs before any workload (VM, AKS, AVD, IoT, AI Foundry) can be deployed. Per the [Microsoft Learn — Azure Local VM management workflow](https://learn.microsoft.com/azure/azure-local/manage/azure-arc-vm-management-overview), these tasks are:

1. Assign built-in RBAC roles for Azure Local VM management
2. Create **storage paths** for VM disks
3. Create **VM images** (Azure Marketplace / Azure Storage account / local share)
4. Create **logical networks** (tenant networks beyond the auto-created infra logical network)
5. Create **VM network interfaces**
6. Verify the **custom location** mapping the Arc Resource Bridge to the cluster
7. Configure **Arc-managed SDN** if SDN is in use
8. Validate everything is functional before workloads land

Initial draft of the curriculum had these collapsed inside Module 09 Management or Module 07 Deployment. Both fits were poor:

- **Inside Management:** mixes one-time-setup with day-to-day operational tasks. Confuses learners about when these things happen.
- **Inside Deployment:** Deployment module is already large (planning, methods, identity, automation paths). Bundling post-deploy makes it unwieldy and obscures the discipline boundary.

## Decision

Post-Deployment Configurations is **Module 08**, its own module under the Deployment track. It immediately follows Module 07 (Deployment) and precedes the Operations track.

Scope:
- Built-in RBAC role assignment for Azure Local VM management
- Storage paths configuration
- VM image creation and management (Marketplace / Storage account / local share)
- Logical networks (tenant networks for Arc VMs and IP pool design)
- VM network interfaces
- Custom Location verification
- Arc-managed SDN initial configuration (when used)
- Final validation that the cluster is ready for workloads

Scope is bounded by "things the operator does once, after deployment completes, before workloads land." Things that happen continuously (monitoring, updates, security drift remediation) belong in the Operations track.

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
- [Microsoft Learn — Azure Local VM management workflow](https://learn.microsoft.com/azure/azure-local/manage/azure-arc-vm-management-overview)
