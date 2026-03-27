# Training

## Overview

Training covers core day-to-day operations for managing workloads on Azure Local using Azure Arc.

---

## Training Modules

| Module | Topic | Duration |
|--------|-------|----------|
| 1 | Azure Arc VM Deployment | 1 hour |
| 2 | Azure Arc VM Management | 1 hour |
| 3 | Azure Site Recovery Protection | 1 hour |
| 4 | Azure Backup and Restore | 1 hour |
| 5 | Disaster Recovery Failover | 30 min |
| 6 | Azure Update Manager | 30 min |

---

## Module 1: Azure Arc VM Deployment

### Learning Objectives

After completing this module, customers will be able to:

- Deploy a new Azure Arc VM from the Azure Portal
- Select appropriate VM images from the gallery
- Configure VM sizing and resource allocation
- Assign network configurations to VMs
- Understand storage placement options

### Topics Covered

1. **Navigating to Azure Arc VMs**
   - Access Azure Portal → Azure Arc → Azure Local → Clusters → Virtual Machines
   - Understanding the VM gallery and available images

2. **Creating a New VM**
   - Name and resource group selection
   - Image selection (Windows Server, Linux)
   - VM size configuration (vCPUs, memory)
   - Administrator credentials

3. **Network Configuration**
   - Logical network selection
   - Static vs. DHCP IP assignment
   - Network security considerations

4. **Storage Configuration**
   - Storage path selection
   - Disk sizing and performance tiers
   - Additional data disk attachment

---

## Module 2: Azure Arc VM Management

### Learning Objectives

After completing this module, customers will be able to:

- Start, stop, and restart Azure Arc VMs
- Add and remove virtual disks
- Modify network configurations
- Resize VM resources
- Monitor VM performance

### Topics Covered

1. **VM Lifecycle Operations**
   - Start, Stop, Restart operations from Azure Portal
   - Understanding graceful shutdown vs. force stop
   - VM state monitoring

2. **Disk Management**
   - Adding data disks to existing VMs
   - Removing disks (data preservation considerations)
   - Disk performance monitoring

3. **Network Changes**
   - Adding/removing network interfaces
   - Changing network assignments
   - IP address management

4. **Resource Modification**
   - Changing VM size (requires VM stop)
   - Memory and CPU adjustments
   - Impact on running workloads

---

## Module 3: Azure Site Recovery Protection

### Learning Objectives

After completing this module, customers will be able to:

- Enable replication for Azure Arc VMs
- Configure replication settings
- Monitor replication health
- Understand recovery point objectives (RPO)

### Topics Covered

1. **Enabling Protection**
   - Selecting VMs for protection
   - Configuring target recovery vault
   - Setting replication policies

2. **Replication Monitoring**
   - Understanding replication states
   - Monitoring sync progress
   - Troubleshooting replication issues

3. **Recovery Point Management**
   - Understanding crash-consistent vs. app-consistent points
   - Recovery point retention policies
   - Storage implications

---

## Module 4: Azure Backup and Restore

### Learning Objectives

After completing this module, customers will be able to:

- Configure backup policies for VMs
- Perform on-demand backups
- Restore VMs from backup
- Restore individual files from backup

### Topics Covered

1. **Backup Configuration**
   - Creating backup policies
   - Assigning VMs to backup policies
   - Understanding backup schedules and retention

2. **Backup Operations**
   - Running on-demand backups
   - Monitoring backup job status
   - Viewing backup history

3. **Restore Operations**
   - Full VM restore procedures
   - Restore to alternate location
   - File-level recovery (where supported)

---

## Module 5: Disaster Recovery Failover

### Learning Objectives

After completing this module, customers will be able to:

- Perform test failovers
- Execute planned failovers
- Execute unplanned failovers
- Complete failback procedures

### Topics Covered

1. **Test Failover**
   - Purpose and importance of testing
   - Executing test failover
   - Validating recovered VMs
   - Cleaning up test resources

2. **Failover Operations**
   - Planned vs. unplanned failover scenarios
   - Failover execution steps
   - Post-failover validation

3. **Failback Procedures**
   - Re-protecting VMs after failover
   - Failback execution
   - Resuming normal operations

---

## Module 6: Azure Update Manager

### Learning Objectives

After completing this module, customers will be able to:

- Assess update compliance for Azure Arc VMs
- Schedule update deployments
- Monitor update installation status
- Manage update policies

### Topics Covered

1. **Update Assessment**
   - Viewing available updates
   - Understanding update classifications
   - Compliance reporting

2. **Update Deployment**
   - Creating update schedules
   - Defining maintenance windows
   - Selecting update classifications to install

3. **Update Monitoring**
   - Tracking deployment progress
   - Reviewing installation results
   - Handling failed updates

---

## Training Delivery

| Delivery Method | Audience Size | Duration |
|-----------------|---------------|----------|
| Remote (Teams/Zoom) | 1-10 | 4-6 hours |
| On-site | 1-20 | Full day |
| Recorded sessions | Unlimited | Self-paced |

### Prerequisites

- Azure Portal access with appropriate RBAC permissions
- Basic understanding of virtualization concepts
- Familiarity with Windows Server administration

---

## Resources

| Resource | URL |
|----------|-----|
| Azure Arc VM Documentation | [Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-arc/servers/) |
| Azure Backup Documentation | [Microsoft Learn](https://learn.microsoft.com/en-us/azure/backup/) |
| Azure Site Recovery Documentation | [Microsoft Learn](https://learn.microsoft.com/en-us/azure/site-recovery/) |
| Azure Update Manager Documentation | [Microsoft Learn](https://learn.microsoft.com/en-us/azure/update-manager/) |

