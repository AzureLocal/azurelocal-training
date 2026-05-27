# Module 09: Security & Compliance

**Level:** L300 | **Duration:** 5 hours | **Prerequisites:** Modules 03–04 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development. This module is a major expansion vs. the legacy 2-hour security overview.

## Learning Objectives

- Apply Zero Trust principles to Azure Local
- Verify and enable Secured-core Server features (HVCI, VBS, TPM)
- Configure BitLocker encryption for OS and S2D volumes
- Apply Security Management Interface (SMI) baselines and drift detection
- Use Azure Policy to enforce compliance on Azure Local
- Use Microsoft Defender for Cloud for posture management
- Configure WDAC, Secure Boot, and Credential Guard

## Topics

1. Zero Trust Architecture for Azure Local
2. **Secured-core Server** — HVCI, VBS, TPM 2.0
3. Secure Boot
4. Credential Guard
5. BitLocker & Encryption — OS and S2D volumes, key management
6. **Security Management Interface (SMI)** — baselines, drift detection, remediation
7. WDAC — application control policies
8. **Azure Policy for Azure Local** — built-in initiatives, custom policies
9. **Microsoft Defender for Cloud** — posture, threat detection, recommendations
10. Network Security & Microsegmentation (recap from Module 08)

## Hands-on

**Lab:** Enable BitLocker on a volume. Apply an Azure Policy initiative and view compliance. Configure Defender for Cloud and review recommendations. Trigger an SMI drift and remediate.

IaC: Bicep + Azure Policy definitions in `labs/iac/09-security/`.

## Related Resources

- [Security features in Azure Local](https://learn.microsoft.com/azure-local/concepts/security-features)
- [Azure Policy for Azure Local](https://learn.microsoft.com/azure-local/manage/policy-resource-graph)
- Slides: `slides/09-security-compliance/` (planned)
