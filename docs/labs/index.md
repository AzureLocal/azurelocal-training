# Lab Environment Setup

All labs in this curriculum are designed for **two lab environment models**. Choose the one that matches your setup before starting any lab.

---

## Option A: Azure Arc Jumpstart HCIBox (Recommended for Self-Paced)

HCIBox is a pre-built nested-virtualization environment from the Azure Arc Jumpstart team. It provides a complete Azure Local cluster running inside Azure VMs — no physical hardware required.

**Prerequisites:**

- Azure subscription with contributor access
- `az` CLI installed and authenticated
- Quota for `Standard_E16s_v5` or similar in your target region

**Deployment:**

```bash
# Full setup instructions at: https://azurearcjumpstart.com/azure_jumpstart_hcibox
az deployment group create \
  --resource-group rg-hcibox-lab \
  --template-uri "https://raw.githubusercontent.com/microsoft/azure_arc/main/azure_jumpstart_hcibox/bicep/main.bicep"
```

---

## Option B: Customer / On-Premises Azure Local Cluster

If you have access to a physical Azure Local cluster, labs can be performed directly in that environment.

**Prerequisites:**

- Azure Local cluster deployed and Arc-registered
- Azure subscription connected to the cluster
- Contributor or higher access on the cluster resource group
- Credentials for a cluster node (local admin or domain account)

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
