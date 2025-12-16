#!/usr/bin/env pwsh
# Script d'installation pour haste

$installDir = "$env:LOCALAPPDATA\Programs\haste"
$scriptSource = Join-Path $PSScriptRoot "haste.ps1"

Write-Host "Installation de haste..." -ForegroundColor Cyan

# Créer le dossier d'installation s'il n'existe pas
if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
    Write-Host "✓ Dossier créé: $installDir" -ForegroundColor Green
}

# Copier le script
Copy-Item $scriptSource -Destination $installDir -Force
Write-Host "✓ Script copié dans $installDir" -ForegroundColor Green

# Supprimer l'ancien chemin du PATH s'il existe
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$oldPath = "C:\Users\jouan\Dev\eldafiles\windows\install\haste"

if ($currentPath -like "*$oldPath*") {
    $newPath = ($currentPath -split ';' | Where-Object { $_ -ne $oldPath }) -join ';'
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "✓ Ancien chemin retiré du PATH" -ForegroundColor Green
}

# Ajouter le nouveau chemin au PATH s'il n'y est pas déjà
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$installDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$installDir", "User")
    Write-Host "✓ Nouveau chemin ajouté au PATH" -ForegroundColor Green
} else {
    Write-Host "✓ Chemin déjà présent dans le PATH" -ForegroundColor Yellow
}

# Actualiser le PATH pour la session en cours
$env:PATH = [Environment]::GetEnvironmentVariable("Path", "User") + ";" + [Environment]::GetEnvironmentVariable("Path", "Machine")

Write-Host "`n✓ Installation terminée!" -ForegroundColor Green
Write-Host "Vous pouvez maintenant utiliser: command | haste" -ForegroundColor Cyan
Write-Host "`nEmplacement: $installDir\haste.ps1" -ForegroundColor Gray
