# Module 16: IoT Operations on Azure Local

**Level:** L300 | **Duration:** 3 hours | **Prerequisites:** Module 14 | **Hands-on:** Lab

!!! note "Module Status"
    Framework module — **content scope under research.** See [research/iot-operations.md](https://github.com/AzureLocal/azurelocal-training/blob/main/repo-management/research/iot-operations.md).

## Learning Objectives (tentative)

- Describe Azure IoT Operations and its role on Azure Local
- Deploy Azure IoT Operations on an AKS Arc cluster running on Azure Local
- Configure MQTT broker and data flows
- Route edge data to Azure (Event Hubs, Microsoft Fabric)
- Manage IoT Operations at scale across multiple edge clusters

## Topics (tentative)

1. Azure IoT Operations Overview — vs. IoT Hub / IoT Edge
2. Architecture on Azure Local — AKS Arc dependency
3. Deployment via Arc Extension
4. MQTT Broker — concepts and configuration
5. Schema Registry
6. Data Flows — edge → Azure pipelines
7. Integration with Microsoft Fabric and Event Hubs
8. Multi-Edge Management

## Hands-on

**Lab:** Deploy Azure IoT Operations on the cluster's AKS Arc instance. Configure an MQTT data flow. Simulate device data. Verify ingestion at the Azure side.

IaC: Bicep templates in `labs/iac/16-iot-operations/` (planned).

## Related Resources

- [Azure IoT Operations](https://learn.microsoft.com/azure/iot-operations/)
- Research notes: [research/iot-operations.md](https://github.com/AzureLocal/azurelocal-training/blob/main/repo-management/research/iot-operations.md)
- Slides: `slides/16-iot-operations/` (planned)
