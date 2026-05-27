# Research: IoT Operations on Azure Local

**Status:** Pending
**Assigned:** @kristopherjturner
**Added:** 2026-05-27
**Module:** 16 — IoT Operations on Azure Local

## Objective

Define what an "IoT Operations on Azure Local" training module needs to cover. Goal: enable operators to deploy and manage Azure IoT Operations workloads running on Azure Local infrastructure.

## Scope Questions

1. What is Azure IoT Operations and how does it differ from Azure IoT Edge / IoT Hub?
2. How does IoT Operations land on Azure Local — is it Arc-enabled, K8s-based, or something else?
3. What prerequisites does the Azure Local cluster need (AKS Arc, specific extensions)?
4. What are the canonical IoT scenarios on Azure Local (manufacturing edge, retail, smart buildings)?
5. What Bicep/Terraform templates exist or should be authored for the lab?
6. What MQTT broker, schema registry, and data flow components are involved?
7. How does data egress to Azure Event Hubs / Fabric work?

## Lab/Demo Concept

Deploy Azure IoT Operations on an Azure Local cluster (via AKS Arc), configure an MQTT data flow, simulate edge device data, and verify data lands in an Azure data destination (Event Hub or Fabric).

## Search Leads

- https://learn.microsoft.com/azure/iot-operations/
- https://learn.microsoft.com/azure/iot-operations/get-started-end-to-end-sample/
- Azure Arc Jumpstart IoT Operations scenarios

## Findings

_Not yet investigated._

## Related

- Module 14 (AKS on Azure Local) — IoT Operations runs on AKS Arc
- Module 04 (Azure Arc — Infrastructure Deep Dive)
