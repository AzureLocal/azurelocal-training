# Azure Local Operator Training

![Azure Local Operator Training](assets/images/azurelocal-training-banner.svg)

!!! warning "Under Construction"
    This training curriculum is actively being developed. Module framework is in place. Lab guides, slide decks, IaC templates, and the AI tutor are in progress.

## Overview

A comprehensive, hands-on training curriculum for infrastructure operators managing Azure Local clusters through the Azure Arc management plane. The curriculum covers everything from initial cluster planning and cloud deployment through day-2 operations, security, hybrid integration, and advanced workloads (AKS, AVD, IoT Operations, AI Foundry Local).

Azure Local is the successor to Azure Stack HCI. This curriculum is built around the modern, cloud-first management model — **Azure Portal and Azure Arc are the primary interfaces.** Windows Admin Center (WAC) is covered in its situational role (operator fallback, Dell OMSWAC for AX hardware). SCVMM is a placeholder for enterprise coexistence scenarios.

This is a **workshop-first** curriculum. Most modules include hands-on labs, IaC templates, and demo scripts — not just slides.

---

## Who Is This Training For?

| Audience | Description |
|----------|-------------|
| **Infrastructure Operators** | Day-to-day cluster and VM management, storage, networking, monitoring |
| **System Administrators** | Windows Server / Hyper-V admins transitioning to Azure Local |
| **Cloud Administrators** | Azure admins extending cloud management to on-premises infrastructure |
| **DevOps / Platform Engineers** | Teams deploying AKS clusters and containerized workloads on Azure Local |
| **VDI Administrators** | Teams deploying Azure Virtual Desktop on Azure Local |
| **Edge / IoT Operators** | Teams deploying IoT Operations and AI Foundry Local workloads at the edge |

---

## Prerequisites

- **Azure fundamentals** — Azure Portal, resource groups, subscriptions, RBAC
- **Windows Server basics** — Active Directory, DNS, DHCP
- **Networking fundamentals** — VLANs, subnets, IP addressing, switching
- **Virtualization concepts** — Hyper-V or any hypervisor
- **PowerShell basics** — ability to run and understand PowerShell commands

---

## Curriculum — 21 Modules

The curriculum is organized into 21 modules across five learning tracks: **Foundations**, **Deployment**, **Operations**, **Workloads**, and **Adoption**. Foundations come first — learn what Azure Local is and the technology underneath, then deploy, then operate, then workloads. See [ADR-0005](https://github.com/AzureLocal/azurelocal-training/blob/main/repo-management/adr/0005-curriculum-21-module-framework.md) for the rationale.

### Foundations — what Azure Local is and the technology underneath

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [00](00-introduction/index.md) | Introduction to Azure Local | L100 | 2h | Pres + demo |
| [01](01-azure-arc/index.md) | Azure Arc — Infrastructure Deep Dive | L300 | 3h | Demo |
| [02](02-compute/index.md) | Compute (Hyper-V + Failover Clustering + Arc VMs) | L200-300 | 5h | **Lab** |
| [03](03-storage/index.md) | Storage | L300 | 4h | **Lab** |
| [04](04-core-networking/index.md) | Core Networking | L300 | 4h | **Lab** |
| [05](05-software-defined-networking/index.md) | Software Defined Networking (Arc-managed) | L300 | 4h | **Lab** |

### Deployment — plan, deploy, and configure for workload use

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [06](06-planning-sizing/index.md) | Planning & Sizing | L200 | 2h | Design exercise |
| [07](07-deployment/index.md) | Deployment (S2D / SAN / hybrid, AD / local identity, Portal / ARM / cloud-managed) | L200-300 | 5h | **Lab** |
| [08](08-post-deployment-configurations/index.md) | Post-Deployment Configurations (RBAC, storage paths, VM images, logical networks) | L300 | 4h | **Lab** |

### Operations — run it

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [09](09-management/index.md) | Management | L200 | 3h | **Lab** |
| [10](10-security-compliance/index.md) | Security & Compliance | L300 | 5h | **Lab** |
| [11](11-observability-monitoring/index.md) | Observability & Monitoring | L200-300 | 3h | **Lab** |
| [12](12-troubleshooting/index.md) | Troubleshooting | L300 | 4h | **Lab/Demo** |
| [13](13-bcdr/index.md) | Business Continuity & DR (BCDR) | L300 | 4h | **Lab** |
| [14](14-day-2-operations/index.md) | Day-2 Operations & Lifecycle | L300 | 4h | **Lab** |

### Workloads — add workloads

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [15](15-aks/index.md) | AKS on Azure Local | L300 | 4h | **Lab** |
| [16](16-avd/index.md) | Azure Virtual Desktop on Azure Local | L300 | 4h | **Lab** |
| [17](17-iot-operations/index.md) | IoT Operations on Azure Local | L300 | 3h | **Lab** |
| [18](18-ai-foundry-local/index.md) | Azure AI Foundry Local | L300 | 3h | **Lab** |

### Adoption — bring existing estates in

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [19](19-migration/index.md) | Migration (VMware / Hyper-V → Azure Local) | L300 | 3h | **Lab/Demo** |
| [20](20-scvmm/index.md) | SCVMM on Azure Local (Optional / Placeholder) | L300 | 2h | Presentation |

**Total curriculum content: ~75 hours** of presentation + lab time, delivered as multi-day workshops, online live sessions, or on-demand with the AI tutor.

---

## Delivery Programs

Delivery programs are curated subsets of the 21 modules for specific audiences and time windows. Programs are defined in the [strategic plan](https://github.com/AzureLocal/azurelocal-training/blob/main/repo-management/training-platform-plan.md) and will be published here as they're finalized.

The three delivery formats are:

| Format | Description |
|--------|-------------|
| **In-Person Workshop** | Multi-day on-site delivery with dedicated lab environment per participant |
| **Online Live** | Scheduled virtual delivery via Teams/Zoom, same content, same labs |
| **On-Demand Self-Paced** | Module library with AI-narrated video, hands-on labs, and the interactive AI tutor (Claude-powered) that teaches modules and guides through labs |

---

## Hands-On Labs

Every lab supports **three target environments**, all deployed from the lab building solutions we provide:

- **Azure (cloud-hosted)** — nested-virt Azure Local lab inside an Azure VM (Bicep)
- **Physical Hyper-V server** — student's or customer's existing physical host running the lab as nested VMs
- **Actual Azure Local hardware** — student's or customer's own Azure Local cluster

Any of the three can be deployed by the student (self-guided / on-demand) or by the lab moderator (in-person workshops). See [Lab Environment Setup](labs/index.md) for full lab list and setup instructions.

---

## Contributing

This training curriculum is an open-source project. Contributions are welcome — see [`CONTRIBUTING.md`](https://github.com/AzureLocal/azurelocal-training/blob/main/CONTRIBUTING.md) in the repository root for details.

---

## Resources

- [Azure Local documentation](https://learn.microsoft.com/azure-local/)
- [Azure Arc documentation](https://learn.microsoft.com/azure/azure-arc/)
- [Training platform plan (strategic)](https://github.com/AzureLocal/azurelocal-training/blob/main/repo-management/training-platform-plan.md)
