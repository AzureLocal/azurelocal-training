# Module 07: Deployment

**Level:** L200–L300 | **Duration:** 6 hours | **Prerequisites:** Modules 00–06 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

This module covers the end-to-end Azure Local cluster deployment workflow. The cluster lands at the end of this module ready for the post-deployment cluster configuration in Module 08.

Source of truth: [azurelocal.cloud — Implementation Guide, Part 4: Cluster Deployment](https://azurelocal.cloud/docs/next/implementation/04-cluster-deployment/).

## Learning Objectives

- Choose between Storage Spaces Direct (S2D, hyperconverged) and SAN (disaggregated) storage architectures
- Choose between Active Directory–joined and local-identity cluster identity models
- Choose between Azure Portal and ARM Template deployment methods
- Execute the cluster deployment end-to-end through the chosen path
- Validate that cluster deployment succeeded before handing off to Module 08

## Topics — mirrors implementation Phase 04 stages 11–15

1. **Hardware Provisioning** — BIOS, iDRAC, DHCP reservations, hardware discovery
2. **OS Installation** — Azure Stack HCI OS via USB / PXE, image verification
3. **OS Configuration** — WinRM, RDP, static IPs, DNS, time sync, hostname, network adapter cleanup
4. **Arc Registration** — connect each node to Azure Arc
5. **Cluster Deployment** — actual cluster creation via the chosen method

## Architectural choices

### Storage architecture

| Option | Description | When to choose |
|--------|-------------|----------------|
| **Storage Spaces Direct (S2D)** | Hyperconverged — storage is local to each compute node. Max 16 nodes. Rack-aware. | General purpose, smaller clusters, no existing SAN |
| **SAN (Disaggregated)** | External Fiber Channel SAN. Max 64 nodes. Independent scaling of compute and storage. NOT rack-aware. | Larger clusters, existing SAN infrastructure (FC / FCoE), need to scale compute and storage independently |

### Identity architecture

| Option | When to choose |
|--------|----------------|
| **Active Directory–joined** | Enterprise deployments with existing AD, centralized identity, group policy |
| **Local Identity** | Edge / disconnected scenarios, no AD dependency, simpler topology |

### Deployment method

| Option | When to choose |
|--------|----------------|
| **Azure Portal (wizard)** | First-time / learning deployments, ad-hoc, lower learning curve |
| **ARM Template** | Production, repeatable, multi-site, CI/CD integrated. **Recommended** for production Azure Local Cloud deployments. |

Together these produce 8 deployment combinations (S2D vs SAN × AD vs Local × Portal vs ARM). The implementation guide documents each combination separately under [`deployment-methods/`](https://azurelocal.cloud/docs/next/implementation/04-cluster-deployment/deployment-methods/).

### SAN-specific pre-cluster tasks

For SAN deployments only, between Arc Registration and Cluster Deployment:

- Install FC HBA drivers
- Verify HBA ports (`Get-InitiatorPort`)
- Enable MPIO (`Add-WindowsFeature Multipath-IO`)
- Verify SAN disks are visible in RAW state
- Configure FC zoning (WWPN) **after** Arc registration

## Hands-on

**Lab:** Deploy a cluster end-to-end via the Azure Portal path on the chosen identity model (typically AD for the standard lab). Validate cluster deployment succeeded.

IaC: Bicep templates in `labs/iac/07-deployment/` (planned).

## What this module does NOT cover

- Post-deployment cluster configuration (storage paths, VM images, logical networks, NSGs, SDN deploy, quorum, SSH, security groups) — **Module 08**
- Day-to-day management — **Module 09**

## Related Resources

- [azurelocal.cloud — Implementation Guide, Part 4: Cluster Deployment](https://azurelocal.cloud/docs/next/implementation/04-cluster-deployment/)
- [Deployment Methods overview](https://azurelocal.cloud/docs/next/implementation/04-cluster-deployment/deployment-methods/)
- [SAN (Disaggregated) Deployment](https://azurelocal.cloud/docs/next/implementation/04-cluster-deployment/phase-05-cluster-deployment/deployment-methods/san/)
- Slides: `slides/07-deployment/` (planned)
