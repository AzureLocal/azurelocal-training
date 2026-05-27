# Research: Azure AI Foundry Local

**Status:** Complete (initial)
**Assigned:** @kristopherjturner
**Added:** 2026-05-27
**Updated:** 2026-05-27
**Module:** 17 — Azure AI Foundry Local

Sources: Microsoft Learn (azure-sovereign-clouds/private/foundry-local, azure-local/manage/gpu-*), [microsoft/Foundry-Local](https://github.com/microsoft/Foundry-Local).

---

## 1. What it is — TWO DISTINCT PRODUCTS

There are **two distinct products with the same brand**, and the training needs to lead with that:

- **Foundry Local (on-device)** — embedded ONNX runtime + SDK (C#, Python, JS, Rust) that ships inside an application and runs on a single user's Windows/macOS device. Not relevant to Azure Local operators except as background.
- **Foundry Local on Azure Local** (a.k.a. "Foundry Local enabled by Azure Arc") — a Kubernetes-native inference platform delivered as an **Azure Arc extension** on an Arc-enabled Kubernetes cluster running on Azure Local. **This is the Module 17 target.** Currently **preview, by request only** via https://aka.ms/FoundryLocalAzure_PreviewRequest.

Difference from cloud Azure AI Foundry: cloud Foundry is a managed multi-tenant model hosting/agent platform. Foundry Local on Azure Local runs inference on your own AzL cluster, data stays on-prem, lifecycle is managed through K8s CRDs (`Model`, `ModelDeployment`) and an inference operator.

## 2. Deployment model

**Arc extension on an Arc-enabled Kubernetes cluster** (Helm install also supported). Requires:

- Kubernetes 1.29+ connected to Arc
- App registration for auth
- kubectl + Helm
- NGINX ingress for external endpoints (use AKS managed NGINX — Ingress-NGINX is deprecated as of March 2026)
- Arc-enabled K8s cluster in a supported region (Central US, East US, West US, West Europe, North Europe, etc.)

Control plane = "Kubernetes inference operator" (watches CRDs and reconciles model lifecycle). Sits **on top of AKS Arc or another Arc-connected K8s on AzL**.

## 3. Models

- **Runtimes:** ONNX-GenAI (CPU or GPU) and vLLM (GPU only, higher throughput)
- **Catalog families:** Phi (Phi-3.5-mini-instruct, Phi-4-mini-instruct), Qwen, DeepSeek, Mistral (Mistral-7B-Instruct-v0.2), GPT-OSS (gpt-oss-20b), Whisper for audio
- **BYO model** supported (tar.gz, registry URL — no raw IPs; SSRF protection rejects them)

**Smallest practical lab model:** **Phi-4-mini-instruct** on vLLM — ~7.8 GB GPU memory on an A10, 93k context. For CPU-only labs, use ONNX-GenAI with Phi-3.5-mini or Phi-4-mini.

## 4. GPU requirements — IMPORTANT GOTCHA

**vLLM minimum:** NVIDIA Volta (CC 7.0); **recommended** Ampere (CC 8.0) or higher.

**Azure Local GPU story** (flag for operators):

- AzL supports **DDA** (whole GPU to a VM) and **GPU-P** (partitioned, SR-IOV-based)
- **AKS Arc does NOT support GPU partitions** — only DDA. Confirmed at [gpu-preparation docs](https://learn.microsoft.com/azure/azure-local/manage/gpu-preparation?view=azloc-2604)
- Supported NVIDIA SKUs for AKS-on-AzL (DDA): T4, A2, A16, L4, L40, L40S, RTX Pro 6000
- **A10 and A40 are NOT supported for AKS DDA** despite being vLLM's benchmark SKU — major gotcha
- Practical AzL hardware for Foundry Local: **NVIDIA L4 or L40S via DDA on an AKS-Arc node**. Driver = NVIDIA GPU Operator inside K8s

## 5. Persona line

**Infra operator owns**: cluster sizing, Arc onboarding, GPU node pool + NVIDIA GPU Operator install, ingress/TLS/cert lifecycle, Arc extension install, namespace/RBAC, Entra ID app registration, API key issuance, monitoring K8s/GPU metrics.

**AI/ML practitioner owns**: model selection from catalog, `ModelDeployment` parameters, prompt engineering, RAG indexing, app-side OpenAI SDK integration.

For Module 17 (AzL infra ops audience): focus on the infra operator scope.

## 6. Identity, networking, security

- **Auth**: API keys (bearer token) or **Microsoft Entra ID** validated by an identity sidecar
- **Network**: NGINX ingress + TLS. Endpoints are `/v1/chat/completions` and `/v1/predict` — OpenAI-compatible
- **Sovereignty/residency**: prompts, RAG corpus, outputs never leave the cluster. The Arc connection carries control plane metadata and catalog sync only — not inference data
- **BYO model SSRF protection** rejects raw IPs / localhost in registry URLs

## 7. Lab scenario

**Sovereign internal chat assistant** — install the extension, deploy Phi-4-mini, hit the OpenAI-compatible endpoint from a notebook, demonstrate data never leaves the cluster. RAG is too much for 45 min — defer to advanced follow-up lab.

## 8. 45-minute learner flow

1. (5 min) Verify prereqs: Arc-enabled K8s, GPU node with NVIDIA GPU Operator, kubectl context
2. (5 min) Create Entra app registration + assign API permissions; capture client ID / tenant ID
3. (10 min) `az k8s-extension create` to install Foundry Local Arc extension; install NGINX ingress; apply TLS cert
4. (10 min) Sync catalog; apply `Model` and `ModelDeployment` CRDs for `phi-4-mini-instruct`; watch operator reconcile
5. (10 min) Call `/v1/chat/completions` from a Python notebook with the OpenAI SDK pointed at the ingress endpoint; show API-key auth then Entra token
6. (5 min) Tear-down + show operator/model logs; discuss sovereignty proof (no egress to `*.openai.azure.com` during inference)

## Key URLs

- [What is Foundry Local on Azure Local](https://learn.microsoft.com/azure/azure-sovereign-clouds/private/foundry-local/what-is-foundry-local-on-azure-local)
- [Deploy Foundry Local Arc extension](https://learn.microsoft.com/azure/azure-sovereign-clouds/private/foundry-local/deploy-foundry-local-arc-extension)
- [Reference models](https://learn.microsoft.com/azure/azure-sovereign-clouds/private/foundry-local/reference-models)
- [Bring your own models](https://learn.microsoft.com/azure/azure-sovereign-clouds/private/foundry-local/concept-bring-your-own-models)
- [AI workloads on Azure Local overview](https://learn.microsoft.com/azure/azure-sovereign-clouds/private/azure-local/ai-workloads-overview)
- [Azure Local GPU preparation](https://learn.microsoft.com/azure/azure-local/manage/gpu-preparation?view=azloc-2604)
- [Preview access request](https://aka.ms/FoundryLocalAzure_PreviewRequest)

## Doc/reality flags

1. **Name collision** — "Foundry Local" means two different products; learners googling will land on the device SDK docs
2. **GPU SKU mismatch** — vLLM benchmarks use A10, but AKS-on-AzL doesn't support A10 via DDA. Steer learners to L4/L40S
3. **AKS Arc has no GPU partitioning** — AzL supports GPU-P for VMs, but the K8s path Foundry Local rides on is DDA-only
4. **Preview gate** — request-gated deployment. Module needs an "obtain preview access" prereq step weeks ahead
5. **Ingress-NGINX deprecation** — use AKS managed NGINX ingress controller

## Related

- Module 14 (AKS on Azure Local) — Foundry Local runs on AKS Arc
- Module 04 (Azure Arc — Infrastructure Deep Dive)
- Module 09 (Security & Compliance) — sovereign AI compliance angle
