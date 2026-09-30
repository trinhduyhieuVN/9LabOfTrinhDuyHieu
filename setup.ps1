$ErrorActionPreference = 'Stop'
$projects = @('im_rich', 'micard', 'dicee_app', 'magic_8_ball', 'xylophone',
  'quizzler', 'boss_level_challenge2', 'bmi_calculator', 'clima')
$failedProjects = @()
foreach ($project in $projects) {
  Push-Location (Join-Path $PSScriptRoot $project)
  try {
    Write-Host "Restoring $project"
    flutter pub get
    if ($LASTEXITCODE -ne 0) { $failedProjects += $project }
  } finally { Pop-Location }
}
if ($failedProjects.Count -gt 0) {
  throw "Review Flutter output for: $($failedProjects -join ', '). For symlink errors, enable Windows Developer Mode and rerun."
}
