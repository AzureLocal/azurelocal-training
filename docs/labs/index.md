# Lab Environment Setup

Every lab in this curriculum can run in **three target environments**. We provide the lab building solutions — Bicep, Terraform, and PowerShell — and either the student or the lab moderator deploys them depending on the delivery format.

---

## Target environments

### A. Azure (cloud-hosted)

A nested-virtualization Azure Local lab built inside an Azure VM. No on-premises hardware required.

- **Use for:** on-demand self-paced learners, online live workshops where students don't have lab hardware
- **Built by:** our Bicep templates in [`labs/iac/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac)
- **Cost:** the student's (or workshop's) Azure subscription
- **Prerequisites:** Azure subscription, contributor access, quota for the workshop's VM SKU

### B. Physical Hyper-V server (nested environment)

A student's or customer's existing physical Hyper-V server runs the lab as nested VMs.

- **Use for:** students with hardware already on a Hyper-V host, customers who want labs on-prem without cloud cost, instructor-provided physical lab kit at an in-person workshop
- **Built by:** PowerShell + DSC scripts in [`labs/iac/onprem/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac) (planned)
- **Cost:** none beyond the existing hardware
- **Prerequisites:** physical Hyper-V host with nested virtualization enabled, sufficient RAM/CPU/storage for the lab's VMs

### C. Actual Azure Local hardware

The student or customer's own production or pilot Azure Local cluster.

- **Use for:** customers running Azure Local in production who want operators trained against real hardware, on-site delivery at a customer location
- **Built by:** N/A — environment already exists
- **Cost:** none beyond existing cluster
- **Prerequisites:** Azure Local cluster deployed and Arc-registered, contributor access on the cluster resource group, credentials for a cluster node

---

## Deployment patterns

Whichever environment is chosen, the lab is provisioned in one of two patterns:

### Student-deployed (self-guided / on-demand)

The student runs the provided template against their own subscription or hardware. Used for on-demand self-paced classes.

- Templates live under [`labs/iac/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac)
- A shared base at [`labs/iac/shared/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac/shared) provisions the common substrate; per-module templates layer on top
- Each template includes a `cleanup.ps1` so resources can be destroyed when the lab ends

### Moderator-deployed (instructor-led, in-person)

For in-person workshops, the lab moderator deploys one shared environment or a per-participant batch ahead of time. Students consume the environment without managing infrastructure.

- The same templates power this — the moderator runs them with a `participantCount` parameter
- Moderator distributes credentials at the start of the workshop and runs cleanup at the end

---

## Lab index

Lab guides are mapped to modules where applicable. See the individual module pages for the lab content.

| Module | Hands-on Type |
|--------|---------------|
| 01 — Azure Arc Deep Dive | Demo |
| 02 — Compute | **Lab** — Arc VM + Bicep |
| 03 — Storage | **Lab** — S2D volumes, ReSync |
| 04 — Core Networking | **Lab** — Network ATC, RDMA |
| 05 — SDN | **Lab** — Arc-managed SDN deploy, SLB |
| 07 — Deployment | **Lab** — deploy cluster (S2D, AD, Portal path) |
| 08 — Post-Deployment Configurations | **Lab** — RBAC, storage paths, VM images, logical networks |
| 09 — Management | **Lab** — Portal/CLI/WAC/OMSWAC tour |
| 10 — Security & Compliance | **Lab** — BitLocker, Policy, Defender |
| 11 — Observability & Monitoring | **Lab** — Monitor, Insights, dashboards |
| 12 — Troubleshooting | **Lab/Demo** — break-fix |
| 13 — BCDR | **Lab** — ASR, Backup, DR test |
| 14 — Day-2 Operations | **Lab** — Update Manager, LCM |
| 15 — AKS on Azure Local | **Lab** — deploy AKS cluster |
| 16 — Azure Virtual Desktop | **Lab** — host pool, FSLogix |
| 17 — IoT Operations | **Lab** — OPC UA → MQTT → Event Hubs |
| 18 — Azure AI Foundry Local | **Lab** — Phi-4-mini sovereign chat |
| 19 — Migration | **Lab/Demo** — VMware → Azure Local |

IaC templates for each module live in [`labs/iac/<module>/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac).
