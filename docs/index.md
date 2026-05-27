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

## Curriculum — 20 Modules

The curriculum is organized into 20 modules across five learning tracks. Each module can be delivered independently or combined into a multi-day workshop. The day-by-day delivery schedule is built from these modules (see Delivery Programs).

### Foundations

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [00](00-introduction/index.md) | Introduction to Azure Local | L100 | 2h | Pres + demo |
| [01](01-planning-sizing/index.md) | Planning & Sizing | L200 | 2h | Design exercise |
| [02](02-deployment/index.md) | Deployment | L200 | 4h | **Lab** |
| [03](03-management/index.md) | Management | L200 | 3h | **Lab** |
| [04](04-azure-arc/index.md) | Azure Arc — Infrastructure Deep Dive | L300 | 3h | Demo |

### Infrastructure

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [05](05-compute/index.md) | Compute (Hyper-V + Failover Clustering + Arc VMs) | L200-300 | 5h | **Lab** |
| [06](06-storage/index.md) | Storage | L300 | 4h | **Lab** |
| [07](07-core-networking/index.md) | Core Networking | L300 | 4h | **Lab** |
| [08](08-software-defined-networking/index.md) | Software Defined Networking (Arc-managed) | L300 | 4h | **Lab** |

### Operations

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [09](09-security-compliance/index.md) | Security & Compliance | L300 | 5h | **Lab** |
| [10](10-observability-monitoring/index.md) | Observability & Monitoring | L200-300 | 3h | **Lab** |
| [11](11-troubleshooting/index.md) | Troubleshooting | L300 | 4h | **Lab/Demo** |
| [12](12-bcdr/index.md) | Business Continuity & DR (BCDR) | L300 | 4h | **Lab** |
| [13](13-day-2-operations/index.md) | Day-2 Operations & Lifecycle | L300 | 4h | **Lab** |

### Workloads

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [14](14-aks/index.md) | AKS on Azure Local | L300 | 4h | **Lab** |
| [15](15-avd/index.md) | Azure Virtual Desktop on Azure Local | L300 | 4h | **Lab** |
| [16](16-iot-operations/index.md) | IoT Operations on Azure Local | L300 | 3h | **Lab** |
| [17](17-ai-foundry-local/index.md) | Azure AI Foundry Local | L300 | 3h | **Lab** |

### Adoption

| # | Module | Level | Duration | Hands-on |
|---|--------|-------|----------|----------|
| [18](18-migration/index.md) | Migration (VMware / Hyper-V → Azure Local) | L300 | 3h | **Lab/Demo** |
| [19](19-scvmm/index.md) | SCVMM on Azure Local (Optional / Placeholder) | L300 | 2h | Presentation |

**Total curriculum content: ~70 hours** of presentation + lab time, delivered as multi-day workshops, online live sessions, or on-demand with the AI tutor.

---

## Delivery Programs

Delivery programs are curated subsets of the 20 modules for specific audiences and time windows. Programs are defined in the [strategic plan](https://github.com/AzureLocal/azurelocal-training/blob/main/repo-management/training-platform-plan.md) and will be published here as they're finalized.

The four delivery formats are:

| Format | Description |
|--------|-------------|
| **In-Person Workshop** | Multi-day on-site delivery with dedicated lab environment per participant |
| **Online Live** | Scheduled virtual delivery via Teams/Zoom, same content, same labs |
| **On-Demand Self-Paced** | Module library with AI-narrated video and hands-on labs |
| **AI-Led On-Demand** | Interactive AI tutor (Claude-powered) that teaches modules and guides through labs |

---

## Hands-On Labs

Every lab supports **two environment options**:

- **Azure Arc Jumpstart HCIBox** — pre-built nested-virtualization environment in Azure
- **Customer cluster** — labs run against a customer's own Azure Local cluster

See [Lab Environment Setup](labs/index.md) for full lab list and setup instructions.

---

## Contributing

This training curriculum is an open-source project. Contributions are welcome — see [`CONTRIBUTING.md`](https://github.com/AzureLocal/azurelocal-training/blob/main/CONTRIBUTING.md) in the repository root for details.

---

## Resources

- [Azure Local documentation](https://learn.microsoft.com/azure-local/)
- [Azure Arc documentation](https://learn.microsoft.com/azure/azure-arc/)
- [Training platform plan (strategic)](https://github.com/AzureLocal/azurelocal-training/blob/main/repo-management/training-platform-plan.md)
