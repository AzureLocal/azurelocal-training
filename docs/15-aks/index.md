# Module 15: AKS on Azure Local

**Level:** L300 | **Duration:** 4 hours | **Prerequisites:** Module 05 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — content in development.

## Learning Objectives

- Describe the AKS Arc architecture on Azure Local
- Deploy an AKS cluster on Azure Local
- Configure node pools, networking, and storage for AKS workloads
- Deploy a containerized application and manage it with kubectl
- Monitor and update an AKS cluster

## Topics

1. AKS Arc Architecture on Azure Local
2. Prerequisites — Arc Resource Bridge, networking
3. Deploying an AKS Cluster — Portal walkthrough
4. Deploying via Bicep / Terraform
5. Node Pools — sizing, scaling
6. Workload Networking — services, ingress, load balancers
7. Workload Storage — persistent volumes on S2D
8. Managing Workloads with kubectl
9. Monitoring and Updating an AKS Cluster

## Hands-on

**Lab:** Deploy an AKS cluster. Deploy a sample app. Scale the deployment. Update the cluster.

IaC: Bicep + Terraform templates in `labs/iac/14-aks/`.

## Related Resources

- [AKS on Azure Local](https://learn.microsoft.com/azure/aks/hybrid/)
- Slides: `slides/14-aks/` (planned)
