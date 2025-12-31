#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Script de Déploiement automatique d'une VM Hyper-V avec Accélération GPU-PV
    
.DESCRIPTION
    Ce script configure complètement Hyper-V et crée une VM avec Accélération 3D matérielle (GPU-PV)
    Compatible avec Windows 10/11 Pro/Enterprise avec GPU Intel/NVIDIA/AMD
    
.PARAMETER VMName
    Nom de la VM à créer (défaut: NixOS)
    
.PARAMETER ISOPath
    Chemin vers l'ISO d'installation
    
.PARAMETER VMPath
    Répertoire où stocker la VM (défaut: C:\VMs)
    
.PARAMETER Memory
    RAM allouée en GB (défaut: 8)
    
.PARAMETER CPUCount
    Nombre de CPU virtuels (défaut: 4)
    
.PARAMETER DiskSize
    Taille du disque en GB (défaut: 80)
    
.PARAMETER SkipHyperVCheck
    Ignorer la Vérification/installation d'Hyper-V
    
.EXAMPLE
    .\deploy-vm-hyperv.ps1 -VMName "NixOS" -ISOPath "C:\ISOs\nixos-24.05.iso"
    
.EXAMPLE
    .\deploy-vm-hyperv.ps1 -VMName "Ubuntu" -ISOPath "C:\ISOs\ubuntu.iso" -Memory 16 -CPUCount 8
#>

param(
    [string]$VMName = "NixOS",
    [string]$ISOPath = "",
    [string]$VMPath = "C:\VMs",
    [int]$Memory = 8,
    [int]$CPUCount = 4,
    [int]$DiskSize = 80,
    [switch]$SkipHyperVCheck
)

# Configuration UTF-8 pour l'affichage correct des caractères accentués
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Couleurs pour l'affichage
function Write-Step { param([string]$Message) Write-Host "`n[*] $Message" -ForegroundColor Cyan }
function Write-Success { param([string]$Message) Write-Host "[OK] $Message" -ForegroundColor Green }
function Write-Error-Custom { param([string]$Message) Write-Host "[X] $Message" -ForegroundColor Red }
function Write-Warning-Custom { param([string]$Message) Write-Host "[!] $Message" -ForegroundColor Yellow }

# Banner
Write-Host @"

╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║     Déploiement VM Hyper-V avec Accélération GPU-PV      ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝

"@ -ForegroundColor Cyan

# Vérification des privilèges administrateur
Write-Step "Vérification des privilèges administrateur"
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error-Custom "Ce script nécessite des privilèges administrateur !"
    Write-Host "Relancez PowerShell en tant qu'administrateur." -ForegroundColor Yellow
    exit 1
}
Write-Success "Privilèges administrateur confirmés"

# Vérification de l'édition Windows
Write-Step "Vérification de l'édition Windows"
$osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
$osCaption = $osInfo.Caption
Write-Host "Système détecté : $osCaption" -ForegroundColor White

if ($osCaption -notmatch "Pro|Enterprise|Education") {
    Write-Warning-Custom "Hyper-V nécessite Windows 10/11 Pro, Enterprise ou Education"
    Write-Warning-Custom "GPU-PV peut ne pas être disponible sur cette édition"
}

# Vérification/Installation d'Hyper-V
if (-not $SkipHyperVCheck) {
    Write-Step "Vérification d'Hyper-V"
    
    $hyperv = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -ErrorAction SilentlyContinue
    
    if ($hyperv.State -ne "Enabled") {
        Write-Warning-Custom "Hyper-V n'est pas activé"
        $response = Read-Host "Voulez-vous installer Hyper-V maintenant ? (O/N)"
        
        if ($response -eq "O" -or $response -eq "o") {
            Write-Host "Installation d'Hyper-V (nécessite un REDÉMARRAGE)..." -ForegroundColor Yellow
            Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart
            Write-Success "Hyper-V installé"
            Write-Warning-Custom "REDÉMARRAGE REQUIS ! Relancez ce script après le REDÉMARRAGE."
            exit 0
        } else {
            Write-Error-Custom "Hyper-V est REQUIS pour continuer"
            exit 1
        }
    } else {
        Write-Success "Hyper-V est activé"
    }
    
    # Vérifier HypervisorPlatform et VirtualMachinePlatform
    Write-Step "Vérification des plateformes de virtualisation"
    
    $hvPlatform = Get-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -ErrorAction SilentlyContinue
    $vmPlatform = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -ErrorAction SilentlyContinue
    
    $needRestart = $false
    
    if ($hvPlatform.State -ne "Enabled") {
        Write-Host "Activation de HypervisorPlatform..." -ForegroundColor Yellow
        Enable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -NoRestart -ErrorAction SilentlyContinue
        $needRestart = $true
    }
    
    if ($vmPlatform.State -ne "Enabled") {
        Write-Host "Activation de VirtualMachinePlatform..." -ForegroundColor Yellow
        Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart -ErrorAction SilentlyContinue
        $needRestart = $true
    }
    
    if ($needRestart) {
        Write-Warning-Custom "Changements effectués. Un REDÉMARRAGE peut être nécessaire."
    } else {
        Write-Success "Toutes les plateformes sont activées"
    }
}

# Vérification du commutateur réseau par défaut
Write-Step "Vérification du commutateur réseau"
$defaultSwitch = Get-VMSwitch -Name "Default Switch" -ErrorAction SilentlyContinue

if (-not $defaultSwitch) {
    Write-Warning-Custom "Commutateur 'Default Switch' non trouvé"
    Write-Host "Création d'un commutateur réseau NAT..." -ForegroundColor Yellow
    
    try {
        New-VMSwitch -Name "Default Switch" -SwitchType Internal | Out-Null
        Write-Success "Commutateur réseau créé"
    } catch {
        Write-Warning-Custom "Impossible de créer le commutateur. Tentative avec un commutateur externe..."
        $netAdapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1
        if ($netAdapter) {
            New-VMSwitch -Name "VM Network" -NetAdapterName $netAdapter.Name -AllowManagementOS $true | Out-Null
            $switchName = "VM Network"
            Write-Success "Commutateur externe créé"
        } else {
            Write-Error-Custom "Aucun adaptateur réseau disponible"
            exit 1
        }
    }
} else {
    Write-Success "Commutateur réseau disponible"
}

$switchName = if ($defaultSwitch) { "Default Switch" } else { "VM Network" }

# Vérification des GPU compatibles GPU-PV
Write-Step "Détection des GPU compatibles GPU-PV"
$gpus = Get-VMHostPartitionableGpu -ErrorAction SilentlyContinue

if ($gpus) {
    Write-Success "$($gpus.Count) GPU(s) compatible(s) détecté(s)"
    foreach ($gpu in $gpus) {
        $gpuName = $gpu.Name -replace '.*PCI#VEN_([0-9A-F]+)&DEV_([0-9A-F]+).*', 'VEN_$1 DEV_$2'
        Write-Host "  - $gpuName" -ForegroundColor Gray
        Write-Host "    VRAM disponible: $([math]::Round($gpu.AvailableVRAM / 1MB, 0)) MB" -ForegroundColor Gray
    }
    $gpuAvailable = $true
} else {
    Write-Warning-Custom "Aucun GPU compatible GPU-PV détecté"
    Write-Warning-Custom "La VM sera créée sans Accélération GPU matérielle"
    $gpuAvailable = $false
}

# Demander le chemin ISO si non fourni
if ([string]::IsNullOrEmpty($ISOPath) -or -not (Test-Path $ISOPath)) {
    Write-Step "Sélection de l'ISO"
    
    # Rechercher des ISOs dans le Répertoire courant
    $isos = Get-ChildItem -Path $VMPath -Filter "*.iso" -ErrorAction SilentlyContinue
    
    if ($isos) {
        Write-Host "ISOs trouvées dans $VMPath :" -ForegroundColor Yellow
        for ($i = 0; $i -lt $isos.Count; $i++) {
            Write-Host "  [$i] $($isos[$i].Name)" -ForegroundColor White
        }
        
        $selection = Read-Host "Sélectionnez un numéro ou entrez le chemin complet"
        
        if ($selection -match '^\d+$' -and [int]$selection -lt $isos.Count) {
            $ISOPath = $isos[[int]$selection].FullName
        } else {
            $ISOPath = $selection
        }
    } else {
        $ISOPath = Read-Host "Entrez le chemin complet vers l'ISO"
    }
    
    if (-not (Test-Path $ISOPath)) {
        Write-Error-Custom "ISO introuvable : $ISOPath"
        exit 1
    }
}

Write-Success "ISO sélectionnée : $ISOPath"

# Créer le répertoire VM si nécessaire
$vmDir = Join-Path $VMPath $VMName
if (-not (Test-Path $vmDir)) {
    New-Item -Path $vmDir -ItemType Directory -Force | Out-Null
    Write-Success "Répertoire VM créé : $vmDir"
}

# Chemin du disque virtuel
$vhdPath = Join-Path $vmDir "$VMName.vhdx"

# Vérifier si la VM existe déjà
Write-Step "Vérification de l'existence de la VM"
$existingVM = Get-VM -Name $VMName -ErrorAction SilentlyContinue

if ($existingVM) {
    Write-Warning-Custom "Une VM nommée '$VMName' existe déjà !"
    $response = Read-Host "Voulez-vous la supprimer et recréer ? (O/N)"
    
    if ($response -eq "O" -or $response -eq "o") {
        Write-Host "Suppression de la VM existante..." -ForegroundColor Yellow
        
        if ($existingVM.State -ne "Off") {
            Stop-VM -Name $VMName -Force
        }
        
        Remove-VM -Name $VMName -Force
        Write-Success "VM supprimée"
        
        if (Test-Path $vhdPath) {
            $response2 = Read-Host "Supprimer aussi le disque virtuel ? (O/N)"
            if ($response2 -eq "O" -or $response2 -eq "o") {
                Remove-Item $vhdPath -Force
                Write-Success "Disque virtuel supprimé"
            }
        }
    } else {
        Write-Error-Custom "Opération annulée"
        exit 1
    }
}

# Création du disque virtuel
Write-Step "Création du disque virtuel"
if (-not (Test-Path $vhdPath)) {
    Write-Host "Création de $vhdPath ($DiskSize GB)..." -ForegroundColor White
    New-VHD -Path $vhdPath -SizeBytes ($DiskSize * 1GB) -Dynamic | Out-Null
    Write-Success "Disque virtuel créé"
} else {
    Write-Success "Disque virtuel existant utilisé"
}

# Création de la VM
Write-Step "Création de la machine virtuelle"
Write-Host "Nom: $VMName" -ForegroundColor White
Write-Host "RAM: $Memory GB" -ForegroundColor White
Write-Host "CPU: $CPUCount" -ForegroundColor White
Write-Host "Disque: $DiskSize GB" -ForegroundColor White

$memoryBytes = $Memory * 1GB

New-VM -Name $VMName `
       -MemoryStartupBytes $memoryBytes `
       -Generation 2 `
       -VHDPath $vhdPath `
       -SwitchName $switchName | Out-Null

Write-Success "VM créée"

# Configuration de la VM
Write-Step "Configuration de la VM"

Set-VM -Name $VMName -ProcessorCount $CPUCount
Set-VM -Name $VMName -CheckpointType Disabled
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

# Activer la RAM dynamique (optionnel)
Set-VM -Name $VMName -DynamicMemory
$minMemory = [math]::Max([int64]512MB, [int64]($memoryBytes / 2))
Set-VM -Name $VMName -MemoryMinimumBytes $minMemory
Set-VM -Name $VMName -MemoryMaximumBytes ($memoryBytes * 2)

Write-Success "Configuration de base appliquée"

# Ajouter le lecteur DVD avec l'ISO
Write-Step "Montage de l'ISO"
Add-VMDvdDrive -VMName $VMName -Path $ISOPath
$dvd = Get-VMDvdDrive -VMName $VMName
Set-VMFirmware -VMName $VMName -FirstBootDevice $dvd
Write-Success "ISO montée et configurée en premier périphérique de boot"

# Désactiver Secure Boot pour Linux
Write-Step "Configuration du firmware"
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
Write-Success "Secure Boot désactivé (compatible Linux)"

# Configuration GPU-PV
if ($gpuAvailable) {
    Write-Step "Configuration de l'accélération GPU-PV"
    
    try {
        Add-VMGpuPartitionAdapter -VMName $VMName
        
        # Configuration optimisée pour les GPU Intel/AMD/NVIDIA
        $vramMin = 80000000
        $vramMax = 100000000
        $vramOptimal = 100000000
        
        Set-VMGpuPartitionAdapter -VMName $VMName `
            -MinPartitionVRAM $vramMin `
            -MaxPartitionVRAM $vramMax `
            -OptimalPartitionVRAM $vramOptimal `
            -MinPartitionEncode $vramMin `
            -MaxPartitionEncode $vramMax `
            -OptimalPartitionEncode $vramMax `
            -MinPartitionDecode $vramMin `
            -MaxPartitionDecode $vramMax `
            -OptimalPartitionDecode $vramMax `
            -MinPartitionCompute $vramMin `
            -MaxPartitionCompute $vramMax `
            -OptimalPartitionCompute $vramMax
        
        Set-VM -Name $VMName -GuestControlledCacheTypes $true
        Set-VM -Name $VMName -LowMemoryMappedIoSpace 1GB
        Set-VM -Name $VMName -HighMemoryMappedIoSpace 32GB
        
        Write-Success "GPU-PV configuré avec succès"
    } catch {
        Write-Warning-Custom "Erreur lors de la configuration GPU-PV : $_"
        Write-Warning-Custom "La VM fonctionnera sans accélération GPU matérielle"
    }
}

# Affichage du résumé
Write-Host @"

╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║              ✓  DÉPLOIEMENT RÉUSSI  ✓                    ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝

"@ -ForegroundColor Green

Write-Host "Configuration de la VM '$VMName' :" -ForegroundColor Cyan
Write-Host "  • Emplacement    : $vmDir" -ForegroundColor White
Write-Host "  • Disque VHDX    : $DiskSize GB (dynamique)" -ForegroundColor White
Write-Host "  • RAM            : $Memory GB (dynamique)" -ForegroundColor White
Write-Host "  • CPU            : $CPUCount cœurs" -ForegroundColor White
Write-Host "  • Réseau         : $switchName" -ForegroundColor White
Write-Host "  • ISO            : $(Split-Path $ISOPath -Leaf)" -ForegroundColor White
Write-Host "  • GPU-PV         : $(if($gpuAvailable){'✓ Activé'}else{'✗ Non disponible'})" -ForegroundColor $(if($gpuAvailable){'Green'}else{'Yellow'})
Write-Host "  • Secure Boot    : Désactivé pour Linux" -ForegroundColor White

Write-Host "`nCommandes utiles :" -ForegroundColor Cyan
Write-Host "  Démarrer la VM  : Start-VM -Name '$VMName'" -ForegroundColor Gray
Write-Host "  Connecter       : vmconnect localhost '$VMName'" -ForegroundColor Gray
Write-Host "  Arrêter         : Stop-VM -Name '$VMName'" -ForegroundColor Gray
Write-Host "  Supprimer       : Remove-VM -Name '$VMName' -Force" -ForegroundColor Gray

# Demander si on doit démarrer la VM
Write-Host ""
$startVM = Read-Host "Voulez-vous démarrer la VM maintenant ? (O/N)"

if ($startVM -eq "O" -or $startVM -eq "o") {
    Write-Host "`nDémarrage de la VM..." -ForegroundColor Yellow
    Start-VM -Name $VMName
    Start-Sleep -Seconds 2
    
    Write-Host "Ouverture de la console..." -ForegroundColor Yellow
    Start-Process "vmconnect" -ArgumentList "localhost", $VMName
    
    Write-Success "VM démarrée et console ouverte"
} else {
    Write-Host "`nPour démarrer la VM plus tard :" -ForegroundColor Yellow
    Write-Host "  Start-VM -Name '$VMName'" -ForegroundColor White
    Write-Host "  vmconnect localhost '$VMName'" -ForegroundColor White
}

Write-Host "`n✓ Script terminé avec succès !`n" -ForegroundColor Green

