# IaC — Module 02: Compute

Bicep templates for the Module 02 Compute labs. Provisions Arc VMs on Azure Local for lab exercises.

## Status

Planned. See [lab-01-deploy-arc-vm.md](../../../docs/labs/lab-01-deploy-arc-vm.md) for the lab that uses these templates.

## Planned files

| File | Purpose |
|------|---------|
| `deploy-vm.bicep` | Deploy an Arc VM on Azure Local |
| `deploy-vm.parameters.json` | Parameters: cluster resource ID, VM name, size, image, network |
| `cleanup.ps1` | Remove deployed VM and associated resources |
| `README.md` | This file |
