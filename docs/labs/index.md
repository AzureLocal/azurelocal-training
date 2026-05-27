# Lab Environment Setup

Every lab in this curriculum supports **two environment models**. Pick the one that matches your situation before starting.

---

## Option A: Customer hardware (real Azure Local cluster)

For students or teams with access to a physical Azure Local cluster.

**Prerequisites:**

- Azure Local cluster deployed and Arc-registered
- Azure subscription connected to the cluster
- Contributor or higher access on the cluster resource group
- Credentials for a cluster node (local admin or domain account)

**Use this when:** the student is already an operator on a production or pilot cluster, or the training is delivered on-site at a customer location with their hardware.

---

## Option B: Provided lab building solutions

When customer hardware isn't available, the workshop provides Bicep / Terraform templates that build a complete lab environment in Azure on demand. There are **two deployment patterns**:

### B.1 — Student-deployed (self-guided / on-demand)

The student deploys their own lab environment by running a provided Bicep template against their own Azure subscription. Used for the on-demand AI tutor classes and the self-paced video curriculum.

- Templates live under [`labs/iac/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac)
- Each module has its own template variant where applicable
- A shared base environment at [`labs/iac/shared/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac/shared) provisions the common substrate; module-specific templates layer on top
- Includes a `cleanup.ps1` per template so resources can be destroyed when the lab ends

**Student prerequisites:**

- Azure subscription (their own) with contributor access
- `az` CLI installed and authenticated
- Quota for the workshop's required VM SKUs (typically `Standard_E16s_v5` or similar)
- `bicep` CLI available (`az bicep install`)

### B.2 — Moderator-deployed (instructor-led, in-person)

For in-person workshops, the lab moderator deploys one shared environment (or a per-participant batch) ahead of time. Students consume the environment without managing infrastructure.

The same templates power this — the moderator runs them in batch with a participant-count parameter, distributes credentials, and runs cleanup at the end of the workshop.

**Moderator prerequisites:**

- A dedicated workshop Azure subscription with quota for `participantCount × VM SKU`
- Service principal or managed identity with Contributor on the workshop RG
- The shared base template (`labs/iac/shared/lab-environment.bicep`) plus the module-specific templates the workshop will cover

---

## Lab Index

Lab guides are mapped 1:1 to modules where applicable. See the individual module pages for the lab content.

| Module | Hands-on Type |
|--------|---------------|
| 02 — Deployment | **Lab** — deploy cluster |
| 03 — Management | **Lab** — Portal/CLI/WAC tour |
| 04 — Azure Arc Deep Dive | Demo |
| 05 — Compute | **Lab** — Arc VM + Bicep |
| 06 — Storage | **Lab** — S2D volumes, ReSync |
| 07 — Core Networking | **Lab** — Network ATC, RDMA |
| 08 — SDN | **Lab** — SDN deploy, SLB |
| 09 — Security & Compliance | **Lab** — BitLocker, Policy, Defender |
| 10 — Observability & Monitoring | **Lab** — Monitor, dashboards |
| 11 — Troubleshooting | **Lab/Demo** — break-fix |
| 12 — BCDR | **Lab** — ASR, Backup, DR test |
| 13 — Day-2 Operations | **Lab** — Update Manager, LCM |
| 14 — AKS | **Lab** — deploy AKS cluster |
| 15 — AVD | **Lab** — host pool, FSLogix |
| 16 — IoT Operations | **Lab** — IoT Operations deploy |
| 17 — AI Foundry Local | **Lab** — Foundry Local deploy |
| 18 — Migration | **Lab/Demo** — VMware migration |

IaC templates for each module live in [`labs/iac/<module>/`](https://github.com/AzureLocal/azurelocal-training/tree/main/labs/iac).
