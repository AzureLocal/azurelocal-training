# Module 11: Troubleshooting

**Level:** L300 | **Duration:** 4 hours | **Prerequisites:** Modules 05–08, 10 | **Hands-on:** Lab/Demo

!!! note "Module Status"
    Framework module — content in development.

## Learning Objectives

- Diagnose Arc VM and Hyper-V-level issues
- Diagnose Failover Clustering failures
- Diagnose S2D storage issues (resync, capacity, performance)
- Diagnose networking failures (Network ATC, RDMA, vSwitch)
- Diagnose SDN issues (network controller, SLB, gateway)
- Diagnose deployment failures
- Use the standard Azure Local diagnostic tools

## Topics

1. Diagnostic Toolset — `Get-AzureStackHciLog`, sddc diagnostics, event logs
2. VM Troubleshooting — Arc-specific failure modes
3. Failover Clustering Troubleshooting — quorum, witness, node failures
4. S2D Troubleshooting — disk failures, ReSync stuck, capacity exhaustion
5. Network Troubleshooting — Network ATC, RDMA, SMB
6. SDN Troubleshooting — Network Controller, SLB, gateway
7. Deployment Failure Diagnosis — common errors and resolutions
8. When and How to Engage Microsoft Support

## Hands-on

**Lab/Demo:** Guided break-fix scenarios. Instructor injects failures (disk pull, network unplug, agent stop) and learners diagnose using documented tools.

## Related Resources

- [Azure Local troubleshooting](https://learn.microsoft.com/azure-local/manage/troubleshoot)
- Slides: `slides/11-troubleshooting/` (planned)
