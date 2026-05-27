#!/usr/bin/env pwsh
# PostToolUse / Agent — log agent spawns and results to operate.jsonl

$input = $env:CLAUDE_TOOL_INPUT
$output = $env:CLAUDE_TOOL_OUTPUT
$logFile = 'E:/git/azurelocal/azurelocal-training/.claude/logs/operate.jsonl'

$toolInput = $null
$toolOutput = $null

try { $toolInput = $input | ConvertFrom-Json -ErrorAction Stop } catch {}
try { $toolOutput = $output | ConvertFrom-Json -ErrorAction Stop } catch { $toolOutput = @{ raw = $output } }

$entry = @{
    timestamp    = (Get-Date -Format 'o')
    agent        = $toolInput.subagent_type
    description  = $toolInput.description
    prompt_chars = if ($toolInput.prompt) { $toolInput.prompt.Length } else { 0 }
    result_chars = if ($output) { $output.Length } else { 0 }
} | ConvertTo-Json -Compress

Add-Content -Path $logFile -Value $entry -Encoding UTF8 -ErrorAction SilentlyContinue

exit 0
