# Module 12: Business Continuity & Disaster Recovery (BCDR)

**Level:** L300 | **Duration:** 4 hours | **Prerequisites:** Modules 05–06 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

## Learning Objectives

- Design a BCDR strategy for Azure Local
- Configure Azure Site Recovery (ASR) for Arc VM protection
- Configure Azure Backup for VM and volume-level protection
- Perform a DR failover and failback
- Test DR plans and validate RTO/RPO targets

## Topics

1. BCDR Concepts — RTO, RPO, recovery tiers
2. **Azure Site Recovery** — Arc-based protection, replication, failover
3. **Azure Backup** — VM-level, volume-level, MARS agent
4. DR Planning — runbooks, failover sequence
5. Failover and Failback Procedures
6. DR Testing — non-disruptive test failover
7. Backup Restore Validation
8. Cross-Region and Cross-Site DR Patterns

## Hands-on

**Lab:** Enable ASR for an Arc VM. Run a test failover. Configure Azure Backup for a second VM. Restore a file. Validate RPO.

IaC: Bicep templates in `labs/iac/12-bcdr/`.

## Related Resources

- [Azure Site Recovery for Azure Local](https://learn.microsoft.com/azure-local/manage/azure-site-recovery)
- [Azure Backup for Azure Local](https://learn.microsoft.com/azure-local/manage/azure-backup)
- Slides: `slides/12-bcdr/` (planned)
