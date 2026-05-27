# Module 18: Azure AI Foundry Local

**Level:** L300 | **Duration:** 3 hours | **Prerequisites:** Module 14 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content scope under research.

## Learning Objectives (tentative)

- Describe Azure AI Foundry Local and its value for sovereign / low-latency AI workloads
- Deploy Foundry Local on Azure Local infrastructure
- Deploy small language models (Phi, Llama variants) locally
- Configure GPU partitioning and SR-IOV on Azure Local for AI workloads
- Call local inference endpoints from workloads on the cluster

## Topics (tentative)

1. Azure AI Foundry vs. Foundry Local — cloud vs. on-premises
2. Use Cases — sovereignty, data residency, low-latency inference
3. Hardware Requirements — GPU SKUs, memory
4. **GPU Partitioning and GPU SR-IOV** on Azure Local
5. Deployment on AKS Arc — Foundry Local containers
6. Model Management — pulling, deploying, updating models
7. Inference Endpoints — calling local APIs
8. Security and Compliance Considerations — keeping data on-prem

## Hands-on

**Lab:** Deploy Foundry Local on AKS Arc. Deploy a Phi-3 (or equivalent) small model. Call inference endpoint from a test app. Validate no data egress.

IaC: Bicep templates in `labs/iac/18-ai-foundry-local/` (planned).

## Related Resources

- [Azure AI Foundry Local](https://learn.microsoft.com/azure/ai-foundry/foundry-local/)
- Slides: `slides/18-ai-foundry-local/` (planned)
