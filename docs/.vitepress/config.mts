import { defineConfig } from 'vitepress'

export default defineConfig({
  ignoreDeadLinks: true,
  title: "Azure Local Training",
  description: "Governed centrally by HCS Platform Engineering standards",
  themeConfig: {
    logo: '/assets/images/azurelocal-training-icon.svg',
    nav: [{"link":"/","text":"Home"},{"items":[{"link":"/00-introduction/index","text":"00 — Introduction to Azure Local"},{"link":"/01-azure-arc/index","text":"01 — Azure Arc Deep Dive"},{"link":"/02-compute/index","text":"02 — Compute (Hyper-V + Clustering + Arc VMs)"},{"link":"/03-storage/index","text":"03 — Storage"},{"link":"/04-core-networking/index","text":"04 — Core Networking"},{"link":"/05-software-defined-networking/index","text":"05 — Software Defined Networking"}],"text":"Foundations"},{"items":[{"link":"/06-planning-sizing/index","text":"06 — Planning & Sizing"},{"link":"/07-deployment/index","text":"07 — Deployment"},{"link":"/08-post-deployment-configurations/index","text":"08 — Post-Deployment Configurations"}],"text":"Deployment"},{"items":[{"link":"/09-management/index","text":"09 — Management"},{"link":"/10-security-compliance/index","text":"10 — Security & Compliance"},{"link":"/11-observability-monitoring/index","text":"11 — Observability & Monitoring"},{"link":"/12-troubleshooting/index","text":"12 — Troubleshooting"},{"link":"/13-bcdr/index","text":"13 — BCDR (Business Continuity & DR)"},{"link":"/14-day-2-operations/index","text":"14 — Day-2 Operations & Lifecycle"}],"text":"Operations"},{"items":[{"link":"/15-aks/index","text":"15 — AKS on Azure Local"},{"link":"/16-avd/index","text":"16 — Azure Virtual Desktop"},{"link":"/17-iot-operations/index","text":"17 — IoT Operations"},{"link":"/18-ai-foundry-local/index","text":"18 — Azure AI Foundry Local"}],"text":"Workloads"},{"items":[{"link":"/19-migration/index","text":"19 — Migration"},{"link":"/20-scvmm/index","text":"20 — SCVMM (Optional)"}],"text":"Adoption"},{"items":{"link":"/labs/index","text":"Lab Environment Setup"},"text":"Labs"},{"link":"/presentations/index","text":"Presentations"}],
    sidebar: [{"link":"/","text":"Home"},{"text":"Foundations","items":[{"link":"/00-introduction/index","text":"00 — Introduction to Azure Local"},{"link":"/01-azure-arc/index","text":"01 — Azure Arc Deep Dive"},{"link":"/02-compute/index","text":"02 — Compute (Hyper-V + Clustering + Arc VMs)"},{"link":"/03-storage/index","text":"03 — Storage"},{"link":"/04-core-networking/index","text":"04 — Core Networking"},{"link":"/05-software-defined-networking/index","text":"05 — Software Defined Networking"}],"collapsed":false},{"text":"Deployment","items":[{"link":"/06-planning-sizing/index","text":"06 — Planning & Sizing"},{"link":"/07-deployment/index","text":"07 — Deployment"},{"link":"/08-post-deployment-configurations/index","text":"08 — Post-Deployment Configurations"}],"collapsed":false},{"text":"Operations","items":[{"link":"/09-management/index","text":"09 — Management"},{"link":"/10-security-compliance/index","text":"10 — Security & Compliance"},{"link":"/11-observability-monitoring/index","text":"11 — Observability & Monitoring"},{"link":"/12-troubleshooting/index","text":"12 — Troubleshooting"},{"link":"/13-bcdr/index","text":"13 — BCDR (Business Continuity & DR)"},{"link":"/14-day-2-operations/index","text":"14 — Day-2 Operations & Lifecycle"}],"collapsed":false},{"text":"Workloads","items":[{"link":"/15-aks/index","text":"15 — AKS on Azure Local"},{"link":"/16-avd/index","text":"16 — Azure Virtual Desktop"},{"link":"/17-iot-operations/index","text":"17 — IoT Operations"},{"link":"/18-ai-foundry-local/index","text":"18 — Azure AI Foundry Local"}],"collapsed":false},{"text":"Adoption","items":[{"link":"/19-migration/index","text":"19 — Migration"},{"link":"/20-scvmm/index","text":"20 — SCVMM (Optional)"}],"collapsed":false},{"text":"Labs","items":{"link":"/labs/index","text":"Lab Environment Setup"},"collapsed":false},{"link":"/presentations/index","text":"Presentations"}],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/AzureLocal/azurelocal-training' }
    ],
    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © Hybrid Cloud Solutions & AzureLocal'
    }
  }
})



