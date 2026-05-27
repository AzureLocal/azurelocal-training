# Shared Lab Environment

Base Bicep template for the nested-virtualization lab environment. Each participant gets a dedicated Azure VM running Hyper-V with Azure Local nodes provisioned as nested VMs.

## Status

Planned — template not yet implemented. See [Section 6.3 of the platform plan](../../../repo-management/training-platform-plan.md) for the full design.

## Planned files

| File | Purpose |
|------|---------|
| `lab-environment.bicep` | Base nested-virt environment — Azure VM SKU, Hyper-V, network config |
| `lab-environment.parameters.json` | Parameters: region, VM SKU, participant count, module selector, TTL |
| `cleanup.ps1` | Destroys all lab resources after workshop |
| `README.md` | This file — prerequisites, deployment steps, cleanup |

## Parameters (planned)

| Parameter | Description | Default |
|-----------|-------------|---------|
| `location` | Azure region | `eastus` |
| `vmSku` | Nested-virt host VM size | `Standard_E16s_v5` |
| `participantCount` | Number of participants (batch provisioning) | `1` |
| `moduleSelector` | Which module-specific resources to deploy | `shared` |
| `ttlHours` | Hours until cleanup automation triggers | `8` |
