# Azure Local Operator Training

!!! warning "Under Construction"
    This training curriculum is actively being developed. Module content, labs, and slide decks are in progress. A delivery guide with scheduling options is coming soon.

## Overview

This curriculum provides comprehensive, hands-on training for infrastructure operators managing Azure Local clusters through the Azure Arc management plane. The training covers everything from initial cluster deployment through day-to-day operations, security hardening, hybrid Azure services, and advanced workloads like AKS and Azure Virtual Desktop.

Azure Local is the successor to Azure Stack HCI. The entire curriculum is built around the modern, cloud-first management model — **Azure Portal and Azure Arc are the primary interfaces**. Legacy tools like Windows Admin Center (WAC) and System Center Virtual Machine Manager (SCVMM) are not covered.

---

## Who Is This Training For?

| Audience | Description |
|----------|-------------|
| **Infrastructure Operators** | Day-to-day cluster and VM management, storage, networking, monitoring |
| **System Administrators** | Windows Server / Hyper-V admins transitioning to Azure Local |
| **Cloud Administrators** | Azure admins extending cloud management to on-premises infrastructure |
| **DevOps / Platform Engineers** | Teams deploying AKS clusters and containerized workloads on Azure Local |
| **VDI Administrators** | Teams deploying Azure Virtual Desktop on Azure Local |

---

## Prerequisites

Before starting this training, participants should have:

- **Azure fundamentals** — Familiarity with the Azure Portal, resource groups, subscriptions, and RBAC
- **Windows Server basics** — Experience with Windows Server administration (Active Directory, DNS, DHCP)
- **Networking fundamentals** — Understanding of VLANs, subnets, IP addressing, and basic switching
- **Virtualization concepts** — Basic understanding of Hyper-V or any hypervisor technology
- **PowerShell basics** — Ability to run and understand PowerShell commands (not expert-level scripting)

---

## Training Modules

The curriculum is organized into 11 modules spanning the full Azure Local operator lifecycle. Each module is self-contained and can be delivered independently or as part of a delivery track.

| Module | Title | Level | Duration | Description |
|--------|-------|-------|----------|-------------|
| **00** | Introduction to Azure Local | L100 | 2 hours | What is Azure Local, positioning vs. Windows Server, architecture overview, common use cases |
| **01** | Management | L200 | 3 hours | Azure Portal navigation, PowerShell/CLI operations, Azure Arc as the management fabric |
| **02** | Compute | L200-300 | 4 hours | Arc VM deployment and lifecycle, VM images and gallery, live migration, high availability |
| **03** | Storage | L200-300 | 4 hours | Storage Spaces Direct, disk types (HDD/SSD/NVMe/PM), cache tiers, fault tolerance, resync, monitoring |
| **04** | Networking | L200-300 | 4 hours | Network ATC, virtual switch, RDMA/SR-IOV, logical networks for Arc VMs, Arc-managed SDN |
| **05** | Hybrid Services | L200-300 | 4 hours | Azure Site Recovery, Azure Backup, Azure Monitor, Azure Update Manager, Defender for Cloud |
| **06** | Security | L200-300 | 3 hours | Secured-core server, BitLocker encryption, security baselines (SMI), drift protection, WDAC, network security |
| **07** | Azure Kubernetes Service | L200-300 | 3 hours | AKS on Azure Local architecture, deploying AKS clusters, managing containerized workloads |
| **08** | Azure Virtual Desktop | L200-300 | 3 hours | AVD on Azure Local architecture, deploying session hosts and host pools, FSLogix, scaling |
| **09** | Operations | L200-300 | 4 hours | Monitoring and alerting, troubleshooting (VMs, clustering, S2D, networking), backup/restore, disaster recovery |
| **10** | Cloud Deployment | L200 | 3 hours | Azure Portal cloud deployment, prerequisites, hardware/network requirements, Arc registration flow |

**Total curriculum duration: ~37 hours** (4 full days + wrap-up, or delivered as modular tracks)

---

## Delivery Tracks

The curriculum supports multiple delivery tracks depending on audience needs and available time. Each track includes a subset of modules with mapped labs.

### Track A: Essentials (2 days)

For operators who need a focused ramp-up on core management and operations.

| Day | Modules | Topics |
|-----|---------|--------|
| Day 1 | 00, 01, 02 | Introduction, Management (Portal + Arc), Compute (Arc VMs) |
| Day 2 | 05, 09 | Hybrid Services (ASR, Backup, Monitor, Updates), Operations (Monitoring, Troubleshooting) |

**Labs included:** Lab 01

### Track B: Full Curriculum (4 days)

Comprehensive training covering all 11 modules for new Azure Local operators.

| Day | Modules | Topics |
|-----|---------|--------|
| Day 1 | 00, 01, 02 | Introduction, Management, Compute |
| Day 2 | 03, 04 | Storage, Networking |
| Day 3 | 05, 06, 07 | Hybrid Services, Security, Azure Kubernetes |
| Day 4 | 08, 09, 10 | Azure Virtual Desktop, Operations, Cloud Deployment |

**Labs included:** Labs 01-10

### Track C: Infrastructure Deep-Dive (3 days)

For infrastructure specialists focused on storage, networking, and security.

| Day | Modules | Topics |
|-----|---------|--------|
| Day 1 | 00, 01, 02 | Introduction, Management, Compute |
| Day 2 | 03, 04 | Storage (S2D deep-dive), Networking (ATC, RDMA, SDN) |
| Day 3 | 06, 09 | Security (Secured-core, SMI, WDAC), Operations |

**Labs included:** Labs 01-04, 08

### Track D: Cloud-Native (2 days)

For cloud and DevOps engineers focused on Kubernetes and cloud deployment.

| Day | Modules | Topics |
|-----|---------|--------|
| Day 1 | 00, 01, 10 | Introduction, Management, Cloud Deployment |
| Day 2 | 07 | AKS on Azure Local (cluster deployment, workload management) |

**Labs included:** Lab 09

### Track E: VDI / AVD (2 days)

For VDI administrators deploying Azure Virtual Desktop on Azure Local.

| Day | Modules | Topics |
|-----|---------|--------|
| Day 1 | 00, 01, 02 | Introduction, Management, Compute (Arc VMs for session hosts) |
| Day 2 | 08, 09 | Azure Virtual Desktop (host pools, FSLogix, scaling), Operations |

**Labs included:** Labs 01, 02, 10

---

## Hands-On Labs

All labs support **two environment options**: an Azure Local sandbox/jumpstart environment, or the customer's own lab infrastructure. Each lab is self-contained with objectives, prerequisites, step-by-step instructions, validation steps, and cleanup procedures.

| Lab | Title | Maps to Module |
|-----|-------|----------------|
| **01** | Deploy an Arc VM | Module 02: Compute |
| **02** | Manage Arc VMs | Module 02: Compute |
| **03** | Storage Operations | Module 03: Storage |
| **04** | Networking Configuration | Module 04: Networking |
| **05** | Azure Site Recovery | Module 05: Hybrid Services |
| **06** | Backup and Restore | Module 05: Hybrid Services |
| **07** | Azure Update Manager | Module 05: Hybrid Services |
| **08** | Monitoring and Alerting | Module 09: Operations |
| **09** | Deploy an AKS Cluster | Module 07: Azure Kubernetes |
| **10** | AVD Deployment | Module 08: Azure Virtual Desktop |

---

## Module Details

### Module 00: Introduction to Azure Local

**Level:** L100 | **Duration:** 2 hours | **Prerequisites:** None

An accessible introduction to Azure Local — what it is, how it evolved from Azure Stack HCI, and where it fits in the hybrid cloud landscape.

- What is Azure Local and how it differs from Windows Server
- Azure Local architecture: Azure Arc, Azure Portal, on-premises infrastructure
- Key value propositions: cloud-connected, always up-to-date, Azure-managed
- Licensing and subscription model
- Common use cases: branch office, VDI, AKS, SQL Server, edge workloads

---

### Module 01: Management

**Level:** L200 | **Duration:** 3 hours | **Prerequisites:** Module 00

Covers the primary management interfaces for Azure Local. Azure Portal and Azure Arc are the management plane — this module teaches operators how to navigate, configure, and manage their clusters through cloud-first tooling.

- **Azure Portal** — Cluster overview, node management, resource provisioning, RBAC
- **PowerShell & CLI** — Updated cmdlets for Azure Local, Azure CLI for Arc-enabled resources
- **Azure Arc Integration** — Arc agent architecture, Arc extensions, connected vs. disconnected scenarios

---

### Module 02: Compute

**Level:** L200-300 | **Duration:** 4 hours | **Prerequisites:** Module 01

Covers virtual machine operations through the Azure Arc lens. Hyper-V remains the underlying engine, but all VM operations are performed through Azure Arc and the Azure Portal.

- **Arc VM Deployment** — Portal-based VM creation, sizing, disk and network configuration, Marketplace images
- **Arc VM Management** — Lifecycle operations (start, stop, restart, delete), resizing, disk management, VM extensions
- **VM Images & Gallery** — Azure Marketplace images on Azure Local, custom images, image management
- **Live Migration** — Fundamentals, configuration, troubleshooting
- **High Availability** — Failover Clustering for VMs, VM priority, placement rules, Cluster-Aware Updating

---

### Module 03: Storage

**Level:** L200-300 | **Duration:** 4 hours | **Prerequisites:** Module 00

Deep-dive into Storage Spaces Direct (S2D) — the software-defined storage layer in Azure Local. Covers architecture, disk tiers, resiliency, and monitoring.

- **Storage Spaces Direct** — Architecture, pool and volume management, performance tiers
- **Disk Types & Cache** — HDD, SSD, NVMe, Persistent Memory tiers; cache drive configuration
- **Fault Tolerance** — Mirror, parity, and mixed resiliency; 2-way vs. 3-way mirror; capacity planning
- **Storage ReSync** — Resync process, monitoring, performance impact, troubleshooting
- **Monitoring Storage** — Azure Monitor for storage health, performance counters, alerting

---

### Module 04: Networking

**Level:** L200-300 | **Duration:** 4 hours | **Prerequisites:** Module 00

Covers both traditional host networking and the new Arc-based networking model for Azure Local.

- **Network ATC** — Intent-based networking, Network ATC v2, configuration and management
- **Virtual Switch** — Hyper-V virtual switch architecture, SET (Switch Embedded Teaming)
- **RDMA & Offloads** — iWARP, RoCE, SMB Direct, SMB Multichannel, SR-IOV
- **Logical Networks** — Arc VM logical networks, IP address management for Arc VMs
- **Arc-Managed SDN** — Software-Defined Networking overview for Azure Local, when to use SDN, basic configuration via Portal

---

### Module 05: Hybrid Services

**Level:** L200-300 | **Duration:** 4 hours | **Prerequisites:** Module 01

Covers the Azure hybrid services that extend cloud capabilities to Azure Local clusters. All services are configured and managed through Azure Arc.

- **Azure Site Recovery** — Arc-based protection, failover/failback procedures, DR testing
- **Azure Backup** — Arc-based backup configuration, MARS agent, restore operations
- **Azure Monitor** — Azure Monitor Agent, Monitor Insights for Azure Local, Log Analytics, alerting and dashboards
- **Azure Update Manager** — Update assessment, compliance, scheduling, solution updates (replaces WSUS)
- **Defender for Cloud** — Security posture management, threat detection, compliance recommendations

---

### Module 06: Security

**Level:** L200-300 | **Duration:** 3 hours | **Prerequisites:** Module 00

Comprehensive security hardening for Azure Local clusters. Covers hardware-backed security, encryption, security baselines, and application control.

- **Secured-Core Server** — Hardware requirements, HVCI, VBS, TPM; enabling and verifying
- **BitLocker & Encryption** — OS and data volume encryption, encryption at rest for S2D, key management
- **SMI & Drift Protection** — Security baseline management, drift detection and remediation, WDAC policies
- **Network Security** — Datacenter firewall rules, network isolation, micro-segmentation

---

### Module 07: Azure Kubernetes Service

**Level:** L200-300 | **Duration:** 3 hours | **Prerequisites:** Module 01

Covers AKS on Azure Local — deploying Kubernetes clusters and managing containerized workloads. AKS is now integrated into the Azure Local cluster deployment experience.

- **AKS on Azure Local** — Architecture, AKS Arc overview, prerequisites
- **Deploying AKS Clusters** — Portal-based deployment, cluster configuration, node pool management, networking
- **Managing Workloads** — Deploying containers, kubectl basics for operators, monitoring, scaling and updates

---

### Module 08: Azure Virtual Desktop

**Level:** L200-300 | **Duration:** 3 hours | **Prerequisites:** Module 02

Covers running Azure Virtual Desktop on Azure Local for scenarios requiring data locality, compliance, or low-latency VDI.

- **AVD on Azure Local** — Architecture, benefits (data locality, compliance, latency), prerequisites, Arc integration
- **Deploying AVD** — Host pools on Azure Local, session host deployment, image management, network configuration
- **Managing AVD** — User session management, scaling plans and autoscale, FSLogix profile containers, monitoring

---

### Module 09: Operations

**Level:** L200-300 | **Duration:** 4 hours | **Prerequisites:** Modules 01-05

Day-to-day operational procedures for running Azure Local in production. Covers monitoring, troubleshooting, backup operations, and disaster recovery.

- **Monitoring & Alerts** — Operational dashboards, alert configuration, health checks, performance baselining
- **Troubleshooting** — VM issues (Arc-specific), clustering, S2D, networking; updated diagnostic tools
- **Backup & Restore** — Operational backup procedures, VM-level and volume-level restore, backup validation
- **Disaster Recovery** — DR planning, failover procedures, failback procedures, DR testing

---

### Module 10: Cloud Deployment

**Level:** L200 | **Duration:** 3 hours | **Prerequisites:** Module 01

Covers the end-to-end cloud deployment model for Azure Local — deploying new clusters entirely through the Azure Portal.

- **Deployment Overview** — Cloud deployment architecture (Azure Portal → Arc → on-prem), deployment vs. registration
- **Prerequisites** — Hardware requirements, network requirements (firewall rules, endpoints), Azure subscription and identity prerequisites, pre-deployment validation checklist
- **Registration & Arc** — Registering nodes with Azure Arc, cluster creation via Portal, post-deployment validation

---

## Presentations

Slide decks are being created for each module, aligned 1:1 with the training content. A presentations tracking page will be published here as decks become available.

---

## Contributing

This training curriculum is an open-source project. Contributions are welcome — see the CONTRIBUTING.md file in the repository root for details on how to submit improvements, report issues, or propose new content.

---

## Resources

- [Azure Local documentation](https://learn.microsoft.com/azure-local/)
- [Azure Arc documentation](https://learn.microsoft.com/azure/azure-arc/)
- Delivery Guide — Detailed track agendas, prerequisites, and instructor guidelines (coming soon)
- Lab Environment Setup — Sandbox and customer lab configuration (coming soon)

