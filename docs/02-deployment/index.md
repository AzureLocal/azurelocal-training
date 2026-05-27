# Module 02: Deployment

**Level:** L200 | **Duration:** 4 hours | **Prerequisites:** Modules 00–01 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

## Learning Objectives

- Complete all prerequisites for a cloud Azure Local deployment
- Register Azure Local nodes with Azure Arc
- Deploy an Azure Local cluster via the Azure Portal
- Perform post-deployment validation
- Diagnose and resolve common deployment failures

## Topics

1. Deployment Architecture — Portal → Arc → on-premises
2. Hardware Prerequisites — node validation
3. Network Prerequisites — firewall rules, required endpoints, DNS
4. Identity Prerequisites — Entra ID, deployment user, permissions
5. Pre-Deployment Validation
6. Cloud Deployment via Azure Portal — end-to-end walkthrough
7. Arc Registration — node onboarding
8. Post-Deployment Validation
9. Common Deployment Failures and How to Diagnose

## Hands-on

**Lab:** Deploy a cluster via the Azure Portal (using HCIBox or a customer cluster). Run cluster validation. Confirm Arc registration.

IaC: Bicep templates for sandbox cluster preparation in `labs/iac/02-deployment/`.

## Related Resources

- [Azure Local deployment documentation](https://learn.microsoft.com/azure-local/deploy/)
- Slides: `slides/02-deployment/` (planned)
