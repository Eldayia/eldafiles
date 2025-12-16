# Démarrage de la VM NixOS avec Hyper-V + GPU-PV
# Nécessite PowerShell en tant qu'administrateur

$VMName = "NixOS"

Write-Host "Démarrage de la VM $VMName avec accélération GPU..." -ForegroundColor Cyan

# Vérifier que la VM existe
if (-not (Get-VM -Name $VMName -ErrorAction SilentlyContinue)) {
    Write-Host "ERREUR: La VM $VMName n'existe pas!" -ForegroundColor Red
    exit 1
}

# Démarrer la VM
Start-VM -Name $VMName

Write-Host "VM démarrée!" -ForegroundColor Green
Write-Host "`nPour vous connecter à la VM:"
Write-Host "  - Ouvrez le Gestionnaire Hyper-V (virtmgmt.msc)"
Write-Host "  - Double-cliquez sur la VM '$VMName'"
Write-Host "`nOu utilisez: vmconnect localhost $VMName"

# Ouvrir la connexion automatiquement
Start-Process "vmconnect" -ArgumentList "localhost", $VMName
