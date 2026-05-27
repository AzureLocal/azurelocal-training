# Module 05: Compute (Hyper-V + Failover Clustering + Arc VMs)

**Level:** L200–L300 | **Duration:** 5 hours | **Prerequisites:** Module 04 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

## Learning Objectives

- Describe the Hyper-V host platform on Azure Local
- Understand Failover Clustering as the foundation for compute, storage, and network HA
- Configure cluster witness (Cloud Witness, file share witness) and quorum
- Use Cluster-Aware Updating (CAU) for node maintenance
- Deploy and manage Arc VMs via Portal and Bicep
- Use VM images and the Marketplace gallery on Azure Local
- Perform live migration and configure VM high availability

## Topics

1. Hyper-V Host Platform on Azure Local
2. Failover Clustering Fundamentals — quorum, witness types, **Cloud Witness**
3. Cluster-Aware Updating (CAU) — drain, update, fail-back patterns
4. Arc VM Architecture — Hyper-V engine, Arc as the interface
5. Deploying Arc VMs — Portal walkthrough
6. Deploying Arc VMs with Bicep (IaC) — parameterized templates
7. VM Lifecycle — start/stop/restart, resize, disk management
8. VM Images and Marketplace Gallery
9. Live Migration — configuration and operational use
10. VM High Availability — priority, placement rules

## Hands-on

**Lab:** Deploy an Arc VM via Portal. Deploy a second VM via Bicep. Perform live migration. Add cluster witness. Trigger a CAU cycle.

IaC: Bicep templates in `labs/iac/05-compute/`.

## Related Resources

- [Arc VMs on Azure Local](https://learn.microsoft.com/azure-local/manage/create-arc-virtual-machines)
- [Cluster-Aware Updating](https://learn.microsoft.com/windows-server/failover-clustering/cluster-aware-updating)
- Slides: `slides/05-compute/` (planned)
