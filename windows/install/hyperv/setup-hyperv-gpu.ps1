# Script de configuration Hyper-V avec accélération GPU
# Nécessite PowerShell en tant qu'administrateur

$VMName = "NixOS"
$ISOPath = "C:\VMs\NixOS\nixos-24.05.iso"
$VHDPath = "C:\VMs\NixOS\nixos-disk.vhdx"
$Memory = 8GB
$CPUCount = 4

# Créer la VM si elle n'existe pas
if (-not (Get-VM -Name $VMName -ErrorAction SilentlyContinue)) {
    Write-Host "Création de la VM $VMName..."
    
    # Créer le disque virtuel
    if (-not (Test-Path $VHDPath)) {
        New-VHD -Path $VHDPath -SizeBytes 50GB -Dynamic
    }
    
    # Créer la VM
    New-VM -Name $VMName `
           -MemoryStartupBytes $Memory `
           -Generation 2 `
           -VHDPath $VHDPath `
           -SwitchName "Default Switch"
    
    # Configurer la VM
    Set-VM -Name $VMName -ProcessorCount $CPUCount
    Set-VM -Name $VMName -CheckpointType Disabled
    
    # Ajouter le DVD avec l'ISO
    Add-VMDvdDrive -VMName $VMName -Path $ISOPath
    
    # Configurer le boot
    $dvd = Get-VMDvdDrive -VMName $VMName
    Set-VMFirmware -VMName $VMName -FirstBootDevice $dvd
    
    # Désactiver Secure Boot pour Linux
    Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
    
    Write-Host "VM créée avec succès!"
}

# Activer l'accélération GPU (GPU-PV)
Write-Host "`nConfiguration de l'accélération GPU..."
Write-Host "ATTENTION: GPU-PV nécessite Windows 10/11 Pro et un GPU compatible"

# Vérifier les GPU disponibles
Write-Host "`nGPU disponibles sur cet hôte:"
Get-VMHostPartitionableGpu

Write-Host "`nPour activer GPU-PV, exécutez:"
Write-Host "Add-VMGpuPartitionAdapter -VMName $VMName"
Write-Host "Set-VMGpuPartitionAdapter -VMName $VMName -MinPartitionVRAM 80000000 -MaxPartitionVRAM 100000000 -OptimalPartitionVRAM 100000000"
Write-Host "Set-VMGpuPartitionAdapter -VMName $VMName -MinPartitionEncode 80000000 -MaxPartitionEncode 100000000 -OptimalPartitionEncode 100000000"
Write-Host "Set-VMGpuPartitionAdapter -VMName $VMName -MinPartitionDecode 80000000 -MaxPartitionDecode 100000000 -OptimalPartitionDecode 100000000"
Write-Host "Set-VMGpuPartitionAdapter -VMName $VMName -MinPartitionCompute 80000000 -MaxPartitionCompute 100000000 -OptimalPartitionCompute 100000000"
Write-Host "Set-VM -GuestControlledCacheTypes $true -VMName $VMName"
Write-Host "Set-VM -LowMemoryMappedIoSpace 1GB -VMName $VMName"
Write-Host "Set-VM -HighMemoryMappedIoSpace 32GB -VMName $VMName"

Write-Host "`nPour démarrer la VM:"
Write-Host "Start-VM -Name $VMName"
