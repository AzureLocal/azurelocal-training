<#
.SYNOPSIS
Creates the ADO backlog (iterations, epics, features, user stories, tasks) for the
Azure Local Training curriculum buildout in the "Azure Local Training" project.

.DESCRIPTION
Idempotent-ish: skips creating iterations/work items whose titles already exist.

Requires the user environment loaded:
    . E:\git\platform\scripts\Load-HCSEnvironment.ps1
which sets AZURE_DEVOPS_EXT_PAT.
#>

[CmdletBinding()]
param(
    [string]$Org     = 'https://dev.azure.com/hybridcloudsolutions',
    [string]$Project = 'Azure Local Training',
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

if (-not $env:AZURE_DEVOPS_EXT_PAT) {
    Write-Error 'AZURE_DEVOPS_EXT_PAT not set. Run Load-HCSEnvironment.ps1 first.'
    return
}

Write-Host "ADO target: $Org / $Project" -ForegroundColor Cyan
if ($DryRun) { Write-Host "DRY-RUN — no items will be created." -ForegroundColor Yellow }

# ---------- ITERATIONS ----------
# 8 two-week sprints starting 2026-06-01.
$iterationStart = [datetime]'2026-06-01'
$iterations = 1..8 | ForEach-Object {
    $start = $iterationStart.AddDays(($_ - 1) * 14)
    $finish = $start.AddDays(13)
    @{ name = "Sprint $_"; start = $start.ToString('yyyy-MM-dd'); finish = $finish.ToString('yyyy-MM-dd') }
}

function Invoke-Ado {
    param([string[]]$AdoArgs)
    if ($DryRun) {
        Write-Host "DRY-RUN az $($AdoArgs -join ' ')" -ForegroundColor DarkGray
        return $null
    }
    $out = & az @AdoArgs --output json 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Command failed: az $($AdoArgs -join ' ')`n$out"
        return $null
    }
    if (-not $out) { return $null }
    $text = ($out | Out-String).Trim()
    if (-not ($text.StartsWith('{') -or $text.StartsWith('['))) {
        # Non-JSON (probably a warning) — log and return null
        Write-Host "  (non-JSON output: $($text.Substring(0,[Math]::Min(100,$text.Length))))" -ForegroundColor DarkGray
        return $null
    }
    try { return ($text | ConvertFrom-Json) } catch { Write-Warning "JSON parse failed: $_"; return $null }
}

Write-Host "`n=== Creating iterations ===" -ForegroundColor Green
$iterRootPath = "\$Project\Iteration"
foreach ($i in $iterations) {
    $argsList = @(
        'boards','iteration','project','create',
        '--org', $Org,
        '--project', $Project,
        '--name', $i.name,
        '--path', $iterRootPath,
        '--start-date', $i.start,
        '--finish-date', $i.finish
    )
    Invoke-Ado -AdoArgs $argsList | Out-Null
    Write-Host "  + $($i.name)  $($i.start) → $($i.finish)"
}

# ---------- WORK ITEM HELPERS ----------
function New-WorkItem {
    param(
        [string]$Type,
        [string]$Title,
        [string]$Description,
        [int]$ParentId,
        [string]$Iteration  # e.g., 'Azure Local Training\Sprint 1' — optional
    )
    $argsList = @(
        'boards','work-item','create',
        '--org', $Org,
        '--project', $Project,
        '--type', $Type,
        '--title', $Title
    )
    if ($Description) { $argsList += @('--description', $Description) }
    if ($Iteration) { $argsList += @('--iteration', $Iteration) }

    $wi = Invoke-Ado -AdoArgs $argsList
    if ($null -eq $wi) { return $null }

    if ($ParentId) {
        $linkArgs = @(
            'boards','work-item','relation','add',
            '--org', $Org,
            '--id', $wi.id,
            '--relation-type', 'parent',
            '--target-id', $ParentId
        )
        Invoke-Ado -AdoArgs $linkArgs | Out-Null
    }
    Write-Host ("    [{0,6}] {1,-12} {2}" -f $wi.id, $Type, $Title)
    return $wi
}

# Track created IDs
$ids = @{}

# ---------- EPIC / FEATURE / STORY / TASK GRAPH ----------
# Schema: epics is an array of @{ key, title, desc, iter, features = @( @{ key, title, desc, iter, stories = @( @{ key, title, desc, iter, tasks = @( @{ title, desc } ) } ) } ) }

$backlog = @(
    @{
        key = 'E1'; title = 'Platform Foundation Hardening'
        desc = 'Phase 0 hardening — HTTPS enforcement, Git LFS, branch protection required checks, CI secrets wiring.'
        iter = 'Sprint 1'
        features = @(
            @{ key='F1.1'; title='HTTPS Enforcement and Branch Protection'; iter='Sprint 1'; stories = @(
                @{ title='Enable HTTPS enforcement on GitHub Pages'; iter='Sprint 1'; tasks=@(
                    @{ title='PUT /repos/.../pages with https_enforced=true' },
                    @{ title='Verify TLS certificate is issued and not pending' },
                    @{ title='Smoke-test https://training.azurelocal.cloud/' }
                )},
                @{ title='Add required status checks to main branch protection'; iter='Sprint 1'; tasks=@(
                    @{ title='Add validate-labs as required check' },
                    @{ title='Add content-lint as required check' },
                    @{ title='Add mkdocs-strict-build as required check' },
                    @{ title='Verify a test PR is blocked when any check fails' }
                )}
            )},
            @{ key='F1.2'; title='Git LFS Binary Asset Pipeline'; iter='Sprint 1'; stories = @(
                @{ title='Verify Git LFS is wired and a .pptx commits as LFS pointer'; iter='Sprint 1'; tasks=@(
                    @{ title='Run git lfs install on dev machine' },
                    @{ title='Commit a placeholder .pptx and confirm LFS pointer' },
                    @{ title='Verify CI clones .pptx via LFS without bloat' }
                )}
            )},
            @{ key='F1.3'; title='CI Secrets and Service Principals'; iter='Sprint 2'; stories = @(
                @{ title='Wire Azure SP secrets for iac-cleanup workflow'; iter='Sprint 2'; tasks=@(
                    @{ title='Create dedicated Azure SP scoped to workshop subscription' },
                    @{ title='Add AZURE_CLIENT_ID / AZURE_TENANT_ID / AZURE_SUBSCRIPTION_ID secrets' },
                    @{ title='Run iac-cleanup workflow_dispatch dry-run to verify auth' }
                )},
                @{ title='Wire Vercel token for AI tutor deploy'; iter='Sprint 7'; tasks=@(
                    @{ title='Create Vercel project for the AI tutor app' },
                    @{ title='Add VERCEL_TOKEN, VERCEL_ORG_ID, VERCEL_PROJECT_ID secrets' },
                    @{ title='Add ANTHROPIC_API_KEY production secret' }
                )}
            )}
        )
    },
    @{
        key='E2'; title='Curriculum Content Build-Out'
        desc='Write all module content — lab guides, sub-page detail, presenter notes — for all 20 modules.'
        iter='Sprint 1'
        features = @(
            @{ key='F2.1'; title='Foundations Track Content (Modules 00-04)'; iter='Sprint 1'; stories = @(
                @{ title='Module 00 — Introduction content'; iter='Sprint 1'; tasks=@(@{title='Write sub-page detail (what-is-azure-local, vs-windows-server, use-cases)'},@{title='Write presenter-notes.md'},@{title='Review with content-reviewer agent'})},
                @{ title='Module 01 — Planning and Sizing content'; iter='Sprint 1'; tasks=@(@{title='Write planning/sizing sub-pages'},@{title='Write presenter-notes.md'},@{title='Add design exercise scenario'})},
                @{ title='Module 02 — Deployment lab + content'; iter='Sprint 2'; tasks=@(@{title='Write lab guide for cluster deployment via Portal'},@{title='Write sub-pages (architecture, prereqs, registration)'},@{title='Write presenter-notes.md'})},
                @{ title='Module 03 — Management content'; iter='Sprint 2'; tasks=@(@{title='Write Portal/CLI/WAC/OMSWAC sub-pages'},@{title='Write lab guide (Portal tour + OMSWAC)'},@{title='Write presenter-notes.md'})},
                @{ title='Module 04 — Azure Arc Deep Dive content'; iter='Sprint 2'; tasks=@(@{title='Write Arc Resource Bridge sub-page'},@{title='Write agents and extensions sub-page'},@{title='Write demo script (no full lab)'})}
            )},
            @{ key='F2.2'; title='Infrastructure Track Content (Modules 05-08)'; iter='Sprint 3'; stories = @(
                @{ title='Module 05 — Compute content'; iter='Sprint 3'; tasks=@(@{title='Write Hyper-V + Failover Clustering sub-pages'},@{title='Write Arc VM sub-pages (Portal + Bicep)'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})},
                @{ title='Module 06 — Storage content'; iter='Sprint 3'; tasks=@(@{title='Write S2D sub-pages (architecture, disk types, ReFS)'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})},
                @{ title='Module 07 — Core Networking content'; iter='Sprint 3'; tasks=@(@{title='Write Network ATC sub-page'},@{title='Write RDMA / SR-IOV / SMB sub-page'},@{title='Write logical networks sub-page'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})},
                @{ title='Module 08 — Software Defined Networking content'; iter='Sprint 3'; tasks=@(@{title='Write Arc-managed SDN sub-pages'},@{title='Write SLB + gateway sub-page'},@{title='Write microsegmentation sub-page'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})}
            )},
            @{ key='F2.3'; title='Operations Track Content (Modules 09-13)'; iter='Sprint 4'; stories = @(
                @{ title='Module 09 — Security and Compliance content'; iter='Sprint 4'; tasks=@(@{title='Write Secured-core / BitLocker / Credential Guard sub-pages'},@{title='Write SMI + drift + WDAC sub-page'},@{title='Write Azure Policy + Defender sub-page'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})},
                @{ title='Module 10 — Observability content'; iter='Sprint 4'; tasks=@(@{title='Write Azure Monitor sub-page'},@{title='Write Monitor Insights + HCI Insights sub-page'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})},
                @{ title='Module 11 — Troubleshooting content'; iter='Sprint 4'; tasks=@(@{title='Write per-discipline troubleshooting sub-pages'},@{title='Write guided break-fix scenarios'},@{title='Write presenter-notes.md'})},
                @{ title='Module 12 — BCDR content'; iter='Sprint 4'; tasks=@(@{title='Write ASR sub-page'},@{title='Write Azure Backup sub-page'},@{title='Write DR planning + RTO/RPO sub-page'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})},
                @{ title='Module 13 — Day-2 Operations content'; iter='Sprint 4'; tasks=@(@{title='Write Azure Update Manager sub-page'},@{title='Write LCM updates + upgrades sub-page'},@{title='Write capacity expansion sub-page'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})}
            )},
            @{ key='F2.4'; title='Workloads Track Content (Modules 14-17)'; iter='Sprint 5'; stories = @(
                @{ title='Module 14 — AKS on Azure Local content'; iter='Sprint 5'; tasks=@(@{title='Write AKS Arc architecture sub-page'},@{title='Write deploy + node-pool sub-pages'},@{title='Write workload management sub-page'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})},
                @{ title='Module 15 — Azure Virtual Desktop content'; iter='Sprint 5'; tasks=@(@{title='Write AVD architecture sub-page'},@{title='Write host pool + session host sub-pages'},@{title='Write FSLogix + autoscale sub-page'},@{title='Write lab guide'},@{title='Write presenter-notes.md'})},
                @{ title='Module 16 — IoT Operations content'; iter='Sprint 5'; tasks=@(@{title='Write IoT Operations architecture sub-page from research'},@{title='Write MQTT broker + dataflows sub-page'},@{title='Write OPC UA lab guide'},@{title='Write presenter-notes.md'})},
                @{ title='Module 17 — Azure AI Foundry Local content'; iter='Sprint 5'; tasks=@(@{title='Write Foundry Local architecture sub-page from research'},@{title='Write GPU planning sub-page (DDA-only on AKS Arc)'},@{title='Write Phi-4-mini sovereign chat lab guide'},@{title='Write presenter-notes.md'})}
            )},
            @{ key='F2.5'; title='Adoption Track Content (Modules 18-19)'; iter='Sprint 6'; stories = @(
                @{ title='Module 18 — Migration content'; iter='Sprint 6'; tasks=@(@{title='Write VMware migration sub-page'},@{title='Write Hyper-V migration sub-page'},@{title='Write Azure Migrate integration sub-page'},@{title='Write lab/demo script'},@{title='Write presenter-notes.md'})},
                @{ title='Module 19 — SCVMM placeholder content'; iter='Sprint 6'; tasks=@(@{title='Write SCVMM coexistence sub-page'},@{title='Note this is a placeholder until customer demand'})}
            )},
            @{ key='F2.6'; title='Consolidated Delivery Guide'; iter='Sprint 6'; stories = @(
                @{ title='Write docs/delivery-guide.md covering all delivery programs'; iter='Sprint 6'; tasks=@(@{title='Outline all delivery programs'},@{title='Cross-link to per-module presenter-notes'},@{title='Review with training-pm agent'})}
            )}
        )
    },
    @{
        key='E3'; title='Lab Environment Platform'
        desc='Build the Bicep / Terraform lab building solutions we own — shared base + per-module templates. Supports student-deployed and moderator-deployed delivery patterns.'
        iter='Sprint 1'
        features = @(
            @{ key='F3.1'; title='Shared Base Lab Environment'; iter='Sprint 2'; stories = @(
                @{ title='Author labs/iac/shared/lab-environment.bicep'; iter='Sprint 2'; tasks=@(@{title='Define parameters (region, vmSku, participantCount, moduleSelector, ttlHours)'},@{title='Provision nested-virt base VM(s) with Hyper-V'},@{title='Output endpoints + credentials'},@{title='az bicep build verification'})},
                @{ title='Author shared cleanup.ps1 + README'; iter='Sprint 2'; tasks=@(@{title='Write cleanup.ps1'},@{title='Write README with student + moderator usage'})}
            )},
            @{ key='F3.2'; title='Per-Module IaC Templates'; iter='Sprint 3'; stories = @(
                @{ title='Module 02 Deployment IaC'; iter='Sprint 2'; tasks=@(@{title='Author main.bicep'},@{title='Author parameters.json'},@{title='Author cleanup.ps1'},@{title='Update README'},@{title='Verify az bicep build'})},
                @{ title='Module 05 Compute IaC'; iter='Sprint 3'; tasks=@(@{title='Author main.bicep'},@{title='Verify az bicep build'},@{title='Update README'})},
                @{ title='Module 06 Storage IaC'; iter='Sprint 3'; tasks=@(@{title='Author main.bicep'},@{title='Verify az bicep build'},@{title='Update README'})},
                @{ title='Module 07 Core Networking IaC'; iter='Sprint 3'; tasks=@(@{title='Author main.bicep'},@{title='Verify az bicep build'},@{title='Update README'})},
                @{ title='Module 08 SDN IaC'; iter='Sprint 3'; tasks=@(@{title='Author main.bicep'},@{title='Verify az bicep build'},@{title='Update README'})},
                @{ title='Module 09 Security IaC + Policy definitions'; iter='Sprint 4'; tasks=@(@{title='Author main.bicep'},@{title='Author Azure Policy initiative'},@{title='Verify az bicep build'},@{title='Update README'})},
                @{ title='Module 10 Observability IaC'; iter='Sprint 4'; tasks=@(@{title='Author main.bicep (Log Analytics, Monitor, dashboards)'},@{title='Verify az bicep build'},@{title='Update README'})},
                @{ title='Module 12 BCDR IaC'; iter='Sprint 4'; tasks=@(@{title='Author main.bicep (Recovery Services vault, ASR, Backup)'},@{title='Verify az bicep build'},@{title='Update README'})},
                @{ title='Module 14 AKS IaC (Bicep + Terraform)'; iter='Sprint 5'; tasks=@(@{title='Author Bicep main.bicep'},@{title='Author Terraform equivalent'},@{title='Verify build/validate'},@{title='Update README'})},
                @{ title='Module 15 AVD IaC'; iter='Sprint 5'; tasks=@(@{title='Author main.bicep (host pool, session host, FSLogix storage)'},@{title='Verify az bicep build'},@{title='Update README'})},
                @{ title='Module 16 IoT Operations IaC'; iter='Sprint 5'; tasks=@(@{title='Author main.bicep (Storage, Key Vault, Event Hubs, AKS Arc prereqs)'},@{title='Reference az iot ops init + create'},@{title='Update README'})},
                @{ title='Module 17 AI Foundry Local IaC'; iter='Sprint 5'; tasks=@(@{title='Author main.bicep (Arc K8s extension, NGINX ingress)'},@{title='Document GPU SKU constraints (L4/L40S)'},@{title='Update README'})}
            )},
            @{ key='F3.3'; title='Moderator Batch Provisioning Workflow'; iter='Sprint 6'; stories = @(
                @{ title='Write a moderator workflow doc for in-person workshops'; iter='Sprint 6'; tasks=@(@{title='Document batch deployment with participantCount'},@{title='Document credential distribution pattern'},@{title='Document cleanup workflow'})}
            )}
        )
    },
    @{
        key='E4'; title='Slide Decks and Narration'
        desc='Slide outlines, narration scripts, PowerPoint builds, and the export pipeline for all 20 modules.'
        iter='Sprint 3'
        features = @(
            @{ key='F4.1'; title='Slide Outlines and Narration Scripts'; iter='Sprint 3'; stories = @(
                @{ title='Slides for Modules 00-04 (Foundations)'; iter='Sprint 3'; tasks=@(@{title='Outline + narration for Module 00'},@{title='Outline + narration for Module 01'},@{title='Outline + narration for Module 02'},@{title='Outline + narration for Module 03'},@{title='Outline + narration for Module 04'})},
                @{ title='Slides for Modules 05-08 (Infrastructure)'; iter='Sprint 4'; tasks=@(@{title='Outline + narration for Module 05'},@{title='Outline + narration for Module 06'},@{title='Outline + narration for Module 07'},@{title='Outline + narration for Module 08'})},
                @{ title='Slides for Modules 09-13 (Operations)'; iter='Sprint 5'; tasks=@(@{title='Outline + narration for Module 09'},@{title='Outline + narration for Module 10'},@{title='Outline + narration for Module 11'},@{title='Outline + narration for Module 12'},@{title='Outline + narration for Module 13'})},
                @{ title='Slides for Modules 14-17 (Workloads)'; iter='Sprint 6'; tasks=@(@{title='Outline + narration for Module 14'},@{title='Outline + narration for Module 15'},@{title='Outline + narration for Module 16'},@{title='Outline + narration for Module 17'})},
                @{ title='Slides for Modules 18-19 (Adoption)'; iter='Sprint 6'; tasks=@(@{title='Outline + narration for Module 18'},@{title='Outline + narration for Module 19'})}
            )},
            @{ key='F4.2'; title='PowerPoint Deck Builds'; iter='Sprint 6'; stories = @(
                @{ title='Build .pptx from each module outline'; iter='Sprint 6'; tasks=@(@{title='Use Copilot in PowerPoint to convert outlines'},@{title='Apply Azure Local brand template'},@{title='Commit .pptx via Git LFS'})}
            )},
            @{ key='F4.3'; title='Slide Export Pipeline Verification'; iter='Sprint 6'; stories = @(
                @{ title='Verify slide-export workflow produces PDF + PNG'; iter='Sprint 6'; tasks=@(@{title='Trigger slide-export workflow_dispatch'},@{title='Verify exports committed to slides/<module>/'},@{title='Confirm Pages site can preview PDFs'})}
            )}
        )
    },
    @{
        key='E5'; title='AI Tutor Application'
        desc='Next.js + Claude API application that delivers the interactive AI-led learning experience at app.training.azurelocal.cloud.'
        iter='Sprint 2'
        features = @(
            @{ key='F5.1'; title='Anthropic SDK and Patterns Research'; iter='Sprint 2'; stories = @(
                @{ title='Complete Research Task 1 — Anthropic GitHub findings'; iter='Sprint 2'; tasks=@(@{title='Review github.com/anthropics official repos'},@{title='Document SDK pinning + prompt cache pattern'},@{title='Identify useful MCP servers'},@{title='Update research/anthropic-github-findings.md'})}
            )},
            @{ key='F5.2'; title='Next.js Chat UI + Streaming'; iter='Sprint 2'; stories = @(
                @{ title='Build chat UI component'; iter='Sprint 2'; tasks=@(@{title='ChatUI.tsx with message stream'},@{title='User input + submit'},@{title='Rendering of markdown responses'},@{title='Disclaimer + rate-limit messaging'})},
                @{ title='Wire streaming Claude responses'; iter='Sprint 2'; tasks=@(@{title='Streaming via API route'},@{title='Cancel/regenerate controls'},@{title='Error handling + retry'})}
            )},
            @{ key='F5.3'; title='Module Content Loader and System Prompts'; iter='Sprint 5'; stories = @(
                @{ title='Build moduleContent.ts loader'; iter='Sprint 5'; tasks=@(@{title='Read docs/<module>/ markdown and frontmatter'},@{title='Compose ModuleContext object'},@{title='Use prompts.ts to build system prompt per tutor mode'})},
                @{ title='Implement prompt caching'; iter='Sprint 5'; tasks=@(@{title='Use Anthropic cache_control breakpoint on large system prompts'},@{title='Measure token reuse with metrics dashboard'},@{title='Set per-IP rate limit'})}
            )},
            @{ key='F5.4'; title='AI Tutor Deployment'; iter='Sprint 7'; stories = @(
                @{ title='Deploy AI tutor to app.training.azurelocal.cloud'; iter='Sprint 7'; tasks=@(@{title='Add CNAME for app subdomain via Cloudflare API'},@{title='Create Vercel project + set env vars'},@{title='Run ai-tutor-deploy workflow'},@{title='Smoke-test prod URL'})}
            )},
            @{ key='F5.5'; title='Per-Module AI Tutor Sessions'; iter='Sprint 7'; stories = @(
                @{ title='Wire Module 00 tutor session (POC)'; iter='Sprint 7'; tasks=@(@{title='Compose system prompt from Module 00 content'},@{title='Hand-test all four modes (teaching, lab, qa, assessment)'},@{title='Capture transcripts for review'})},
                @{ title='Wire AI tutor sessions for Modules 01-19'; iter='Sprint 8'; tasks=@(@{title='Build batched module load script'},@{title='Validate token-cache reuse across modules'},@{title='Review with content-reviewer agent'})}
            )}
        )
    },
    @{
        key='E6'; title='AI Video Production'
        desc='Pick a tool, produce a Module 00 video POC, then scale to all 20 modules. YouTube hosting.'
        iter='Sprint 7'
        features = @(
            @{ key='F6.1'; title='AI Video Tool Decision'; iter='Sprint 7'; stories = @(
                @{ title='Complete Research Task 2 — AI video tool decision'; iter='Sprint 7'; tasks=@(@{title='Evaluate Copilot in PowerPoint'},@{title='Evaluate Synthesia / HeyGen'},@{title='Evaluate Descript for screen-cap labs'},@{title='Update research/ai-video-tools.md with recommendation'})}
            )},
            @{ key='F6.2'; title='Module 00 Video POC'; iter='Sprint 7'; stories = @(
                @{ title='Produce Module 00 video via chosen tool'; iter='Sprint 7'; tasks=@(@{title='Generate video from Module 00 narration'},@{title='Upload to YouTube as unlisted'},@{title='Capture link in videos/00-introduction/links.md'})}
            )},
            @{ key='F6.3'; title='All-Module Video Generation'; iter='Sprint 8'; stories = @(
                @{ title='Generate videos for Modules 01-19'; iter='Sprint 8'; tasks=@(@{title='Batch produce videos'},@{title='Upload to YouTube'},@{title='Add chapter markers per video'},@{title='Update videos/<module>/links.md per module'})}
            )},
            @{ key='F6.4'; title='YouTube Hosting and Metadata'; iter='Sprint 8'; stories = @(
                @{ title='Standardize YouTube descriptions and tags'; iter='Sprint 8'; tasks=@(@{title='Author description template'},@{title='Apply to every video'},@{title='Make videos public for launch'})}
            )}
        )
    },
    @{
        key='E7'; title='Legacy Content Migration'
        desc='Migrate the legacy Azure Stack HCI workshop content from referrence/ into the new docs/, slides/, and labs/iac/ structures. Per Sections 3.4 and 3.6 of the plan.'
        iter='Sprint 6'
        features = @(
            @{ key='F7.1'; title='KEEP/EDIT/ADD/DROP Migration'; iter='Sprint 6'; stories = @(
                @{ title='Execute Section 3.4 migration matrix'; iter='Sprint 6'; tasks=@(@{title='Migrate Storage Spaces Direct content'},@{title='Migrate Core Networking content'},@{title='Migrate Hyper-V / clustering content into Compute'},@{title='Migrate Security baseline content'},@{title='Migrate Troubleshooting content'},@{title='Migrate Hybrid (Arc/ASR/Backup/Monitor) per new module split'},@{title='Confirm dropped topics (WAC primary, SCVMM primary, File Sync, legacy SDN deep-dive)'})}
            )},
            @{ key='F7.2'; title='Legacy PowerPoint Migration'; iter='Sprint 6'; stories = @(
                @{ title='Move legacy PowerPoint decks into slides/ as source material'; iter='Sprint 6'; tasks=@(@{title='Stage referrence/PowerPoint/* into slides/<module>/legacy/'},@{title='Track Git LFS for the legacy .pptx files'},@{title='Update presentations/index.md status'})}
            )},
            @{ key='F7.3'; title='Legacy Delivery Guides Migration'; iter='Sprint 6'; stories = @(
                @{ title='Migrate Delivery Guide markdown into presenter-notes.md'; iter='Sprint 6'; tasks=@(@{title='Map old guide → new module'},@{title='Rewrite for Azure Local terminology'},@{title='Drop Chalk-and-Talk and obsolete sections'})}
            )},
            @{ key='F7.4'; title='Datasheet Rebrand'; iter='Sprint 8'; stories = @(
                @{ title='Rebrand 3 referrence/Datasheet/*.pdf as Azure Local datasheets'; iter='Sprint 8'; tasks=@(@{title='Rebrand Full Deployment datasheet'},@{title='Rebrand With AKS datasheet'},@{title='Rebrand With SDN datasheet → Arc-managed SDN'},@{title='Publish under docs/assets/datasheets/'})}
            )}
        )
    },
    @{
        key='E8'; title='Marketing, Delivery Programs and Launch'
        desc='Marketing landing page, per-program detailed agendas, datasheets per program, registration, and launch.'
        iter='Sprint 8'
        features = @(
            @{ key='F8.1'; title='Strategic Decisions Resolution'; iter='Sprint 2'; stories = @(
                @{ title='Resolve open questions Q2-Q6'; iter='Sprint 2'; tasks=@(@{title='Decide Q2 — AI tutor domain pattern'},@{title='Decide Q3 — AI video tool primary'},@{title='Decide Q4 — lab hosting (self vs partner)'},@{title='Decide Q5 — pricing model'},@{title='Decide Q6 — AI tutor auth model'})}
            )},
            @{ key='F8.2'; title='Marketing Landing Page'; iter='Sprint 8'; stories = @(
                @{ title='Rewrite docs/index.md as a marketing landing per Section 10.3'; iter='Sprint 8'; tasks=@(@{title='Hero + value prop + CTA button'},@{title='Who should attend (audience cards)'},@{title='What you will learn (key outcomes)'},@{title='Delivery formats matrix'},@{title='Prerequisites'},@{title='Testimonials / social proof slot'},@{title='Registration / contact CTA'})}
            )},
            @{ key='F8.3'; title='Per-Program Agendas'; iter='Sprint 8'; stories = @(
                @{ title='Foundations program agenda'; iter='Sprint 8'; tasks=@(@{title='Map modules to days/sessions'},@{title='Publish docs/programs/foundations.md'})},
                @{ title='Foundations + Workloads program agenda'; iter='Sprint 8'; tasks=@(@{title='Map modules'},@{title='Publish docs/programs/foundations-workloads.md'})},
                @{ title='Full Stack program agenda'; iter='Sprint 8'; tasks=@(@{title='Map modules'},@{title='Publish docs/programs/full-stack.md'})},
                @{ title='Operations Focus program agenda'; iter='Sprint 8'; tasks=@(@{title='Map modules'},@{title='Publish docs/programs/operations-focus.md'})},
                @{ title='Migration Track program agenda'; iter='Sprint 8'; tasks=@(@{title='Map modules'},@{title='Publish docs/programs/migration-track.md'})},
                @{ title='Alternate Tracks A-E agendas'; iter='Sprint 8'; tasks=@(@{title='Document tracks A-E as audience-specific bundles'},@{title='Publish docs/programs/tracks-alternate.md'})}
            )},
            @{ key='F8.4'; title='Per-Program Datasheets'; iter='Sprint 8'; stories = @(
                @{ title='Author one datasheet per delivery program'; iter='Sprint 8'; tasks=@(@{title='Foundations datasheet'},@{title='Foundations + Workloads datasheet'},@{title='Full Stack datasheet'},@{title='Operations Focus datasheet'},@{title='Migration Track datasheet'})}
            )},
            @{ key='F8.5'; title='Registration Platform Integration'; iter='Sprint 8'; stories = @(
                @{ title='Pick and integrate registration platform'; iter='Sprint 8'; tasks=@(@{title='Evaluate Eventbrite vs TicketTailor vs custom'},@{title='Set up event listings'},@{title='Embed registration CTA on landing page'})}
            )},
            @{ key='F8.6'; title='CONTRIBUTING and Community'; iter='Sprint 1'; stories = @(
                @{ title='Create CONTRIBUTING.md at repo root'; iter='Sprint 1'; tasks=@(@{title='Author CONTRIBUTING.md'},@{title='Link from docs/index.md'},@{title='Add issue templates'})}
            )}
        )
    }
)

# ---------- CREATE WORK ITEMS ----------
Write-Host "`n=== Creating epics / features / stories / tasks ===" -ForegroundColor Green

foreach ($epic in $backlog) {
    $epicWi = New-WorkItem -Type 'Epic' -Title $epic.title -Description $epic.desc -Iteration "$Project\$($epic.iter)"
    if ($null -eq $epicWi) { continue }
    $ids[$epic.key] = $epicWi.id

    foreach ($feat in $epic.features) {
        $featWi = New-WorkItem -Type 'Feature' -Title $feat.title -Description "" -ParentId $epicWi.id -Iteration "$Project\$($feat.iter)"
        if ($null -eq $featWi) { continue }
        $ids[$feat.key] = $featWi.id

        foreach ($story in $feat.stories) {
            $storyWi = New-WorkItem -Type 'User Story' -Title $story.title -Description "" -ParentId $featWi.id -Iteration "$Project\$($story.iter)"
            if ($null -eq $storyWi) { continue }

            foreach ($task in $story.tasks) {
                New-WorkItem -Type 'Task' -Title $task.title -Description "" -ParentId $storyWi.id -Iteration "$Project\$($story.iter)" | Out-Null
            }
        }
    }
}

Write-Host "`n=== Done ===" -ForegroundColor Green
Write-Host "Created root work-item IDs:" -ForegroundColor Cyan
$ids.GetEnumerator() | Sort-Object Name | ForEach-Object { '  {0,-6} = {1}' -f $_.Key, $_.Value }
