# Module 03: Storage

**Level:** L300 | **Duration:** 4 hours | **Prerequisites:** Module 05 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

## Learning Objectives

- Describe the Storage Spaces Direct (S2D) architecture
- Configure and manage volumes, storage pools, and disks
- Choose appropriate disk types (HDD, SSD, NVMe, PM) and cache configuration
- Configure fault tolerance — mirror, parity, and nested resiliency
- Understand ReFS and storage efficiency features
- Monitor S2D health, ReSync, and performance

## Topics

1. Storage Spaces Direct Architecture
2. Storage Pool, Virtual Disks, Volumes
3. Disk Types and Cache — HDD, SSD, NVMe, PM
4. Fault Tolerance — two-way mirror, three-way mirror, parity, nested resiliency
5. **ReFS** — resilient file system on S2D
6. **Storage Efficiency** — dedup, compression
7. Storage ReSync — what triggers it, monitoring, operational impact
8. Volume Management — create, resize, retire
9. Monitoring Storage Health — Azure Monitor, counters, alerts

## Hands-on

**Lab:** Create a new volume with selected resiliency. Inspect cache and tier allocation. Trigger a ReSync. Monitor health and alerts.

IaC: Bicep templates in `labs/iac/06-storage/`.

## Related Resources

- [Storage Spaces Direct](https://learn.microsoft.com/windows-server/storage/storage-spaces/storage-spaces-direct-overview)
- Slides: `slides/06-storage/` (planned)
