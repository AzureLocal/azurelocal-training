# Research: Azure IoT Operations on Azure Local

**Status:** Complete (initial)
**Assigned:** @kristopherjturner
**Added:** 2026-05-27
**Updated:** 2026-05-27
**Module:** 16 — IoT Operations on Azure Local

Source of truth: https://learn.microsoft.com/azure/iot-operations/ (as of May 2026)

---

## 1. What is Azure IoT Operations (AIO)?

Azure IoT Operations is Microsoft's **edge-native, Arc-enabled, Kubernetes-based** suite for industrial/OT data ingestion and processing. It is Microsoft's strategic replacement and consolidation of the older Azure IoT stack for new edge solutions.

| | IoT Hub | IoT Edge (v1) | **IoT Operations** |
|---|---|---|---|
| Form factor | Cloud PaaS endpoint | Single-VM/box Docker runtime | Kubernetes pods on Arc cluster |
| Management plane | IoT Hub resource | Hub-attached devices | **Azure Resource Manager** (native ARM resources via Microsoft.IoTOperations) |
| Data plane | AMQP/MQTT to cloud | Modules → IoT Hub | Edge **MQTT broker** + **dataflows** to Fabric/Event Hubs/etc. |
| Asset model | Per-device twin | Per-device twin | **Azure Device Registry** (assets, schemas, namespaces) |
| Status | GA, maintenance | GA but de-emphasized | GA on Linux; AKS-on-AzLocal in **public preview** |

## 2. How it lands on Azure Local

AIO runs as workloads on an **Arc-enabled AKS cluster on Azure Local** (AKS Arc). It is NOT a host-level service and does NOT run on the Azure Local host OS, Hyper-V directly, or as a VM extension. It is shipped as **Arc Kubernetes extensions** layered onto an Arc-connected AKS Arc cluster.

Support: AKS on Azure Local is **Public preview** for AIO (validated minimum Azure Stack HCI OS 23H2 build 2411; current Azure Local 2604 supersedes this). K3s/RKE2 on Linux are GA.

## 3. Cluster-side prerequisites

- Azure Local cluster deployed and Arc-connected
- **Arc Resource Bridge** for AKS Arc lifecycle
- **AKS Arc** workload cluster — Linux node pool only (Windows nodes unsupported)
- Cluster created with `--enable-oidc-issuer --enable-workload-identity --disable-auto-upgrade` (workload identity must be set at cluster creation)
- Custom Locations feature enabled (`az connectedk8s enable-features ... --features cluster-connect custom-locations`)
- Hardware: 16 GB RAM min / 32 GB recommended, 4 vCPU min / 8 recommended, 10 GB free for AIO pods
- Azure CLI 2.62+, extensions `connectedk8s` and `azure-iot-ops`
- Resource providers registered: `Microsoft.ExtendedLocation`, `Microsoft.Kubernetes`, `Microsoft.KubernetesConfiguration`, `Microsoft.IoTOperations`, `Microsoft.DeviceRegistry`, `Microsoft.SecretSyncController`
- An Azure Storage account (for Schema Registry) and an Azure Key Vault (for secret sync) in the same RG
- GPU: **not required** for the base AIO install

## 4. Canonical scenarios

- Manufacturing edge / OPC UA anomaly detection — **the canonical Microsoft demo**
- Retail edge (POS + cameras)
- Smart buildings / BMS telemetry
- Energy / utilities SCADA bridging

**Recommended single-lab demo:** OPC UA simulator → MQTT broker → dataflow → Microsoft Fabric (or Event Hubs).

## 5. Components

- **MQTT broker** — Microsoft's own edge-native broker (not Mosquitto, not Azure MQ). Pub/sub backbone for all internal traffic.
- **Connectors** — including the GA **Connector for OPC UA** and **Akri connectors** (HTTP/REST, ONVIF, media). Akri provides device discovery.
- **Azure Device Registry** — projects assets/devices as ARM resources; uses namespaces.
- **Schema registry** — backed by the required Azure Storage account; used by dataflows for (de)serialization.
- **Dataflows** — transform/route MQTT messages to cloud endpoints.
- **Operations experience** — web UI at iotoperations.azure.com for OT users.
- **Azure Container Storage enabled by Arc (ACSA)** — optional, for dataflow local storage endpoints / media.

## 6. Cloud destinations (dataflow endpoints)

- Azure Event Grid (MQTT)
- Azure Event Hubs / Kafka
- Microsoft Fabric OneLake
- Azure Data Lake Storage Gen2
- Azure Data Explorer (Kusto)
- Local storage endpoint (via ACSA)

## 7. Bicep / ARM templates

- Official samples repo: **[Azure-Samples/explore-iot-operations](https://github.com/Azure-Samples/explore-iot-operations)** — contains the local-deployment quickstart and ARM/Bicep snippets
- AKS Edge Essentials bootstrap script: [AksEdgeQuickStartForAio.ps1](https://github.com/Azure/AKS-Edge/blob/main/tools/scripts/AksEdgeQuickStart/AksEdgeQuickStartForAio.ps1) (PowerShell)
- Primary deployment path: `az iot ops init` + `az iot ops create`. Bicep coverage of `Microsoft.IoTOperations/instances`, `Microsoft.DeviceRegistry/*`, and dataflow resources exists but is sparse — expect mixed CLI+Bicep in the lab
- Resource provider API versions to pin: `Microsoft.IoTOperations` 2024-11-01, `Microsoft.DeviceRegistry` 2024-11-01

## 8. Minimum ~45-minute lab outline

Learner outcome: get edge telemetry from a simulated OPC UA asset, through AIO on AKS Arc on their Azure Local cluster, into Event Hubs.

1. **(Pre-built)** AKS Arc cluster on Azure Local with workload identity + custom locations
2. (5 min) Register the six resource providers; install `azure-iot-ops` CLI extension
3. (5 min) Create Storage account + Key Vault in the same RG
4. (10 min) `az iot ops init` then `az iot ops create` — wait for green
5. (5 min) Open iotoperations.azure.com, confirm the instance appears under the custom location
6. (5 min) Deploy the **OPC PLC simulator** to the cluster (Azure-Samples manifest)
7. (5 min) Onboard the simulator as an asset; pick 2–3 tags
8. (5 min) Create Event Hubs namespace; configure a **dataflow** from `default` MQTT topic → Event Hubs
9. (5 min) Verify messages arriving in Event Hubs
10. (Stretch) Add a simple transformation in the dataflow

Cleanup: `az iot ops delete` + delete RG.

## Key URLs

- [Overview](https://learn.microsoft.com/azure/iot-operations/overview-iot-operations)
- [Deployment overview](https://learn.microsoft.com/azure/iot-operations/deploy-iot-ops/overview-deploy)
- [Prepare cluster](https://learn.microsoft.com/azure/iot-operations/deploy-iot-ops/howto-prepare-cluster)
- [Deploy AIO](https://learn.microsoft.com/azure/iot-operations/deploy-iot-ops/howto-deploy-iot-operations)
- [Sample repo](https://github.com/Azure-Samples/explore-iot-operations)

## Doc vs reality flags

- AIO docs still cite "Azure Stack HCI OS, version 23H2, build 2411" as validated minimum. Azure Local 2604 supersedes — treat as validated-but-stale.
- Microsoft's edge broker is sometimes called "MQ" in older blog posts; current docs/UI use "MQTT broker" only.
- AIO on AKS-on-Azure-Local is **public preview**; Linux K3s/RKE2 is GA. Module 16 lab should set expectations accordingly.

## Related

- Module 14 (AKS on Azure Local) — IoT Operations runs on AKS Arc
- Module 04 (Azure Arc — Infrastructure Deep Dive)
