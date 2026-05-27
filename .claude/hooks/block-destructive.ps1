#!/usr/bin/env pwsh
# PreToolUse / Bash — block destructive git and Azure CLI operations
param(
    [string]$ToolName,
    [string]$ToolInput
)

$input = $env:CLAUDE_TOOL_INPUT
if (-not $input) { exit 0 }

try { $tool = $input | ConvertFrom-Json -ErrorAction Stop } catch { exit 0 }

$command = $tool.command
if (-not $command) { exit 0 }

$blocked = @(
    'git push --force',
    'git push -f ',
    'git push -f$',
    'git reset --hard',
    'git clean -f',
    'git branch -D',
    'Remove-Item.*-Recurse.*-Force.*E:/git',
    'rm -rf.*E:/git',
    'az group delete',
    'az resource delete.*--no-wait'
)

foreach ($pattern in $blocked) {
    if ($command -match $pattern) {
        @{
            decision = 'block'
            reason   = "Blocked destructive operation: '$pattern' matched in command. Confirm with user before proceeding."
        } | ConvertTo-Json
        exit 2
    }
}

exit 0
