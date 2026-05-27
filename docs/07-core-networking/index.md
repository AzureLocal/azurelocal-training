# Module 07: Core Networking

**Level:** L300 | **Duration:** 4 hours | **Prerequisites:** Module 06 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

## Learning Objectives

- Configure Network ATC intents (management, compute, storage)
- Explain virtual switch architecture and Switch Embedded Teaming (SET)
- Configure and validate RDMA (iWARP vs. RoCE), SMB Direct, and SMB Multichannel
- Configure SR-IOV
- Create and manage logical networks for Arc VMs

## Topics

1. Network ATC — intent-based networking, v2 features
2. Virtual Switch — Hyper-V vSwitch, SET (Switch Embedded Teaming)
3. **RDMA: iWARP vs. RoCE** — choosing the right transport
4. SMB Direct and SMB Multichannel
5. SR-IOV — when to use, configuration
6. Logical Networks for Arc VMs — IP pool management
7. Virtual NICs — vNIC adapters, MAC address management

## Hands-on

**Lab:** Configure Network ATC intents. Validate RDMA between nodes. Create a logical network and attach an Arc VM to it.

IaC: Bicep templates in `labs/iac/07-core-networking/`.

## Related Resources

- [Network ATC](https://learn.microsoft.com/azure-local/deploy/network-atc)
- [Logical networks for Azure Local](https://learn.microsoft.com/azure-local/manage/create-logical-networks)
- Slides: `slides/07-core-networking/` (planned)
