# Module 05: Software Defined Networking (Arc-managed)

**Level:** L300 | **Duration:** 4 hours | **Prerequisites:** Module 07 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development. **This is Arc-managed SDN for Azure Local — not SDN Express / traditional SDN.**

## Learning Objectives

- Describe Arc-managed SDN architecture for Azure Local
- Deploy and configure network controllers via Arc
- Configure software load balancers (SLB)
- Configure gateways for hybrid connectivity
- Apply microsegmentation policies for east-west traffic control

## Topics

1. SDN Concepts — overlay vs. underlay, control plane vs. data plane
2. **Arc-managed SDN for Azure Local** — what's different from SDN Express
3. Network Controllers — Arc-deployed, life cycle, scaling
4. Software Load Balancers (SLB) — public/private VIPs, health probes
5. Gateways — site-to-site, ExpressRoute integration
6. Microsegmentation and Network Security — applying policies to Arc VMs
7. SDN Operations and Day-2 Management

## Hands-on

**Lab:** Deploy Arc-managed SDN on the cluster. Configure an SLB. Attach an Arc VM and validate load balancing. Apply a microsegmentation policy.

IaC: Bicep templates in `labs/iac/08-sdn/`.

## Related Resources

- [SDN on Azure Local](https://learn.microsoft.com/azure-local/concepts/software-defined-networking)
- Slides: `slides/08-software-defined-networking/` (planned)
