# Module 01: Azure Arc — Infrastructure Deep Dive

**Level:** L300 | **Duration:** 3 hours | **Prerequisites:** Module 03 | **Hands-on:** Demo

!!! note "Module Status"
    Framework module — content in development.

## Learning Objectives

- Explain the Azure Arc architecture as it applies to Azure Local infrastructure
- Describe the role and mechanics of the Arc Resource Bridge
- Identify what runs on the cluster (Arc agents, extensions) vs. what runs in Azure
- Diagnose Arc connectivity and agent health issues
- Understand the Arc extension model and how Azure Local capabilities are delivered through it

## Topics

1. Azure Arc Concepts — Arc-enabled servers, resources, and clusters
2. Arc Fabric for Azure Local — how Arc is the substrate for Azure Local capabilities
3. **Arc Resource Bridge** — architecture, components, lifecycle
4. Arc Agents — connected machine agent, cluster shadow, agent extensions
5. Arc Extensions — how Azure Local features (VMs, AKS, AVD, IoT, Foundry) are delivered as Arc extensions
6. Identity and Authentication for Arc — managed identities, service principals
7. Diagnosing Arc — agent health, connectivity, common failure modes

## Hands-on

**Demo:** Walk through Arc Resource Bridge components on a deployed cluster, inspect agents/extensions, simulate an agent failure and recovery.

## Related Resources

- [Azure Arc documentation](https://learn.microsoft.com/azure/azure-arc/)
- [Arc Resource Bridge](https://learn.microsoft.com/azure/azure-arc/resource-bridge/overview)
- Slides: `slides/04-azure-arc/` (planned)
