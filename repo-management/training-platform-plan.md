# Azure Local Training Platform — Strategic Plan

**Status:** Draft for review — working document, updated continuously
**Owner:** Kris Turner (kristopherjturner@outlook.com)
**Created:** 2026-05-27
**Last updated:** 2026-05-27
**Repo:** https://github.com/AzureLocal/azurelocal-training
**Site (current):** https://azurelocal.github.io/azurelocal-training/
**Site (planned):** https://training.azurelocal.cloud/

This is the living plan for everything `azurelocal-training` needs to become. It covers platform decisions, content strategy, lab infrastructure, AI tutor, tooling, automation, repo structure, branding, and open questions. Work items in this doc should be converted to ADO items as we agree on them.

---

## 1. What we are building

`azurelocal-training` is the home for **Azure Local operator training** delivered in three modes:

| Mode | Format | Key artifacts |
|---|---|---|
| **In-person / on-site** | Instructor-led workshop, 2–4 days | Slide decks, lab guides, IaC lab templates, delivery guides |
| **Online live** | Virtual instructor-led, scheduled sessions | Same as in-person, delivered remotely via Teams/Zoom |
| **On-demand self-paced** | AI-narrated video lessons + slide decks + **interactive AI tutor** (Claude-powered) that teaches and guides through labs | YouTube-hosted videos, PowerPoint, lab guides, Next.js + Claude API web app |

The documentation site at `training.azurelocal.cloud` is the **marketing and reference layer** — course overviews, lab guides participants reference during workshops, and public information. The on-demand experience pairs AI-narrated video with an interactive AI tutor — both are delivered as part of the same self-paced format.

---

## 2. Platform architecture — what goes where

Given the AI tutor requirement, the platform is two distinct systems:

### 2.1 Static reference site (MkDocs Material)

Keep MkDocs Material for:
- Lab guides (Markdown, browseable during workshops)
- Course catalog and delivery program information
- Public marketing landing page (what you'll learn, who should attend, agenda)
- Presenter resources and delivery guides

Deployed to GitHub Pages at `training.azurelocal.cloud`. No change from current tooling.

**Why keep MkDocs:** Platform standard, already deployed, zero migration cost, and the lab guide use case is exactly what it was designed for. The original question about moving to React is answered by the AI tutor being a *separate app*, not a replacement for the docs site.

### 2.2 AI tutor application (React / Next.js)

The interactive AI tutor requires a proper web application:
- React or Next.js frontend (leans Next.js — server-side rendering, API routes, easy Vercel/Azure deployment)
- Claude API backend (Anthropic SDK) — see Section 4
- Hosted separately, likely at `app.training.azurelocal.cloud` or integrated at `training.azurelocal.cloud` with MkDocs serving `/docs/`

**Decision needed:** Same domain with routing (Cloudflare Worker to split `/` → Next.js, `/docs/` → GitHub Pages) vs. separate subdomain (`app.training.azurelocal.cloud`). The separate subdomain is simpler to implement first.

### 2.3 Platform summary

```
training.azurelocal.cloud/          ← MkDocs Material (GitHub Pages)
  /docs/                            ← Lab guides, module reference
  /courses/                         ← Course catalog, delivery programs

app.training.azurelocal.cloud/      ← Next.js AI tutor (Vercel or Azure SWA)
  /learn/<module>/                  ← AI tutor session for each module
  /labs/<lab>/                      ← Guided lab walkthrough
```

---

## 3. Content strategy

### 3.0 Source module analysis

Reference table showing all topics/modules across the three source workshops. Used to inform the final agreed module list (Section 3.1). Not a 1:1 mapping — this is raw source material.

| **Legacy (original workshop)** | **Current Stubs (repo docs/)** | **Splitbrain (3-day)** |
|---|---|---|
| **Introduction to Azure Stack HCI** | **00-introduction** | **Day 1 — Foundations & Architecture** |
| Overview of Deployment Methods | What Is Azure Local | What Azure Local is, where it fits in Microsoft hybrid strategy |
| Overview of Use Cases | Azure Local vs Windows Server vs Azure Stack HCI | Connected vs. disconnected architectures, multi-rack deployments |
| | Architecture Overview | Azure Local vs. Azure public cloud: key differences |
| | Key Value Propositions | Software-Defined Networking, Network ATC, virtual switches |
| | Common Use Cases | Storage Spaces Direct (S2D) and storage architecture |
| | Licensing and Subscription Model | Hardware certification: Validated, Integrated, Premier |
| | Planning Next Steps | Licensing, subscription models, sovereignty / edge / regulated use cases |
| | | Lab: environment walkthrough and deployment prep |
| **Azure Stack HCI Management** | **01-management** | **Day 2 — Deployment & Configuration** |
| Overview of Management Tools | Azure Portal — Cluster Overview, Node Mgmt, RBAC | Planning, prerequisites, and sizing |
| Deployment Methods | PowerShell & Azure CLI | Networking and storage design decisions |
| Managing with Windows Admin Center | Azure Arc Integration — agents, extensions, connected/disconnected | Lab: install and configure Azure Local nodes |
| Managing with Virtual Machine Manager | Arc Resource Bridge | Lab: run cluster validation |
| | Monitoring Cluster Health from Portal | Lab: deploy your cluster end-to-end |
| | | Lab: management through WAC, Failover Cluster Manager, Azure Portal |
| | | Workload management vs. infrastructure management |
| | | Lab: monitoring and update configuration |
| **Azure Stack HCI Core Networking** | **04-networking** | **Day 3 — Workloads, Operations & Lifecycle** |
| Simplifying the Network | Network ATC — intent types, v2 | Lab: deploy VMs via Azure Portal |
| Network Deployment options for HCI | Virtual Switch — Hyper-V vSwitch, SET | Lab: deploy VMs with Bicep (IaC) |
| Understanding the Virtual Switch | RDMA & Offloads — iWARP, RoCE, SMB Direct, SR-IOV | Lab: deploy AKS on Azure Local |
| Network Acceleration Technologies | Logical Networks for Arc VMs | Lab: deploy Azure Virtual Desktop |
| Virtual Network Adapters | Arc-Managed SDN overview | Lab: Arc, Azure Policy, Azure Monitor integration |
| **Azure Stack HCI Storage** | **03-storage** | High availability, backup, and disaster recovery |
| Overview of Storage Spaces Direct | S2D Architecture — pool, virtual disks, volumes | Migration paths from VMware and Hyper-V |
| S2D Components | Disk Types & Cache — HDD, SSD, NVMe, PM | Security: Secure Boot, BitLocker, Credential Guard |
| Deployment Methods of S2D | Fault Tolerance — mirror, parity, nested resiliency | Lab: Day-2 operations, capacity expansion, upgrades, roadmap |
| S2D Operations and Monitoring Tools | Storage ReSync | |
| | Volume Management | |
| | Monitoring Storage Health | |
| **Azure Stack HCI Compute** | **02-compute** | |
| Overview of Hyper-V | Arc VM Architecture — Hyper-V engine, Arc as interface | |
| Virtual Machine Components | Deploying Arc VMs — Portal, sizing, disk, network | |
| Failover Clustering | VM Lifecycle Management | |
| Virtual Machine High Availability | VM Images & Gallery | |
| | Live Migration | |
| | High Availability — Failover Clustering, placement, CAU | |
| **Azure Stack HCI Hybrid Features** | **05-hybrid-services** | |
| Overview of Azure Hybrid Features | Azure Site Recovery | |
| Registering and Connecting to Azure | Azure Backup | |
| Azure Site Recovery | Azure Monitor | |
| Azure Backup | Azure Update Manager | |
| Azure Monitoring | Defender for Cloud | |
| Azure Arc | | |
| Azure File Sync | | |
| **Azure Stack HCI Security** | **06-security** | |
| Core Principals for HCI Security | Secured-Core Server — HVCI, VBS, TPM | |
| Evolution of Attacks | BitLocker & Encryption | |
| HCI Security Postures | SMI & Drift Protection | |
| Zero Trust Architecture | WDAC | |
| | Network Security | |
| **Azure Stack Monitoring & Troubleshooting** | **09-operations** | |
| Overview of Monitoring Toolset | Monitoring & Alerts — dashboards, alert rules, health | |
| Troubleshooting Virtual Machines | Troubleshooting — VMs, clustering, S2D, networking | |
| Troubleshooting Failover Clustering | Backup & Restore | |
| Troubleshooting Storage Spaces Direct | Disaster Recovery | |
| Troubleshooting Software Defined Networking | Lifecycle Management | |
| **Azure Stack HCI SDN** | *(folded into 04-networking — single topic only)* | |
| Overview of SDN | | |
| Deployment options for SDN | | |
| Network Controllers | | |
| Software Load Balancers | | |
| Gateway Servers | | |
| Managing and Operating SDN | | |
| *(8 sub-module deep-dive deck)* | | |
| **AKS on Azure Stack HCI** | **07-azure-kubernetes** | |
| AKS on HCI Architecture | AKS on Azure Local Architecture | |
| Deploy AKS on Azure Stack HCI | Deploying AKS Clusters | |
| Hybrid Features of AKS on Azure Stack HCI | Managing Workloads | |
| **Azure Virtual Desktop** *(extended)* | **08-azure-virtual-desktop** | |
| *(No detail — deck not in referrence/)* | AVD on Azure Local Architecture | |
| | Deploying AVD — host pools, session hosts, images | |
| | Managing AVD — scaling, FSLogix, monitoring | |
| ***(no legacy equivalent)*** | **10-cloud-deployment** | |
| | Deployment Architecture | |
| | Prerequisites | |
| | Registration & Arc | |

---

### 3.1 Module structure — APPROVED 2026-05-27

The agreed module framework. 20 modules organized as a learning path (foundations → planning → deploy → run → workloads → migrate → optional). Days/delivery tracks are derived later from these modules — the modules themselves are the framework everything else (slides, labs, IaC, AI tutor, video) is built from.

**Workshop-first principle:** This is a workshop, not a speaking session. Every module declares its hands-on content (lab, demo, presentation-only). Most modules require labs.

21-module curriculum, five learning tracks, Foundations first. See [ADR-0005](adr/0005-curriculum-21-module-framework.md), [ADR-0006](adr/0006-track-ordering-foundations-first.md), [ADR-0007](adr/0007-post-deployment-configurations-module.md).

**Foundations** — what Azure Local is + the underlying tech

| # | Module | Hands-on | IaC | Slides | Video | AI tutor |
|---|--------|----------|-----|--------|-------|----------|
| **00** | Introduction to Azure Local | Pres + optional demo | — | ✓ | ✓ | ✓ |
| **01** | Azure Arc — Infrastructure Deep Dive | **Demo** (Resource Bridge, agents) | — | ✓ | ✓ | ✓ |
| **02** | Compute (Hyper-V + Failover Clustering + Arc VMs) | **Lab** | Bicep | ✓ | ✓ | ✓ |
| **03** | Storage | **Lab** (S2D, ReFS, ReSync) | Bicep | ✓ | ✓ | ✓ |
| **04** | Core Networking | **Lab** (Network ATC, RDMA) | Bicep | ✓ | ✓ | ✓ |
| **05** | Software Defined Networking (Arc-managed) | **Lab** (Arc-managed SDN, controller, SLB) | Bicep | ✓ | ✓ | ✓ |

**Deployment** — plan, deploy, configure for workload use

| # | Module | Hands-on | IaC | Slides | Video | AI tutor |
|---|--------|----------|-----|--------|-------|----------|
| **06** | Planning & Sizing | Pres + design exercise | — | ✓ | ✓ | ✓ |
| **07** | Deployment (S2D / SAN / hybrid · AD / local identity · Portal / ARM / cloud-managed) | **Lab** (deploy cluster) | Bicep | ✓ | ✓ | ✓ |
| **08** | Post-Deployment Configurations (RBAC, storage paths, VM images, logical networks) | **Lab** | Bicep | ✓ | ✓ | ✓ |

**Operations** — run it

| # | Module | Hands-on | IaC | Slides | Video | AI tutor |
|---|--------|----------|-----|--------|-------|----------|
| **09** | Management | **Lab** (Portal/CLI/WAC + Dell OMSWAC) | — | ✓ | ✓ | ✓ |
| **10** | Security & Compliance | **Lab** (BitLocker, Policy, Defender, SMI/drift) | Bicep + Policy | ✓ | ✓ | ✓ |
| **11** | Observability & Monitoring | **Lab** (Monitor, Insights, dashboards) | Bicep | ✓ | ✓ | ✓ |
| **12** | Troubleshooting | **Lab/Demo** (guided break-fix) | — | ✓ | ✓ | ✓ |
| **13** | Business Continuity & DR (BCDR) | **Lab** (ASR, Backup, DR test) | Bicep | ✓ | ✓ | ✓ |
| **14** | Day-2 Operations & Lifecycle | **Lab** (Update Manager, LCM, capacity) | — | ✓ | ✓ | ✓ |

**Workloads**

| # | Module | Hands-on | IaC | Slides | Video | AI tutor |
|---|--------|----------|-----|--------|-------|----------|
| **15** | AKS on Azure Local | **Lab** (deploy cluster, workload) | Bicep + Terraform | ✓ | ✓ | ✓ |
| **16** | Azure Virtual Desktop on Azure Local | **Lab** (host pool, session host, FSLogix) | Bicep | ✓ | ✓ | ✓ |
| **17** | IoT Operations on Azure Local | **Lab** (Arc-enabled IoT Operations, OPC UA → MQTT → Event Hubs) | Bicep | ✓ | ✓ | ✓ |
| **18** | Azure AI Foundry Local | **Lab** (Phi-4-mini sovereign chat on AKS Arc) | Bicep | ✓ | ✓ | ✓ |

**Adoption**

| # | Module | Hands-on | IaC | Slides | Video | AI tutor |
|---|--------|----------|-----|--------|-------|----------|
| **19** | Migration (VMware / Hyper-V → Azure Local) | **Lab/Demo** | — | ✓ | ✓ | ✓ |
| **20** | SCVMM (Optional / Placeholder) | Pres only | — | — | — | ✓ |

**Notes:**
- Module 01 (Arc Deep Dive) — Arc fabric, Resource Bridge, agents, under-the-hood. Sits in Foundations because Arc is the substrate Azure Local is built on.
- Module 07 (Deployment) — covers architectural choices (S2D vs SAN vs hybrid; AD vs local identity; Portal vs ARM vs cloud-managed deployment), not just one path.
- Module 08 (Post-Deployment Configurations) — NEW dedicated module for the operator's post-deploy work (storage paths, VM images, tenant logical networks, RBAC for VM management) per the [Microsoft Learn VM management workflow](https://learn.microsoft.com/azure/azure-local/manage/azure-arc-vm-management-overview). See [ADR-0007](adr/0007-post-deployment-configurations-module.md).
- Module 13 (BCDR) — Azure Site Recovery, Azure Backup, DR planning/testing.
- Module 14 (Day-2/Lifecycle) — Azure Update Manager, LCM, capacity expansion.
- Module 10 (Security & Compliance) — Azure Policy, Defender for Cloud, plus all the security topics. Major expansion from legacy 2-hour treatment.
- Modules 17 (IoT Operations) and 18 (AI Foundry Local) — research findings in `repo-management/research/`.
- Module 20 (SCVMM) — placeholder; not built out until customer demand confirmed.

**What was dropped from the legacy:**
- Azure File Sync (not core to Azure Local operations)
- SCVMM as primary management (placeholder only)
- WAC as primary management (folded into Module 03 as situational + Dell OMSWAC use case)
- SDN Express / traditional SDN (Module 08 covers Arc-managed SDN for Azure Local instead)

**Workshop / lab/demo framework:**

Each module's `docs/<module>/` content must declare:
- **Lab format:** hands-on lab, instructor demo, or presentation-only
- **Lab artifact location:** `docs/labs/lab-<NN>-<slug>.md` and `labs/iac/<module>/` for IaC
- **Demo artifact location:** `docs/<module>/demo-<slug>.md` with step-by-step instructor demo script
- **Lab environment requirements:** HCIBox, customer cluster, or instructor-provided sandbox
- **Estimated duration:** for both presentation and lab portions
- **Prerequisite modules:** what must be completed first

A module is not "done" until all four artifact types are in place: slide deck, lab guide (or demo script), IaC template (where applicable), and AI tutor script.

### 3.2 Delivery programs

**Primary delivery programs (named tracks):**

| Program | Modules | Duration | Lab count |
|---|---|---|---|
| **Foundations** | 00 + 01 + 02 + 03 + 04 | 2 days | 8–10 |
| **Foundations + Workloads** | Foundations + 07 + 08 | 3 days | 12–14 |
| **Full stack** | All modules | 4 days | 18–20 |
| **Operations focus** | 01 + 09 + 05 + 06 | 2 days | 8 |
| **Migration track** | 00 + 02 + 03 + 04 + migration paths | 3 days | 10 |

**Alternate audience-focused tracks (carried over from the earlier buildout plan; keep for marketing variation and customer-specific bookings):**

| Track | Modules | Duration | Audience |
|---|---|---|---|
| **Track A — Essentials** | 00, 01, 02, 05, 09 | 2 days | General operators new to Azure Local |
| **Track B — Full** | 00–10 (all) | 4 days | Architects and senior operators |
| **Track C — Infrastructure deep-dive** | 00, 01, 02, 03, 04, 06, 09 | 3 days | Infrastructure-focused operators (storage, networking, security) |
| **Track D — Cloud-native** | 00, 01, 07, 10 | 2 days | Cloud-first operators, AKS/Arc focus |
| **Track E — VDI/AVD** | 00, 01, 02, 08, 09 | 2 days | AVD-focused administrators |

The named programs (Foundations, etc.) are the public marketing offerings. The lettered tracks (A–E) are alternate groupings to use for customer-specific or audience-segmented engagements when the named programs don't fit.

### 3.3 Per-module artifact set

Each module needs all of these before it is considered complete:

```
docs/<module>/
├── index.md                  ← module overview, learning objectives, nav
├── lab-<N>-<slug>.md         ← one file per lab
└── presenter-notes.md        ← instructor delivery guide

labs/iac/<module>/
├── main.bicep                ← IaC template (if module has IaC lab)
├── parameters.json
└── README.md

slides/<module>/
├── <module>-slides.pptx      ← editable (Git LFS)
├── <module>-slides.pdf       ← PDF export (committed normally)
└── narration-script.md       ← AI narration script per slide

videos/<module>/
└── links.md                  ← YouTube links + chapter markers (no video files in repo)
```

### 3.4 Content migration matrix — KEEP / EDIT / ADD / DROP

This is the per-topic plan for migrating from the legacy Azure Stack HCI workshop content (in `/referrence/`) to the new Azure Local curriculum. Source: original buildout plan, 2026-05-27.

#### KEEP (carry forward — update Azure Stack HCI → Azure Local terminology and procedures)

| Old topic | New location | Changes needed |
|---|---|---|
| Storage Spaces Direct fundamentals | `docs/03-storage/` | Terminology update, add NVMe/PM tiers, remove outdated performance numbers |
| Disk types, cache, fault tolerance | `docs/03-storage/` | Minor updates |
| Storage ReSync | `docs/03-storage/` | Minor updates |
| Core networking (vSwitch, Network ATC, RDMA, SR-IOV) | `docs/04-networking/` | Terminology update; Network ATC v2 changes |
| Hyper-V / VM HA / Live Migration | `docs/02-compute/` | Reframe under Arc VMs; keep clustering fundamentals |
| Azure Site Recovery | `docs/05-hybrid-services/` | Update for Arc-based protection, new portal flows |
| Azure Backup | `docs/05-hybrid-services/` | Update for Arc-based backup, MARS agent changes |
| Azure Monitor integration | `docs/05-hybrid-services/` | Update for Azure Monitor Agent, Insights |
| Security (Secured-core, BitLocker) | `docs/06-security/` | Expand significantly |
| Troubleshooting (VMs, Clustering, S2D) | `docs/09-operations/` | Update tools; add Arc-specific troubleshooting |

#### ADD (new content — did not exist in old workshops)

| Topic | New location | Reason |
|---|---|---|
| Azure Portal as primary management plane | `docs/01-management/azure-portal.md` | Azure Local is cloud-first managed |
| Azure Arc integration and management fabric | `docs/01-management/azure-arc-integration.md` | Core to Azure Local identity |
| Arc VM deployment (portal-based) | `docs/02-compute/arc-vm-deployment.md` | Primary VM creation method now |
| Arc VM lifecycle management | `docs/02-compute/arc-vm-management.md` | Portal-based VM operations |
| VM images and Azure Marketplace gallery | `docs/02-compute/vm-images-and-gallery.md` | New capability |
| Logical networks for Arc VMs | `docs/04-networking/logical-networks.md` | New networking model |
| Arc-managed SDN for Azure Local | `docs/04-networking/arc-managed-sdn.md` | SDN reframed as Arc-managed |
| Azure Update Manager | `docs/05-hybrid-services/azure-update-manager.md` | Replaces WSUS/old Update Management |
| Microsoft Defender for Cloud | `docs/05-hybrid-services/defender-for-cloud.md` | Replaces old Security Center |
| Security Management Interface (SMI) and drift protection | `docs/06-security/smi-and-drift-protection.md` | New security baseline feature |
| AKS cluster deployment and workload management | `docs/07-azure-kubernetes/` | AKS is part of cluster deployment now |
| Azure Virtual Desktop on Azure Local | `docs/08-azure-virtual-desktop/` | NEW module — AVD architecture, host pools, FSLogix, scaling |
| Cloud deployment via Azure Portal | `docs/10-cloud-deployment/` | Entirely new deployment model |
| Hands-on labs (10+) | `docs/<module>/labs/` and `labs/iac/` | Structured labs aligned to modules; both sandbox and customer lab |
| Consolidated delivery guide | `docs/delivery-guide.md` | Single guide with modular delivery options |
| AI tutor application | `app/` | See Section 4 |
| IaC templates (Bicep/Terraform) | `labs/iac/` | See Section 6 |

#### DROP (obsolete — do not carry forward)

| Old topic | Reason |
|---|---|
| System Center Virtual Machine Manager (SCVMM) | Deprecated for Azure Local management |
| Windows Admin Center (WAC) | Dropped — Azure Portal + Arc is the management plane |
| Azure File Sync | Not core to Azure Local operator training |
| SDN deep-dive (8-module track) | Replaced by Arc-managed SDN overview in networking module |
| Chalk and Talk (90-min intro) | Replace with "What is Azure Local" section |
| Legacy deployment methods (WAC-based cluster creation) | Cloud deployment is now primary |
| Cloud Witness as standalone topic | Fold into HA/clustering section |
| Old SharePoint content links | Dead links to Microsoft internal SharePoint |

#### EDIT (significant rewrites needed)

| Topic | What changes |
|---|---|
| Full delivery guide | Rewrite as modern delivery guide with Azure Local branding, updated durations, updated prerequisites, modular delivery tracks |
| Compute module | Reframe from "Hyper-V administration" to "Azure Arc VM operations" — Hyper-V is the engine but Arc is the interface |
| Hybrid Features module | Split into "Hybrid Services" (ASR, Backup, Monitor, Update Manager) and move security items into the Security module |
| AKS module | Complete rewrite — focus on deploying AKS clusters and managing workloads |
| Networking module | Add Arc-managed SDN as a topic alongside core networking |
| Security module | Expand from thin 2-hour overview to comprehensive module covering Secured-core, BitLocker, Defender for Cloud, SMI, WDAC |

#### Confirmed prior decisions (from the earlier buildout review)

These were already agreed in a previous session and remain in effect:

- **Lab environments:** BOTH sandbox and customer lab supported (see Section 6.1)
- **Content depth:** L200–L300 core, L100 for Module 00 (Introduction) only
- **SDN scope:** Arc-managed SDN for Azure Local (NOT the old 8-module deep-dive)
- **Azure Local:** Drop SCVMM entirely
- **WAC:** Drop entirely
- **PowerPoint archive:** Stays in `/referrence/` (read-only archive). New decks created fresh in `slides/`. Docs link to new decks.
- **AVD:** Added as new Module 08
- **AKS:** Part of cluster deployment now — focus on deploying clusters and managing workloads

### 3.5 Detailed module folder structure

This is the per-file plan for `docs/`. Each module's specific pages are listed here so content authors can pick up an empty file and know what it covers.

```
docs/
├── index.md                                  ← landing page (marketing-focused — see Section 10.3)
├── delivery-guide.md                         ← consolidated delivery guide (all tracks)
├── 00-introduction/
│   ├── index.md
│   ├── what-is-azure-local.md
│   ├── azure-local-vs-windows-server.md
│   └── use-cases.md
├── 01-management/
│   ├── index.md
│   ├── azure-portal.md                       ← NEW (primary management plane)
│   ├── powershell-and-cli.md                 ← KEEP (updated cmdlets)
│   └── azure-arc-integration.md              ← NEW (Arc as management fabric)
├── 02-compute/
│   ├── index.md
│   ├── arc-vm-deployment.md                  ← NEW
│   ├── arc-vm-management.md                  ← NEW
│   ├── vm-images-and-gallery.md              ← NEW
│   ├── live-migration.md                     ← KEEP
│   └── high-availability.md                  ← KEEP
├── 03-storage/
│   ├── index.md
│   ├── storage-spaces-direct.md
│   ├── disk-types-and-cache.md
│   ├── fault-tolerance.md
│   ├── storage-resync.md
│   └── monitoring-storage.md
├── 04-networking/
│   ├── index.md
│   ├── network-atc.md
│   ├── virtual-switch.md
│   ├── rdma-and-offloads.md
│   ├── logical-networks.md                   ← NEW
│   └── arc-managed-sdn.md                    ← NEW
├── 05-hybrid-services/
│   ├── index.md
│   ├── azure-site-recovery.md
│   ├── azure-backup.md
│   ├── azure-monitor.md
│   ├── azure-update-manager.md               ← NEW
│   └── defender-for-cloud.md                 ← NEW
├── 06-security/
│   ├── index.md
│   ├── secured-core-server.md
│   ├── bitlocker-and-encryption.md
│   ├── smi-and-drift-protection.md           ← NEW
│   └── network-security.md
├── 07-azure-kubernetes/
│   ├── index.md
│   ├── aks-on-azure-local.md                 ← REWRITE
│   ├── deploying-aks-clusters.md             ← NEW
│   └── managing-workloads.md                 ← NEW
├── 08-azure-virtual-desktop/                 ← NEW MODULE
│   ├── index.md
│   ├── avd-on-azure-local.md
│   ├── deploying-avd.md
│   └── managing-avd.md
├── 09-operations/
│   ├── index.md
│   ├── monitoring-and-alerts.md
│   ├── troubleshooting.md
│   ├── backup-and-restore.md
│   └── disaster-recovery.md
├── 10-cloud-deployment/                      ← NEW MODULE
│   ├── index.md
│   ├── deployment-overview.md
│   ├── prerequisites.md
│   └── registration-and-arc.md
├── presentations/
│   └── index.md                              ← table of all module decks + status + links
└── labs/
    ├── index.md                              ← lab environment setup (sandbox + customer lab)
    ├── lab-01-deploy-arc-vm.md
    ├── lab-02-manage-arc-vm.md
    ├── lab-03-storage-operations.md
    ├── lab-04-networking.md
    ├── lab-05-site-recovery.md
    ├── lab-06-backup-restore.md
    ├── lab-07-update-manager.md
    ├── lab-08-monitoring.md
    ├── lab-09-deploy-aks-cluster.md
    └── lab-10-avd-deployment.md
```

Each module's `index.md` must include: learning objectives, topics covered, estimated duration, prerequisite modules, key terminology.

The `presentations/index.md` is a tracking table for slide deck creation effort — columns: Module, Deck Name, Status (To Create / In Progress / Complete), Link.

### 3.6 Legacy reference material (`/referrence/`)

The `/referrence/` folder contains the legacy Azure Stack HCI workshop content. It is the **source of record** for the old material but should not be edited. Modern equivalents go into `docs/`, `slides/`, and `labs/iac/`.

Migration status (to track per module):

| Legacy asset | Location | Migration target | Status |
|---|---|---|---|
| Module decks 00–09 | `referrence/PowerPoint/` | `slides/<module>/` | Not started |
| Delivery guides | `referrence/Delivery Guide/` | `docs/<module>/presenter-notes.md` | Not started |
| Datasheets (PDF + PPTX) | `referrence/Datasheet/` | `docs/assets/datasheets/` (rebranded) | Not started |
| Lab exercises | `referrence/Labs/` | `docs/<module>/lab-*.md` | Not started |
| Demo files | `referrence/DemoFiles/` | `labs/iac/<module>/` (convert to IaC) | Not started |
| CIP Manifest | `referrence/CIP Manifest/` | Review for relevance; archive or migrate | Not started |

---

## 4. AI tutor — the on-demand learning experience

### 4.1 Vision

An AI instructor, powered by Claude, that teaches Azure Local operations interactively. It does not just answer questions — it teaches a structured module, adapts to the learner's pace, verifies understanding, and guides through hands-on lab steps.

**Modes:**

| Mode | What it does |
|---|---|
| **Module teaching** | Works through a module topic by topic, explains concepts, shows examples, asks comprehension checks |
| **Lab guide** | Walks through a specific lab step by step, adapts to where the learner is stuck |
| **Q&A** | Answers questions about any Azure Local topic, drawing on the full course content |
| **Assessment** | Tests understanding of a module with scenario-based questions |

### 4.2 Architecture

```
User browser
    ↓
Next.js frontend (app.training.azurelocal.cloud)
    ↓
API route (Next.js server component or API route)
    ↓
Anthropic Claude API (claude-sonnet-4-6 or claude-opus-4-7)
    ↓
System prompt: module content + lab instructions + Azure Local knowledge
```

**Context loading strategy:**
- Each module has a structured system prompt built from the course content files
- Lab guides are loaded as tool results or directly into context
- The AI tutor has access to the relevant module's slides (as text), lab guide (Markdown), and IaC templates (as reference)
- For complex technical questions, optionally use the Claude API's tool use to query Microsoft Learn docs in real-time

**Implementation approach:**
- Use the Anthropic TypeScript SDK (`@anthropic-ai/sdk`)
- Stream responses for real-time feel (no waiting for full response)
- Conversation history maintained client-side (sessionStorage) for the duration of the session
- Optional: persistent sessions via Supabase or Azure Cosmos DB for learners with accounts
- Prompt caching to reduce costs when repeatedly loading module content

### 4.3 What the AI tutor is NOT

- Not a replacement for the human instructor in in-person workshops
- Not a video player
- Not a simple FAQ chatbot — it actively teaches and guides
- Not connected to the learner's actual Azure environment (no Azure API calls)

### 4.4 Anthropics GitHub research (Research task 1)

Before building the AI tutor, complete Research task 1 (Section 9) to understand:
- What SDKs and tools Anthropic provides at github.com/anthropics
- Whether there are existing educational/tutoring prompt patterns
- Prompt caching documentation and best practices
- Any example multi-turn conversation patterns for technical teaching

### 4.5 Technology decisions needed

| Decision | Options | Recommendation |
|---|---|---|
| Frontend framework | Next.js, Astro + React islands, plain React | **Next.js** — API routes simplify the Anthropic SDK integration; Vercel deployment |
| Hosting | Vercel, Azure Static Web Apps, GitHub Pages | **Vercel** (Next.js) or **Azure SWA** — not GitHub Pages (needs server-side API) |
| Persistence | None (stateless), Supabase, Azure Cosmos DB | Start stateless; add Supabase if accounts are needed |
| Claude model | claude-sonnet-4-6, claude-opus-4-7 | **claude-sonnet-4-6** for interactive teaching; opus only for deep technical diagnosis |
| Auth | None (public), GitHub OAuth, Microsoft Entra | Start with no auth for public access; add for gated/paid content |

---

## 5. Video strategy

### 5.1 Video role in the platform

Videos complement the AI tutor — they are short, structured concept explanations and demo walkthroughs that learners can watch before or after an AI tutor session. They are **not** the primary on-demand experience.

| Video type | Length | Purpose |
|---|---|---|
| Concept intro | 3–7 min | Explain a topic before a lab (what S2D is, why Network ATC matters) |
| Lab walkthrough demo | 8–15 min | Show the expected result of a lab before the learner attempts it |
| Troubleshooting guide | 3–5 min | Show how to diagnose and fix a common failure |

### 5.2 Hosting

**YouTube (unlisted initially, public when ready)** — no cost, embeds anywhere in MkDocs or the Next.js app, captions/chapters, analytics. Link files in the repo under `videos/<module>/links.md`.

Video files are **never committed to the repo**.

### 5.3 Production approach

| Tool | Use for | Notes |
|---|---|---|
| Copilot in PowerPoint | Concept intros from slide decks | Already in M365; test this first — lowest cost |
| Synthesia / HeyGen | Polished avatar-presenter videos | Evaluate if Copilot quality is insufficient |
| Descript | Lab walkthrough demos (screen recording + polish) | Good for screen-capture-heavy content |

Start with Copilot in PowerPoint for Module 00 as a proof of concept before committing to a paid video tool.

### 5.4 Claude Code role in video production

The `slide-content-author` and `video-script-writer` agents (Section 6) can:
- Generate narration scripts from slide content
- Write timestamped speaker notes formatted for Copilot or Synthesia
- Produce chapter marker lists for YouTube
- Write video descriptions and metadata

---

## 6. Lab infrastructure

### 6.1 Lab delivery models

| Model | Description | When to use |
|---|---|---|
| **Nested virtualization (Azure VM)** | Each participant gets an Azure VM with Hyper-V + nested Azure Local VMs | In-person or online where physical hardware is not available |
| **Physical hardware** | Real Azure Local hardware at the training venue | On-site events with hardware sponsors or customer hardware |
| **HCIBox (Arc Jumpstart)** | Pre-built nested-virt environment from the Arc Jumpstart team | Self-paced learners; limited customization |
| **Customer environment** | Delivered in the customer's own Azure Local cluster | Enterprise on-site deliveries |

The default for all paid workshops is nested virtualization — each participant works in their own dedicated Azure VM. This matches the Splitbrain model (Section 10).

### 6.2 IaC lab templates

Every lab that provisions Azure resources has a corresponding template in `labs/iac/`. Requirements:

- Fully parameterized — no hardcoded subscription IDs, resource group names, or regions
- Follow the HCS infrastructure standard (`docs/standards/infrastructure.md` in platform repo)
- Include a `README.md` with prerequisites, deployment, and cleanup
- Idempotent — safe to re-run with the same inputs
- Pass `az bicep build` / `terraform validate` without warnings
- Cleanup script included alongside every template

### 6.3 Shared base lab environment

A single reusable Bicep template (`labs/iac/shared/lab-environment.bicep`) provisions the nested virtualization base for any workshop:

```
labs/
└── iac/
    ├── shared/
    │   ├── lab-environment.bicep     ← base nested-virt environment
    │   ├── lab-environment.params.json
    │   ├── cleanup.ps1               ← destroys all lab resources
    │   └── README.md
    ├── 02-compute/
    │   ├── deploy-vm.bicep
    │   ├── deploy-vm.parameters.json
    │   └── README.md
    ├── 07-aks/
    │   ├── main.bicep
    │   ├── modules/
    │   └── README.md
    └── 08-avd/
        ├── main.bicep
        └── README.md
```

Parameters for the base environment:
- Azure region
- VM SKU (Standard_E16s_v5 for full cluster, smaller for single-node labs)
- Participant count (batch provisioning for multi-participant workshops)
- Module selector (deploys module-specific resources on top of the base)
- TTL hours (triggers cleanup automation after the workshop ends)

---

## 7. Claude Code configuration — full picture

### 7.1 What is implemented (2026-05-27)

| File | Purpose |
|---|---|
| `CLAUDE.md` | 8-section context: purpose, ADO, standards, key facts, structure, actions, commands, agents |
| `.claude/settings.json` | CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1, hooks, permissions |
| `.claude/agents/training-content-author.md` | Sonnet — lab and module content writing |
| `.claude/commands/new-lab.md` | /new-lab slash command |
| `.claude/commands/new-workshop.md` | /new-workshop slash command |
| `.claude/commands/review-lab.md` | /review-lab slash command |
| `.claude/skills/workstream-new-lab/SKILL.md` | Pipeline: domain-expert research → author → human gate |
| `.claude/skills/workstream-new-workshop/SKILL.md` | Pipeline: plan → scaffold → human gate |
| `.claude/skills/workstream-review-lab/SKILL.md` | Pipeline: technical review + format review → report |
| `.claude/hooks/block-secrets.ps1` | PreToolUse — blocks credential writes |
| `.claude/hooks/validate-path.ps1` | PreToolUse — blocks writes to site/, .git/ |
| `.claude/hooks/log-tokens.ps1` | PostToolUse — token logging (already firing) |
| `.claude/hooks/summarize-session.ps1` | Stop — session logging (already firing) |

### 7.2 Hooks gap — still needed

These hooks exist in the platform templates but were not added in the initial scaffold:

| Hook | Event | Purpose | Priority |
|---|---|---|---|
| `block-destructive.ps1` | PreToolUse Bash | Block `--force` push and dangerous Azure CLI write ops | High |
| `load-memory.ps1` | SessionStart | Auto-load MEMORY.md and recent project memory into session | High |
| `format-on-write.ps1` | PostToolUse Write\|Edit | Run markdownlint or prettier on written files (starts as no-op stub) | Medium |
| `log-operate.ps1` | PostToolUse Agent | Log agent spawns and results to operate.jsonl | Medium |
| `check-context.ps1` | UserPromptSubmit | Reference copy only — NOT wired at repo level (already wired user-level) | Doc only |

### 7.3 Agents to add

| Agent | Model | Purpose | Priority |
|---|---|---|---|
| `training-pm` | sonnet | PM orchestration — spawns content authors, tracks module status, ADO sync, standup summaries | High |
| `lab-iac-engineer` | sonnet | Bicep/Terraform lab template design, review, idempotency, az bicep build verification | High |
| `ai-tutor-engineer` | sonnet | Next.js + Anthropic SDK development for the AI tutor app | High |
| `slide-content-author` | sonnet | PowerPoint structure, speaker notes, narration scripts | Medium |
| `video-script-writer` | sonnet | AI narration scripts, YouTube chapter markers, video descriptions | Medium |
| `content-reviewer` | sonnet | Technical accuracy review across all content types | Medium |

### 7.4 Training PM agent (design)

Modeled on `cloudsmith-pm` from `E:/git/cloudsmith-cloud/cloudsmith-internal/.claude/agents/`. The PM agent orchestrates multi-module work and tracks status:

- Knows the full module roster and per-module artifact status (slides, labs, IaC, video, AI tutor)
- Spawns content authors and IaC engineers in parallel for multi-module waves
- Syncs with ADO work items (uses `az boards` commands)
- Produces standup summaries from git log + ADO delta
- Manages `/standup`, `/module-status`, `/content-plan`, `/new-slide-deck` commands

**Slash commands to add for PM:**

| Command | Skill | Purpose |
|---|---|---|
| `/standup` | workstream-standup | Daily summary: what changed, in progress, blocked |
| `/module-status <N>` | — | Status of a specific module's artifacts |
| `/content-plan <program>` | workstream-content-plan | Work breakdown for a delivery program |
| `/new-slide-deck <module>` | workstream-new-slides | Scaffold PowerPoint outline from module content |

### 7.5 Content cleanup automation

The HCS platform standards include a content cleanup automation pattern. This needs to be located and implemented here.

Suspected to cover:
- Scheduled check for orphaned pages (in `docs/` but not in `mkdocs.yml` nav)
- Check for TODO placeholders left in committed content
- Check for broken internal links
- Check for lab IaC templates without corresponding lab guides (or vice versa)

**Action:** Find the pattern in `E:/git/platform/docs/standards/` or cloudsmith-internal. Implement as a GitHub Actions workflow (`content-lint.yml`) and/or a Claude Code hook.

---

## 8. Automation and CI/CD

### 8.1 Current workflows

| Workflow | Trigger | Purpose |
|---|---|---|
| `mkdocs-deploy` (reusable) | Push to main | Publishes docs site to GitHub Pages |
| `drift-check` (reusable) | Push, schedule | Checks platform config drift vs `.azurelocal-platform.yml` |
| `release-please` (reusable) | Push to main | Manages CHANGELOG and version tags |
| `validate-structure` (reusable) | Push | Validates repo structure against platform descriptor |
| `add-to-project` (reusable) | Issues/PRs | Syncs to ADO project board |

### 8.2 Workflows to add

| Workflow | Trigger | Purpose |
|---|---|---|
| `validate-labs.yml` | PR | Run `az bicep build` on all IaC templates; fail PR on errors |
| `content-lint.yml` | PR | markdownlint on all docs/; check for broken links, TODO placeholders, orphaned nav entries |
| `iac-cleanup.yml` | Manual + scheduled | Destroy lab Azure resources after TTL (uses ADO-managed SPN) |
| `slide-export.yml` | Push to main (slides/) | Auto-export PowerPoint to PDF and commit alongside |
| `ai-tutor-deploy.yml` | Push to main (app/) | Deploy Next.js AI tutor app to Vercel or Azure SWA |

---

## 9. Repo structure

### 9.1 Decision: GitHub monorepo, no ADO move

**Stay on GitHub, keep the monorepo.**

| Question | Decision | Reason |
|---|---|---|
| GitHub vs. Azure DevOps for content | **GitHub** | Open source, community contributions, GitHub Pages, GitHub Actions. ADO = work tracking only. |
| Monorepo vs. multi-repo | **Monorepo** | A slide + lab + IaC change for one module is one PR. Multi-repo means 3 PRs for one logical change. Industry standard for training content (Microsoft Learn, HashiCorp Learn). |
| Future splits | IaC templates *may* split later | Only when `labs/iac/` becomes a standalone reusable library that other repos consume. Not now. |

### 9.2 Binary files — Git LFS

PowerPoint files must use Git LFS. Without it, cloning the repo after 20 decks would download gigabytes.

```bash
# One-time setup (already needs to happen)
git lfs install
git lfs track "*.pptx" "*.pptm" "*.potx" "*.ppt"
git add .gitattributes && git commit -m "chore: configure Git LFS for PowerPoint files"
```

Also commit a `.pdf` export alongside each deck — renders on GitHub without LFS.

### 9.3 Videos — never in the repo

Videos are hosted externally. The repo stores the script, chapter markers, and URL only.

| Phase | Hosting |
|---|---|
| Now | YouTube (unlisted until ready to publish) |
| Later | Azure Blob Storage + CDN, or Vimeo Pro |

### 9.4 Open source + contribution protection

**CODEOWNERS** — require maintainer review before any community PR merges:

```
# .github/CODEOWNERS
*                        @AzureLocal/training-maintainers
labs/iac/**              @AzureLocal/training-maintainers
.claude/**               @AzureLocal/training-maintainers
```

**Branch protection on `main`:**
- Require 1 approving review (from CODEOWNERS)
- Require status checks to pass (content-lint, validate-labs)
- No direct pushes to main (except repo admins)

Community contributors submit PRs freely. Nothing merges without your team's sign-off.

### 9.5 Proposed final repo structure

```
azurelocal-training/
├── docs/                        ← MkDocs source (training.azurelocal.cloud)
│   ├── 00-introduction/
│   ├── ...
│   ├── 10-cloud-deployment/
│   ├── labs/                    ← standalone/cross-module labs
│   ├── presentations/           ← presentation references and overviews
│   └── assets/                  ← images, SVGs, icons
├── slides/                      ← PowerPoint decks (Git LFS) + PDF exports
│   ├── 00-introduction/
│   └── ...
├── labs/
│   └── iac/                     ← Bicep/Terraform lab templates
│       ├── shared/              ← base lab environment
│       └── <module>/
├── videos/                      ← scripts, chapter markers, YouTube links (no video files)
│   └── <module>/
│       ├── narration-script.md
│       └── links.md
├── app/                         ← Next.js AI tutor application
│   ├── src/
│   │   ├── app/                 ← Next.js App Router
│   │   ├── components/
│   │   └── lib/                 ← Anthropic SDK integration
│   ├── package.json
│   └── README.md
├── referrence/                  ← Legacy materials (read-only archive)
├── repo-management/             ← Planning docs, scripts, setup guides
├── .github/
│   ├── CODEOWNERS
│   └── workflows/
├── .azurelocal-platform.yml
├── .claude/                     ← Claude Code agents, hooks, skills, commands
├── mkdocs.yml
└── CLAUDE.md
```

---

## 10. Domain and branding

### 10.1 Domain: training.azurelocal.cloud

**Decision:** Move from `azurelocal.github.io/azurelocal-training/` to `training.azurelocal.cloud`.

**Why subdomain, not subpath (`azurelocal.cloud/training`):**
- Trivial Cloudflare + GitHub Pages setup (one CNAME record)
- Clean, memorable URL for slide decks, event listings, LinkedIn posts
- Can change hosting independently without affecting azurelocal.cloud
- Subpath routing requires Cloudflare Workers to proxy between two different origins

**Setup steps (all required, in order):**

1. **Cloudflare DNS** — add CNAME: `training` → `azurelocal.github.io` (DNS only, not proxied)
2. **GitHub Pages** — Settings → Pages → Custom domain → `training.azurelocal.cloud` → Save
3. **CNAME file** — create `CNAME` at repo root containing `training.azurelocal.cloud`
4. **MkDocs** — update `site_url: https://training.azurelocal.cloud/` in `mkdocs.yml`
5. Re-enable Cloudflare proxy after TLS cert is issued (optional but recommended for DDoS protection)

**AI tutor app domain:** `app.training.azurelocal.cloud` (separate CNAME → Vercel or Azure SWA)

### 10.2 Brand identity

The training program lives under the `azurelocal.cloud` umbrella brand:

- **Product name:** Azure Local Operator Training
- **Short name:** AzL Training
- **Domain:** training.azurelocal.cloud
- **Logo/icon:** `docs/assets/images/azurelocal-training-icon.svg` (already in repo)
- **Banner:** `docs/assets/images/azurelocal-training-banner.svg` (already in repo)
- **Color:** Azure blue (`#0078D4`) — already set in `mkdocs.yml`

### 10.3 Marketing landing page

The `docs/index.md` (the site home page) needs to become a proper course marketing page, not a documentation index. Required sections based on competitive analysis (Section 11):

- **Hero:** product name, one-sentence value prop, CTA button (Register / Learn more)
- **Who should attend** — 4 bullet audience types
- **What you'll learn** — 5 key outcomes including Bicep IaC templates
- **Delivery formats** — on-demand AI tutor, in-person workshop, online live
- **Agenda overview** — the 3–4 day program structure with day themes
- **Prerequisites** — Windows Server/Hyper-V basics, networking fundamentals, basic Azure
- **Testimonials / social proof** — GitHub stars, trained participants count (add as it grows)
- **Registration / contact CTA**

### 10.4 Datasheet modernization

The `/referrence/Datasheet/` folder contains three datasheets branded as "Azure Stack HCI" (old name). These need to be rebranded and updated:

| Current file | New target | Changes |
|---|---|---|
| `ASHCI Essentials Full Deployment.pdf` | `docs/assets/datasheets/azl-essentials-full.pdf` | Rebrand to Azure Local, update screenshots |
| `ASHCI Essentials Full with AKS.pdf` | `docs/assets/datasheets/azl-essentials-aks.pdf` | Rebrand, update AKS on Azure Local content |
| `ASHCI Essentials Full with SDN.pdf` | `docs/assets/datasheets/azl-essentials-sdn.pdf` | Rebrand, update SDN content |

Also create datasheets matching the new delivery programs (Foundations, Full Stack, Operations Focus, Migration Track).

---

## 11. Competitive examples

### 11.1 Splitbrain — Azure Local Hands-On Workshop (Amsterdam, June 2026)

**Source:** tickettailor.com (seen via LinkedIn, 2026-05-27)
**Venue:** Splitbrain Office, Johan Huizingalaan 400, 1066 JS Amsterdam, Netherlands
**Dates:** 22–24 June 2026, 9:00–17:00 daily (3 days)
**Format:** On-site, limited seats, each participant gets a dedicated virtualized Azure Local lab, ~50/50 theory + labs, English

#### Who should attend

- Infrastructure and cloud engineers
- System administrators running or evaluating hybrid environments
- Solution architects designing sovereign, edge, or regulated deployments
- IT professionals planning a migration from VMware or traditional Hyper-V

#### What you'll learn

- A working understanding of Azure Local architecture, networking, and storage
- Hands-on experience deploying a cluster end-to-end
- The ability to provision and manage VMs, AKS, and AVD on Azure Local
- **Reusable Bicep (Infrastructure as Code) templates**
- The confidence to scope, plan, and lead an Azure Local project at your organisation

#### Agenda

**Day 1 — Foundations and Architecture** *(Understand the platform before you build on it)*

- What Azure Local is, and where it fits in Microsoft's hybrid strategy
- Connected vs. disconnected architectures and multi-rack deployments
- Azure Local vs. Azure public cloud: the key differences
- Software-Defined Networking, Network ATC, and virtual switches
- Storage Spaces Direct (S2D) and storage architecture
- Hardware certification: Validated, Integrated, Premier
- Licensing, subscription models, and use cases for sovereignty, edge, and regulated industries
- **Lab:** environment walkthrough and deployment preparation

**Day 2 — Deployment and Configuration** *(Build a working cluster from scratch)*

- Planning, prerequisites, and sizing
- Networking and storage design decisions
- **Lab:** install and configure Azure Local nodes
- **Lab:** run cluster validation
- **Lab:** deploy your cluster end-to-end
- **Lab:** Management through Windows Admin Center, Failover Cluster Manager, and the Azure Portal
- Workload management vs. infrastructure management
- **Lab:** Monitoring and update configuration

**Day 3 — Workloads, Operations and Lifecycle** *(Run real workloads and operate the platform)*

- **Lab:** deploy VMs via the Azure Portal
- **Lab:** deploy VMs with Bicep (Infrastructure as Code)
- **Lab:** deploy AKS on Azure Local
- **Lab:** deploy Azure Virtual Desktop
- **Lab:** Cloud integration with Azure Arc, Azure Policy, and Azure Monitor
- High availability, backup, and disaster recovery
- Migration paths from VMware and Hyper-V
- Security: Secure Boot, BitLocker, Credential Guard
- **Lab:** Day-2 operations, capacity expansion, upgrades, and roadmap

#### Prerequisites (Splitbrain)

- Some knowledge of Windows Server and Hyper-V
- Familiarity with networking fundamentals (VLANs, IP, DNS)
- Basic Azure experience is helpful but not required

#### Key observations for our program

| Observation | Implication |
|---|---|
| Bicep IaC templates are an explicit learning outcome | Our IaC lab strategy is validated — Bicep is first-class, not an afterthought |
| 50/50 theory + labs over 3 days | Target 3+ hands-on labs per full-day module |
| Each participant gets a dedicated virtualized lab | Our shared base lab environment (Section 6.3) is the right architecture |
| Migration from VMware and Hyper-V is day-3 content | Module 09/10 should cover migration paths explicitly |
| Day 1 covers licensing, sovereignty, edge use cases | Module 00 needs stronger business use case content |
| Splitbrain is Amsterdam-only, in-person | Differentiate with US delivery, online live, and on-demand AI tutor |

---

## 12. Research tasks (deferred — do not implement until research is complete)

### Research task 1 — Anthropic GitHub (github.com/anthropics)

Review the Anthropic GitHub org for tools relevant to the AI tutor and content generation pipeline.

Look for:
- TypeScript SDK (`@anthropic-ai/sdk`) documentation, examples, and patterns for multi-turn conversations
- Prompt caching documentation and cost optimization guidance for repeated context loading
- Any educational/tutoring prompt patterns or examples
- Computer use capabilities (could be useful for interactive lab demos)
- Model documentation for claude-sonnet-4-6 and claude-opus-4-7 capabilities
- Any existing Claude-powered learning tools to learn from

**Output:** A research brief in `repo-management/research/anthropic-github-findings.md`

### Research task 2 — AI video generation tools

Evaluate tools against: cost per minute, technical narration quality (Azure Local terminology), PowerPoint integration, update workflow, Microsoft licensing.

Tools: Copilot in PowerPoint, Synthesia, HeyGen, Descript, ElevenLabs + Remotion.

**Output:** Recommendation with cost/quality matrix in `repo-management/research/ai-video-tools.md`

### Research task 3 — Platform standards content cleanup automation

Locate the content cleanup automation pattern from the HCS platform standards. Determine exactly what it does and how to implement it here.

**Output:** Implementation in `.claude/hooks/` and/or `.github/workflows/content-lint.yml`

---

## 13. Phase plan

### Phase 0 — Foundation (current, 2026-05-27)

- [x] Claude Code configuration scaffolded (.claude/ directory complete)
- [x] Basic agents, hooks, commands, skills in place
- [x] Plan document written
- [ ] **Git LFS setup** for PowerPoint files
- [ ] **Domain: training.azurelocal.cloud** — Cloudflare CNAME + GitHub Pages custom domain
- [ ] **CODEOWNERS** file created
- [ ] Hooks gap: block-destructive.ps1, load-memory.ps1, format-on-write.ps1, log-operate.ps1
- [ ] Platform standards content cleanup automation (Research task 3 first)
- [ ] Section 12 (repo structure) implemented: `.gitattributes` for LFS, `CODEOWNERS`, branch protection

### Phase 1 — Core content + PM agent

- [ ] `training-pm` agent implemented with /standup, /module-status commands
- [ ] `lab-iac-engineer` agent implemented
- [ ] Modules 00, 01 slides updated from referrence/ source + narration scripts
- [ ] Modules 02, 03, 04 lab guides written and reviewed
- [ ] Bicep base lab environment template (`labs/iac/shared/lab-environment.bicep`)
- [ ] Bicep IaC for modules 02, 03, 04
- [ ] `validate-labs.yml` GitHub Actions workflow
- [ ] `content-lint.yml` GitHub Actions workflow

### Phase 2 — AI tutor proof of concept

- [ ] Research task 1 complete (Anthropic GitHub findings)
- [ ] Next.js app scaffolded in `app/` with Claude API integration
- [ ] AI tutor for Module 00 (Introduction) — proof of concept
- [ ] `ai-tutor-deploy.yml` GitHub Actions workflow
- [ ] `app.training.azurelocal.cloud` domain and Cloudflare routing
- [ ] Modules 05, 06, 07, 08 lab guides
- [ ] Bicep/Terraform for AKS and AVD labs

### Phase 3 — Video + full program

- [ ] AI video proof of concept (Module 00 or 01 via Copilot in PowerPoint)
- [ ] Research task 2 complete (video tool decision)
- [ ] All 11 modules: slides, labs, IaC, video, AI tutor content
- [ ] All delivery programs documented and tested
- [ ] Marketing landing page (`docs/index.md`) rewritten
- [ ] Datasheets modernized and published
- [ ] Online registration integration

---

## 14. Open questions

| # | Question | Who decides | Needed by |
|---|---|---|---|
| 1 | Subpath (`azurelocal.cloud/training`) or subdomain (`training.azurelocal.cloud`)? | Kris | **Decided: subdomain** |
| 2 | AI tutor on same domain (`training.azurelocal.cloud/learn`) or separate (`app.training.azurelocal.cloud`)? | Kris | Phase 2 start |
| 3 | AI video tool: Copilot in PowerPoint first, then evaluate others? | Kris | Phase 2 start |
| 4 | Lab hosting: self-managed Azure VMs or partner with a lab hosting provider (e.g., Learn On Demand, Skillable)? | Kris | Phase 1 end |
| 5 | Pricing and access: public free content, gated free with registration, or paid? | Kris | Phase 2 start |
| 6 | Auth for AI tutor: none (anonymous), GitHub OAuth, or Microsoft Entra? | Kris | Phase 2 start |
| 7 | ADO area path `AzureLocal\Training` — correct? | Kris | Next session |
| 8 | Content cleanup automation: what exactly is the platform standard? | Investigate | Phase 0 |
