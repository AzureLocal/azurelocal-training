# Research: Azure AI Foundry Local

**Status:** Pending
**Assigned:** @kristopherjturner
**Added:** 2026-05-27
**Module:** 17 — Azure AI Foundry Local

## Objective

Define what an "Azure AI Foundry Local" training module needs to cover. Goal: enable operators to deploy and manage Azure AI Foundry Local workloads on Azure Local infrastructure for sovereign / data-residency / low-latency AI workloads.

## Scope Questions

1. What is Azure AI Foundry Local and how does it differ from cloud-hosted Azure AI Foundry?
2. What model families can run locally (Phi, Llama, custom)?
3. How does it deploy on Azure Local — Arc extension, AKS workload, VM-based?
4. What hardware requirements (GPU SKUs, memory) does Foundry Local impose on Azure Local nodes?
5. What is the operator persona — is this still managed by infra ops, or by AI/ML ops?
6. What identity, networking, and security considerations apply?
7. What lab scenario showcases value (sovereign chat assistant, document summarization, RAG)?

## Lab/Demo Concept

Deploy Azure AI Foundry Local on an Azure Local cluster (likely via AKS Arc + GPU node pool), deploy a small model (Phi-3 or similar), call the local inference endpoint from a test workload, and confirm no data leaves the cluster.

## Search Leads

- https://learn.microsoft.com/azure/ai-foundry/foundry-local/
- https://github.com/microsoft/Foundry-Local
- Azure AI Foundry documentation (cloud counterpart)
- Azure Local GPU partitioning / GPU SR-IOV documentation

## Findings

_Not yet investigated._

## Related

- Module 14 (AKS on Azure Local) — Foundry Local likely runs on AKS Arc
- Module 04 (Azure Arc — Infrastructure Deep Dive)
- Module 09 (Security & Compliance) — sovereign AI compliance angle
