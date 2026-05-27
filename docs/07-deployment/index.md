# Module 07: Deployment

**Level:** L200–L300 | **Duration:** 5 hours | **Prerequisites:** Modules 00–06 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

This module covers the **deployment methods and architectural choices** for standing up an Azure Local cluster. The cluster lands at the end of this module ready for post-deployment configuration (Module 08).

## Learning Objectives

- Choose between Storage Spaces Direct (S2D), SAN-attached storage, or a hybrid storage architecture for an Azure Local cluster
- Choose between Active Directory–joined and local-identity (cloud-only / Entra) cluster identity models
- Choose between Azure Portal cloud-managed deployment, ARM/Bicep templates, and the Microsoft cloud-managed (zero-touch) deployment path
- Execute a cluster deployment end-to-end through the chosen path
- Validate that cluster deployment succeeded and that Arc Resource Bridge + infrastructure logical network are present

## Topics

1. **Deployment Architecture Overview** — Portal → Arc → on-premises cluster
2. **Storage Architecture Choices**
    - Storage Spaces Direct (S2D) — when to choose
    - SAN-attached storage — when to choose
    - Hybrid (S2D + SAN) — when to choose
3. **Identity Architecture Choices**
    - Active Directory–joined deployment — when to choose
    - Local-identity / cloud-only / Entra deployment — when to choose
4. **Deployment Automation Choices**
    - Azure Portal cloud-managed deployment — interactive walkthrough
    - ARM and Bicep template-driven deployment — repeatable infrastructure-as-code path
    - Microsoft cloud-managed (zero-touch) deployment path
5. **Pre-Deployment Validation** — environment checker, network validation, hardware verification
6. **Executing the Deployment** — end-to-end run of the chosen path
7. **Cluster Deployment Validation** — Arc Resource Bridge present, infrastructure logical network created, cluster registered with Arc

## Hands-on

**Lab:** Deploy a cluster via the Azure Portal cloud-managed path (against a sandbox or customer hardware). Validate Arc Resource Bridge and infrastructure logical network are present. Hand off to Module 08.

IaC: Bicep templates for sandbox cluster preparation in [`labs/iac/07-deployment/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac/07-deployment) (planned).

## What this module does NOT cover

- Configuring the cluster for workload use (storage paths, VM images, tenant logical networks, RBAC for VM management) — that's **Module 08: Post-Deployment Configurations**
- Day-to-day management after deployment — **Module 09: Management**

## Related Resources

- [Azure Local deployment documentation](https://learn.microsoft.com/azure/azure-local/deploy/)
- Slides: `slides/07-deployment/` (planned)
