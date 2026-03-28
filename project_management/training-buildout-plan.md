# Plan: Azure Local Training Repo Buildout

## TL;DR

Rebuild the `azurelocal-training` repo from legacy Azure Stack HCI workshop materials into a modern Azure Local operator training curriculum. The old content covers Compute, Storage, Networking, SDN, Hybrid, Security, AKS, and Troubleshooting across a 3-day modular workshop. The new curriculum retains the modular structure but reframes everything through the Azure Arc management plane, adds new Azure Local-specific topics (cloud deployment, Arc VMs, Update Manager, AKS Arc, AVD on Azure Local, Arc-managed SDN), drops obsolete tooling (SCVMM, WAC), and shifts from "on-prem admin" to "cloud-connected operator" persona.

## Confirmed Decisions (from user review)

- Lab environment: BOTH sandbox and customer lab
- Content depth: L200-L300 core, L100 for intro only
- Slide decks: Must be updated/created — separate task, aligned 1:1 with training modules. Placeholder pages in docs linking to new decks.
- SDN: Cover Arc-managed SDN for Azure Local (NOT the old 8-module deep-dive)
- SCVMM: DROP entirely
- WAC (Windows Admin Center): DROP entirely
- PowerPoint archive: Stays in `referrence/` (archived). Docs get placeholder/links to new decks.
- Old materials: Move to `/archive`
- AVD: ADD as a new training module
- AKS: Part of cluster deployment now — focus on deploying AKS clusters and managing workloads

---

## Phase 1: Foundation & Structure

### Step 1 — Create the docs folder structure

Create the following folder/file layout under `docs/`:

```text
docs/
├── index.md                              (landing page — rewrite)
├── delivery-guide.md                     (consolidated delivery guide)
├── 00-introduction/
│   ├── index.md                          (Azure Local overview & positioning)
│   ├── what-is-azure-local.md            (replaces old ASHCI intro)
│   ├── azure-local-vs-windows-server.md
│   └── use-cases.md
├── 01-management/
│   ├── index.md
│   ├── azure-portal.md                   (NEW — primary management plane)
│   ├── powershell-and-cli.md             (KEEP — updated cmdlets)
│   └── azure-arc-integration.md          (NEW — Arc as the management fabric)
├── 02-compute/
│   ├── index.md
│   ├── arc-vm-deployment.md              (NEW — portal-based VM creation)
│   ├── arc-vm-management.md              (NEW — lifecycle, sizing, disk, network)
│   ├── vm-images-and-gallery.md          (NEW — Azure Marketplace images on Azure Local)
│   ├── live-migration.md                 (KEEP — updated)
│   └── high-availability.md              (KEEP — Failover Clustering, updated)
├── 03-storage/
│   ├── index.md
│   ├── storage-spaces-direct.md          (KEEP — fundamentals still apply)
│   ├── disk-types-and-cache.md           (KEEP — updated for NVMe/PM)
│   ├── fault-tolerance.md                (KEEP)
│   ├── storage-resync.md                 (KEEP)
│   └── monitoring-storage.md             (KEEP — updated tools)
├── 04-networking/
│   ├── index.md
│   ├── network-atc.md                    (KEEP — still core)
│   ├── virtual-switch.md                 (KEEP)
│   ├── rdma-and-offloads.md              (KEEP)
│   ├── logical-networks.md              (NEW — Arc VM logical networks)
│   └── arc-managed-sdn.md               (NEW — Arc-managed SDN for Azure Local)
├── 05-hybrid-services/
│   ├── index.md
│   ├── azure-site-recovery.md            (KEEP — updated for Arc)
│   ├── azure-backup.md                   (KEEP — updated for Arc)
│   ├── azure-monitor.md                  (KEEP — updated, Insights)
│   ├── azure-update-manager.md           (NEW — replaces old WSUS/Update Management)
│   └── defender-for-cloud.md             (NEW — replaces old Security Center)
├── 06-security/
│   ├── index.md
│   ├── secured-core-server.md            (KEEP — expanded)
│   ├── bitlocker-and-encryption.md       (KEEP)
│   ├── smi-and-drift-protection.md       (NEW — security baselines)
│   └── network-security.md              (KEEP)
├── 07-azure-kubernetes/
│   ├── index.md
│   ├── aks-on-azure-local.md             (REWRITE — AKS is part of cluster deployment now)
│   ├── deploying-aks-clusters.md         (NEW — focus area)
│   └── managing-workloads.md             (NEW — focus area)
├── 08-azure-virtual-desktop/
│   ├── index.md                          (NEW — entire module)
│   ├── avd-on-azure-local.md             (NEW — AVD architecture on Azure Local)
│   ├── deploying-avd.md                  (NEW — session hosts, host pools)
│   └── managing-avd.md                   (NEW — user sessions, scaling, FSLogix)
├── 09-operations/
│   ├── index.md
│   ├── monitoring-and-alerts.md          (KEEP — consolidated)
│   ├── troubleshooting.md                (KEEP — updated tools/methods)
│   ├── backup-and-restore.md             (KEEP — operational procedures)
│   └── disaster-recovery.md              (KEEP — failover/failback procedures)
├── 10-cloud-deployment/
│   ├── index.md                          (NEW — entire section)
│   ├── deployment-overview.md            (NEW — Azure Portal cloud deployment)
│   ├── prerequisites.md                  (NEW)
│   └── registration-and-arc.md           (NEW — Arc registration flow)
├── presentations/
│   └── index.md                          (placeholder — links to new slide decks per module, status of each)
└── labs/
    ├── index.md                          (lab environment setup — sandbox + customer lab)
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

### Step 2 — Update `mkdocs.yml` nav

Update the `nav:` section to match the new folder structure with proper section labels and ordering.

### Step 3 — Rewrite `docs/index.md`

Replace the current placeholder with a proper landing page that includes:

- Training overview and objectives
- Target audience (Infrastructure Ops, SysAdmins, Cloud Admins)
- Prerequisite knowledge
- Module summary table (all modules, not just 6)
- Delivery options (remote, on-site, self-paced)
- Duration estimates per module and total
- The existing placeholder warning (keep until content is complete)

---

## Phase 2: Content — What to KEEP, EDIT, ADD, or DROP

### KEEP (update terminology Azure Stack HCI → Azure Local, update procedures)

| Old Topic | New Location | Changes Needed |
|-----------|-------------|----------------|
| Storage Spaces Direct fundamentals | `03-storage/` | Terminology update, add NVMe/PM tiers, remove outdated perf numbers |
| Disk types, cache, fault tolerance | `03-storage/` | Minor updates |
| Storage ReSync | `03-storage/` | Minor updates |
| Core Networking (vSwitch, Network ATC, RDMA, SR-IOV) | `04-networking/` | Terminology update, Network ATC v2 changes |
| Hyper-V / VM High Availability / Live Migration | `02-compute/` | Reframe under Arc VMs, keep clustering fundamentals |
| Azure Site Recovery | `05-hybrid-services/` | Update for Arc-based protection, new portal flows |
| Azure Backup | `05-hybrid-services/` | Update for Arc-based backup, MARS agent changes |
| Azure Monitor integration | `05-hybrid-services/` | Update for Azure Monitor Agent, Insights |
| Security features (Secured-core, BitLocker) | `06-security/` | Expand significantly |
| Troubleshooting (VMs, Clustering, S2D) | `09-operations/` | Update tools, add Arc-specific troubleshooting |

### ADD (new content — did not exist in old training)

| Topic | Location | Reason |
|-------|----------|--------|
| Azure Portal as primary management | `01-management/azure-portal.md` | Azure Local is now cloud-first managed |
| Azure Arc integration & management fabric | `01-management/azure-arc-integration.md` | Core to Azure Local identity |
| Azure Arc VM deployment (portal-based) | `02-compute/arc-vm-deployment.md` | Primary VM creation method now |
| Azure Arc VM management (lifecycle) | `02-compute/arc-vm-management.md` | Portal-based VM operations |
| VM images & Azure Marketplace gallery | `02-compute/vm-images-and-gallery.md` | New capability |
| Logical Networks for Arc VMs | `04-networking/logical-networks.md` | New networking model |
| Arc-managed SDN for Azure Local | `04-networking/arc-managed-sdn.md` | SDN reframed as Arc-managed |
| Azure Update Manager | `05-hybrid-services/azure-update-manager.md` | Replaces WSUS/old Update Management |
| Microsoft Defender for Cloud | `05-hybrid-services/defender-for-cloud.md` | Replaces old Security Center |
| SMI & drift protection | `06-security/smi-and-drift-protection.md` | New security baseline feature |
| AKS cluster deployment & workload mgmt | `07-azure-kubernetes/` | AKS is now part of cluster deployment |
| Azure Virtual Desktop on Azure Local | `08-azure-virtual-desktop/` | NEW module — AVD architecture, session hosts, host pools, FSLogix, scaling |
| Cloud Deployment via Azure Portal | `10-cloud-deployment/` | Entirely new deployment model |
| Hands-on Labs (10 labs) | `labs/` | Structured labs aligned to modules, both sandbox + customer lab |
| Consolidated Delivery Guide | `delivery-guide.md` | Single guide with modular delivery options |
| Presentations placeholder | `presentations/index.md` | Links to new slide decks per module, tracks status |

### DROP (obsolete — do not carry forward)

| Old Topic | Reason |
|-----------|--------|
| System Center Virtual Machine Manager (SCVMM) | Deprecated for Azure Local management |
| Windows Admin Center (WAC) | Dropped — Azure Portal + Arc is the management plane |
| Azure File Sync | Not core to Azure Local operator training |
| SDN deep-dive (8-module track) | Replaced by Arc-managed SDN overview in networking module |
| Chalk and Talk (90-min intro) | Replace with "What is Azure Local" section |
| Legacy deployment methods (WAC-based cluster creation) | Cloud deployment is now primary |
| Cloud Witness as standalone topic | Fold into HA/clustering section |
| Old SharePoint content links | Dead links to Microsoft internal SharePoint |

### EDIT (significant rewrites needed)

| Topic | What Changes |
|-------|-------------|
| Full Delivery Guide | Rewrite as modern delivery guide with Azure Local branding, updated durations, updated prereqs, modular delivery tracks |
| Compute module | Reframe from "Hyper-V administration" to "Azure Arc VM operations" — Hyper-V is the engine but Arc is the interface |
| Hybrid Features module | Split into "Hybrid Services" (ASR, Backup, Monitor, Update Manager) and fold security items into Security module |
| AKS module | Complete rewrite — AKS is now part of cluster deployment, focus on deploying AKS clusters and managing workloads |
| Networking module | Add Arc-managed SDN as topic alongside core networking |
| Security module | Expand from thin 2-hour overview to comprehensive module covering Secured-core, BitLocker, Defender for Cloud, SMI, WDAC |

---

## Phase 3: Delivery Guide & Curriculum Design

### Step 4 — Create `delivery-guide.md`

Consolidate the 9 old delivery guides into a single modern delivery guide with:

- **Track A: Essentials (2 days)** — Modules 00-02, 05, 09 (Intro, Management, Compute, Hybrid Services, Operations)
- **Track B: Full (4 days)** — All modules 00-10
- **Track C: Infrastructure Deep-Dive (3 days)** — Modules 00-04, 06, 09 (adds Storage, Networking, Security, Operations)
- **Track D: Cloud-Native (2 days)** — Modules 00-01, 07, 10 (Intro, Management, AKS, Cloud Deployment)
- **Track E: VDI/AVD (2 days)** — Modules 00-02, 08, 09 (Intro, Management, Compute, AVD, Operations)
- Each track with: knowledge level, duration, target audience, prerequisites, agenda, lab mapping

### Step 5 — Write module index pages

Each module's `index.md` should contain: learning objectives, topics covered, estimated duration, prerequisite modules, key terminology.

### Step 6 — Create presentations placeholder

- `presentations/index.md` — Table of all modules with columns: Module, Slide Deck Name, Status (To Create / In Progress / Complete), Link
- This tracks the slide deck creation effort aligned to each training module

---

## Phase 4: Lab Development

### Step 7 — Create lab framework

- `labs/index.md` — Lab environment options: (A) Azure Local sandbox/jumpstart, (B) customer's own lab, with setup guidance for both
- 10 labs, each with: objectives, prerequisites, step-by-step instructions, validation steps, cleanup
- Labs are independent and map to specific modules
- Lab environment setup guide covering what's needed for each option

---

## Phase 5: Slide Deck Creation

### Step 8 — Create new PowerPoint decks

Create new slide decks aligned 1:1 with training modules:

- `00-Introduction.pptx`
- `01-Management.pptx`
- `02-Compute.pptx`
- `03-Storage.pptx`
- `04-Networking.pptx`
- `05-Hybrid-Services.pptx`
- `06-Security.pptx`
- `07-Azure-Kubernetes.pptx`
- `08-Azure-Virtual-Desktop.pptx`
- `09-Operations.pptx`
- `10-Cloud-Deployment.pptx`

Old PowerPoints in `referrence/PowerPoint/` serve as content reference for updating. New decks should use Azure Local branding and reflect current Azure Portal/Arc workflows.

---

## Phase 6: Update Infrastructure & Cleanup

### Step 9 — Update `mkdocs.yml`

- Add full nav tree matching folder structure
- Ensure admonition extensions work for warnings/notes
- Add any needed plugins (e.g., search, tags)

### Step 10 — Rename `referrence/` to `archive/`

- `git mv referrence archive` — preserve all old materials, don't delete
- Old PowerPoints stay archived here for reference

### Step 11 — Update `README.md`

- Repo purpose, contribution guide link, build instructions

---

## Relevant Files

- `docs/index.md` — Rewrite landing page (currently placeholder)
- `mkdocs.yml` — Update nav to match new structure
- `referrence/Delivery Guide/*.md` — Source material for content (9 delivery guides)
- `referrence/PowerPoint/` — 24 .pptx files organized by topic (reference for content accuracy)
- `README.md` — Update with repo description

---

## Verification

1. Run `mkdocs serve` locally after structure is created — verify all pages render, nav works
2. Check that every nav entry in `mkdocs.yml` has a corresponding `.md` file
3. Verify no broken internal links between docs
4. Verify the MkDocs Material admonition renders the placeholder warning correctly
5. Push to main and verify GitHub Pages deployment at `https://azurelocal.cloud/azurelocal-training/`

---

## Key Decisions

| Decision | Rationale |
|----------|-----------|
| **SDN** | Reduced to overview in Networking section — SDN deep-dive track (8 modules) is dropped because Azure Local is moving toward simplified Arc-based networking. Can be added back as an advanced elective later. |
| **SCVMM** | Dropped entirely — Azure Portal + Azure Arc is the management plane for Azure Local. |
| **WAC** | Dropped entirely — Azure Portal + Azure Arc is the management plane for Azure Local. |
| **Lab environment** | Both sandbox/jumpstart AND customer's own lab. Provide setup guidance for both. |
| **PowerPoint decks** | Old decks archived. New slide decks created 1:1 with modules as a separate effort. |
| **Old reference materials** | Preserved in `archive/` (renamed from `referrence/`), not deleted. |
| **Content depth** | L200-L300 core, L100 for intro module only. |
| **AVD** | Added as new module 08 — AVD on Azure Local is a key workload scenario. |
| **AKS** | Rewritten to focus on deploying AKS clusters and managing workloads (not old standalone AKS-HCI). |
