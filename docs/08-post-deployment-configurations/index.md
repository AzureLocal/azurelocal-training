# Module 08: Post-Deployment Configurations

**Level:** L300 | **Duration:** 5 hours | **Prerequisites:** Module 07 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

Once the cluster-deployment workflow completes (Module 07), a distinct set of operator tasks must be done before the cluster is ready for workloads. This module mirrors **Phase 06: Post-Deployment Cluster Configuration** in the [azurelocal.cloud implementation guide](https://azurelocal.cloud/docs/next/implementation/04-cluster-deployment/phase-06-post-deployment/).

## Learning Objectives

- Deploy the Software Defined Networking infrastructure (Network Controller, Software Load Balancer, RAS Gateway)
- Configure cluster quorum (Cloud Witness, File Share Witness, or Disk Witness)
- Apply security groups to cluster nodes for RBAC and administrative access
- Enable SSH connectivity to cluster nodes for remote administration
- Review the S2D pool and create CSV volumes for VM storage
- Create storage paths in Azure mapped to CSV volumes
- Download and stage VM images (Azure Marketplace and custom) to storage paths
- Configure Network Security Groups
- Create logical networks for workload VLANs (with VLAN IDs, IP pools, properties)
- Run post-deployment verification across all tasks

## Topics — mirrors implementation Phase 06 tasks

1. **Task 01 — Deploy SDN** — Network Controller, Software Load Balancer, RAS Gateway
2. **Task 02 — Cluster Quorum Configuration** — Cloud Witness / File Share Witness / Disk Witness
3. **Task 03 — Security Groups Applied to Nodes** — RBAC, administrative access control
4. **Task 04 — SSH Connectivity to Nodes** — remote administration and troubleshooting
5. **Task 05 — Storage Configuration**
    - Review S2D pool (capacity, resiliency, health)
    - Create CSV volumes for VM storage (naming, resiliency, provisioning type)
    - Create storage paths in Azure mapped to the CSV volumes
6. **Task 06 — Image Downloads** — Azure Marketplace images and custom images, staged to storage paths
7. **Task 07 — Configure Network Security Groups**
8. **Task 08 — Logical Network Creation** — workload VLANs, VLAN IDs, IP pools, network properties
9. **Task 09 — Post-Deployment Verification** — validate everything across all the above tasks

## Hands-on

**Lab:** Take a freshly deployed cluster (output of Module 07) and bring it to workload-ready state. Apply security groups, configure quorum, create CSV volumes and storage paths, download a Marketplace image, create a tenant logical network with an IP pool, verify.

IaC: Bicep + PowerShell in [`labs/iac/08-post-deployment-configurations/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac/08-post-deployment-configurations) (planned).

## What this module does NOT cover

- Cluster deployment itself — **Module 07**
- Day-to-day management — **Module 09**
- Operational foundations (monitoring, backup/DR, security/governance, licensing/telemetry, ongoing SDN ops) — those map to the **Operations** track (Modules 10–14) and to **Phase 05: Operational Foundations** in the implementation guide
- Workload deployment (VMs, AKS, AVD, IoT, Foundry Local) — the **Workloads** track (Modules 15–18)

## Related Resources

- [azurelocal.cloud — Phase 06: Post-Deployment Cluster Configuration](https://azurelocal.cloud/docs/next/implementation/04-cluster-deployment/phase-06-post-deployment/)
- [azurelocal.cloud — Implementation Guide overview](https://azurelocal.cloud/docs/next/implementation/)
- ADR: [0007 — Post-Deployment Configurations as its own module](https://github.com/AzureLocal/azurelocal-training/blob/main/repo-management/adr/0007-post-deployment-configurations-module.md)
- Slides: `slides/08-post-deployment-configurations/` (planned)
