#!/usr/bin/env pwsh
# PostToolUse / Write|Edit — run markdownlint on written .md files
# No-op if markdownlint is not installed

param()

$input = $env:CLAUDE_TOOL_INPUT
if (-not $input) { exit 0 }

try { $tool = $input | ConvertFrom-Json -ErrorAction Stop } catch { exit 0 }

$filePath = $tool.file_path
if (-not $filePath) { exit 0 }
if (-not $filePath.EndsWith('.md')) { exit 0 }
if (-not (Test-Path $filePath)) { exit 0 }

# Check if markdownlint-cli is available
$mlPath = Get-Command 'markdownlint' -ErrorAction SilentlyContinue
if (-not $mlPath) { exit 0 }

# Run markdownlint — fix mode, permissive config (don't block on lint warnings)
try {
    & markdownlint --fix $filePath 2>$null
} catch {
    # Silently ignore errors — this hook is advisory only
}

exit 0
