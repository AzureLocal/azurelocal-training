# Module 08: Post-Deployment Configurations

**Level:** L300 | **Duration:** 4 hours | **Prerequisites:** Module 07 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

After the cluster-deployment workflow completes (Module 07), a distinct set of operator tasks must be done before any workload — VM, AKS, AVD, IoT Operations, or AI Foundry Local — can be deployed. This module covers those tasks, which collectively prepare the cluster to host workloads.

Source: [Microsoft Learn — Azure Local VM management workflow](https://learn.microsoft.com/azure/azure-local/manage/azure-arc-vm-management-overview).

## Learning Objectives

- Assign the built-in RBAC roles required for Azure Local VM management
- Create and manage storage paths for VM disks
- Create VM images from Azure Marketplace, an Azure Storage account, or a local share
- Create tenant logical networks beyond the auto-created infrastructure logical network
- Create VM network interfaces
- Verify the Custom Location that maps the Arc Resource Bridge to the cluster
- Perform initial Arc-managed SDN configuration when SDN is in use
- Validate the cluster is ready for workload deployment

## Topics

1. **Built-in RBAC for Azure Local VM Management** — roles, scope, assignment
2. **Storage Paths** — concepts, creation, lifecycle, mapping to S2D volumes
3. **VM Images**
    - From Azure Marketplace
    - From an Azure Storage account
    - From a local share
4. **Tenant Logical Networks** — beyond the infrastructure logical network, designing tenant networks and IP pools for Arc VMs
5. **VM Network Interfaces** — creation, attachment to logical networks
6. **Custom Location** — verification and use for resource creation
7. **Arc-Managed SDN Initial Configuration** — when SDN is in use
8. **Workload-Readiness Validation** — final checks before Module 15+ (workloads)

## Hands-on

**Lab:** Take a freshly deployed cluster (output of Module 07) and bring it to workload-ready state. Assign RBAC roles. Create a storage path. Pull an image from Azure Marketplace. Create a tenant logical network with an IP pool. Verify the Custom Location. Validate everything is operational.

IaC: Bicep templates in [`labs/iac/08-post-deployment-configurations/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac/08-post-deployment-configurations) (planned).

## What this module does NOT cover

- Cluster deployment itself — that's **Module 07: Deployment**
- Day-to-day management — that's **Module 09: Management**
- Creating actual VMs / AKS clusters / AVD host pools / IoT Operations / Foundry Local — those are the **Workloads** track (Modules 15–18)

## Related Resources

- [Azure Local VM management overview](https://learn.microsoft.com/azure/azure-local/manage/azure-arc-vm-management-overview)
- [Create storage paths](https://learn.microsoft.com/azure/azure-local/manage/create-storage-path)
- [VM images from Azure Marketplace](https://learn.microsoft.com/azure/azure-local/manage/virtual-machine-image-azure-marketplace)
- [Create logical networks](https://learn.microsoft.com/azure/azure-local/manage/create-logical-networks)
- [Assign VM RBAC roles](https://learn.microsoft.com/azure/azure-local/manage/assign-vm-rbac-roles)
- Slides: `slides/08-post-deployment-configurations/` (planned)
- ADR: [0007 — Post-Deployment Configurations as its own module](https://github.com/AzureLocal/azurelocal-training/blob/main/repo-management/adr/0007-post-deployment-configurations-module.md)
