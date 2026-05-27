# Module Status

Last updated: 2026-05-27

**ADO Project:** `Azure Local Training` (org: hybridcloudsolutions). Work items tagged with `AB#<id>` in commit messages.

## Legend

| Symbol | Meaning |
|--------|---------|
| — | Not started |
| Stub | Folder + `index.md` framework only |
| Draft | In progress, not review-ready |
| Review | Ready for domain or technical review |
| Done | Published to main |

## Status Board

| # | Module | Track | Module page | Lab guide | IaC | Slides | Narration | AI tutor |
|---|--------|-------|-------------|-----------|-----|--------|-----------|----------|
| 00 | Introduction to Azure Local | Foundations | Stub | — | — | — | — | — |
| 01 | Azure Arc — Infrastructure Deep Dive | Foundations | Stub | — | — | — | — | — |
| 02 | Compute (Hyper-V + Failover Clustering + Arc VMs) | Foundations | Stub | — | — | — | — | — |
| 03 | Storage | Foundations | Stub | — | — | — | — | — |
| 04 | Core Networking | Foundations | Stub | — | — | — | — | — |
| 05 | Software Defined Networking (Arc-managed) | Foundations | Stub | — | — | — | — | — |
| 06 | Planning & Sizing | Deployment | Stub | — | — | — | — | — |
| 07 | Deployment | Deployment | Stub | — | — | — | — | — |
| 08 | Post-Deployment Configurations | Deployment | Stub | — | — | — | — | — |
| 09 | Management | Operations | Stub | — | — | — | — | — |
| 10 | Security & Compliance | Operations | Stub | — | — | — | — | — |
| 11 | Observability & Monitoring | Operations | Stub | — | — | — | — | — |
| 12 | Troubleshooting | Operations | Stub | — | — | — | — | — |
| 13 | Business Continuity & DR (BCDR) | Operations | Stub | — | — | — | — | — |
| 14 | Day-2 Operations & Lifecycle | Operations | Stub | — | — | — | — | — |
| 15 | AKS on Azure Local | Workloads | Stub | — | — | — | — | — |
| 16 | Azure Virtual Desktop on Azure Local | Workloads | Stub | — | — | — | — | — |
| 17 | IoT Operations on Azure Local | Workloads | Stub | — | — | — | — | — |
| 18 | Azure AI Foundry Local | Workloads | Stub | — | — | — | — | — |
| 19 | Migration (VMware / Hyper-V → Azure Local) | Adoption | Stub | — | — | — | — | — |
| 20 | SCVMM (Optional / Placeholder) | Adoption | Stub | — | — | — | — | — |

## Notes

- **Module page** = `docs/<NN>-<slug>/index.md`
- **Lab guide** = `docs/<NN>-<slug>/lab-*.md` or demo script
- **IaC** = `labs/iac/<NN>-<slug>/main.bicep` etc.
- **Slides** = `slides/<NN>-<slug>/outline.md` then `.pptx`
- **Narration** = `slides/<NN>-<slug>/narration-script.md`
- **AI tutor** = system prompt + module content baked into the Next.js app
- See [training-platform-plan.md](../training-platform-plan.md) Section 3.1 for the canonical module list and ADR-0005 through ADR-0009 for design decisions.
