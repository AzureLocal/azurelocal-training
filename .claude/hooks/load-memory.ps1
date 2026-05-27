#!/usr/bin/env pwsh
# UserPromptSubmit — inject a memory-loaded reminder on the first prompt of a session
# Reads MEMORY.md and prepends a brief summary if the session is fresh

$memoryFile = 'C:/Users/KristopherTurner/.claude/projects/e--git-azurelocal-azurelocal-training/memory/MEMORY.md'

if (-not (Test-Path $memoryFile)) { exit 0 }

# Only inject on the first prompt (session file not yet created means fresh session)
$sessionLog = 'E:/git/azurelocal/azurelocal-training/.claude/logs/sessions.jsonl'
$sessionAge = $null
if (Test-Path $sessionLog) {
    $lastLine = Get-Content $sessionLog -Tail 1 -ErrorAction SilentlyContinue
    if ($lastLine) {
        try {
            $lastSession = $lastLine | ConvertFrom-Json -ErrorAction Stop
            $sessionAge = (Get-Date) - [datetime]$lastSession.timestamp
        } catch {}
    }
}

# If last session was within 10 minutes, assume we're in the same session — skip injection
if ($sessionAge -and $sessionAge.TotalMinutes -lt 10) { exit 0 }

$memoryIndex = Get-Content $memoryFile -Raw -ErrorAction SilentlyContinue
if (-not $memoryIndex) { exit 0 }

# Output as a system note injected before the user's message
@{
    note = "Memory loaded from MEMORY.md:`n`n$memoryIndex"
} | ConvertTo-Json
exit 0
