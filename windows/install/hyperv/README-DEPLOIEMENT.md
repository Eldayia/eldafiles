# 🚀 Script de Déploiement VM Hyper-V avec GPU-PV

Script PowerShell universel pour déployer rapidement des machines virtuelles Hyper-V avec accélération GPU matérielle (GPU-PV).

## ✨ Fonctionnalités

- ✅ Installation/vérification automatique d'Hyper-V
- ✅ Activation automatique des plateformes de virtualisation (WHPX, VirtualMachinePlatform)
- ✅ Détection et configuration automatique du GPU-PV
- ✅ Support multi-GPU (Intel, AMD, NVIDIA)
- ✅ Configuration réseau automatique
- ✅ Sélection interactive d'ISO
- ✅ RAM dynamique pour une meilleure utilisation des ressources
- ✅ Compatible Linux (Secure Boot désactivé)
- ✅ Gestion des VM existantes (suppression/recréation)

## 📋 Prérequis

- Windows 10/11 **Pro, Enterprise ou Education**
- Processeur avec support de virtualisation (Intel VT-x ou AMD-V)
- Privilèges administrateur
- Au moins 8 GB de RAM recommandés
- GPU compatible GPU-PV (optionnel, mais recommandé pour l'accélération 3D)

## 🎯 Utilisation

### Utilisation basique (mode interactif)

```powershell
# Ouvrir PowerShell en tant qu'administrateur
# Naviguer vers le dossier contenant le script
cd C:\VMs\NixOS

# Exécuter le script
.\deploy-vm-hyperv.ps1
```

Le script vous demandera :
1. Le chemin vers l'ISO (ou proposera une sélection depuis le dossier)
2. Si vous voulez installer Hyper-V (si non installé)
3. Si vous voulez supprimer une VM existante (si applicable)
4. Si vous voulez démarrer la VM immédiatement

### Utilisation avec paramètres

```powershell
# Créer une VM NixOS avec paramètres personnalisés
.\deploy-vm-hyperv.ps1 -VMName "NixOS" -ISOPath "C:\ISOs\nixos-24.05.iso" -Memory 16 -CPUCount 8

# Créer une VM Ubuntu avec disque 120 GB
.\deploy-vm-hyperv.ps1 -VMName "Ubuntu" -ISOPath "C:\ISOs\ubuntu-22.04.iso" -DiskSize 120

# Créer une VM dans un autre emplacement
.\deploy-vm-hyperv.ps1 -VMName "Debian" -ISOPath "C:\ISOs\debian.iso" -VMPath "D:\VirtualMachines"

# Ignorer la vérification Hyper-V (si déjà configuré)
.\deploy-vm-hyperv.ps1 -VMName "Fedora" -ISOPath "C:\ISOs\fedora.iso" -SkipHyperVCheck
```

## 📊 Paramètres disponibles

| Paramètre | Type | Défaut | Description |
|-----------|------|--------|-------------|
| `-VMName` | String | "NixOS" | Nom de la machine virtuelle |
| `-ISOPath` | String | "" | Chemin vers l'ISO (interactif si vide) |
| `-VMPath` | String | "C:\VMs" | Répertoire de stockage des VMs |
| `-Memory` | Int | 8 | RAM allouée en GB |
| `-CPUCount` | Int | 4 | Nombre de CPU virtuels |
| `-DiskSize` | Int | 80 | Taille du disque en GB |
| `-SkipHyperVCheck` | Switch | false | Ignorer la vérification Hyper-V |

## 📁 Structure créée

Après exécution, la structure suivante est créée :

```
C:\VMs\
└── NomDeVotreVM\
    └── NomDeVotreVM.vhdx    (Disque virtuel)
```

## 🎮 Configuration GPU-PV

Le script détecte automatiquement les GPU compatibles et configure GPU-PV si disponible.

### GPU supportés
- ✅ Intel HD Graphics / Iris / Arc
- ✅ AMD Radeon (certains modèles)
- ✅ NVIDIA GeForce / Quadro (avec pilotes récents)

### Vérifier la compatibilité GPU

```powershell
# Voir les GPU disponibles pour GPU-PV
Get-VMHostPartitionableGpu
```

### Désactiver GPU-PV sur une VM existante

```powershell
Remove-VMGpuPartitionAdapter -VMName "NomVM"
```

### Activer GPU-PV manuellement sur une VM existante

```powershell
Add-VMGpuPartitionAdapter -VMName "NomVM"
Set-VMGpuPartitionAdapter -VMName "NomVM" -MinPartitionVRAM 80000000 -MaxPartitionVRAM 100000000 -OptimalPartitionVRAM 100000000
Set-VM -GuestControlledCacheTypes $true -VMName "NomVM"
Set-VM -LowMemoryMappedIoSpace 1GB -VMName "NomVM"
Set-VM -HighMemoryMappedIoSpace 32GB -VMName "NomVM"
```

## 🔧 Commandes utiles post-déploiement

### Gérer la VM

```powershell
# Démarrer la VM
Start-VM -Name "NomVM"

# Se connecter à la console
vmconnect localhost "NomVM"

# Arrêter proprement
Stop-VM -Name "NomVM"

# Arrêt forcé
Stop-VM -Name "NomVM" -Force

# Redémarrer
Restart-VM -Name "NomVM"

# Voir l'état
Get-VM -Name "NomVM"
```

### Modifier la configuration

```powershell
# Changer la RAM
Set-VM -Name "NomVM" -MemoryStartupBytes 16GB

# Changer le nombre de CPU
Set-VM -Name "NomVM" -ProcessorCount 8

# Activer la RAM dynamique
Set-VM -Name "NomVM" -DynamicMemory
Set-VM -Name "NomVM" -MemoryMinimumBytes 2GB
Set-VM -Name "NomVM" -MemoryMaximumBytes 16GB
```

### Gérer les disques

```powershell
# Agrandir un disque virtuel (VM éteinte)
Resize-VHD -Path "C:\VMs\NomVM\NomVM.vhdx" -SizeBytes 120GB

# Ajouter un deuxième disque
New-VHD -Path "C:\VMs\NomVM\Data.vhdx" -SizeBytes 100GB -Dynamic
Add-VMHardDiskDrive -VMName "NomVM" -Path "C:\VMs\NomVM\Data.vhdx"
```

### Supprimer une VM

```powershell
# Arrêter et supprimer la VM
Stop-VM -Name "NomVM" -Force
Remove-VM -Name "NomVM" -Force

# Supprimer aussi les disques virtuels
Remove-Item "C:\VMs\NomVM\*.vhdx" -Force
```

## 🐧 Configuration côté Linux (exemple NixOS)

Une fois la VM créée et le système installé, configurez le support GPU dans NixOS :

```nix
# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  # Support GPU Intel
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      intel-compute-runtime
    ];
  };

  boot.kernelModules = [ "i915" ];
  
  environment.systemPackages = with pkgs; [
    glxinfo
    vulkan-tools
    mesa-demos
  ];
}
```

Puis reconstruire :
```bash
sudo nixos-rebuild switch
```

### Tester l'accélération 3D

```bash
# Vérifier OpenGL
glxinfo | grep "OpenGL renderer"

# Test visuel
glxgears

# Vulkan
vulkaninfo
```

## 🔍 Dépannage

### Hyper-V ne démarre pas

1. Vérifier que la virtualisation est activée dans le BIOS/UEFI
2. Désactiver les autres hyperviseurs (VirtualBox, VMware)
3. Redémarrer après l'installation d'Hyper-V

```powershell
# Vérifier l'état de l'hyperviseur
bcdedit /enum | findstr hypervisorlaunchtype
```

### GPU-PV ne fonctionne pas

1. Mettre à jour les pilotes GPU Windows
2. Vérifier la compatibilité :
```powershell
Get-VMHostPartitionableGpu
```
3. S'assurer que l'hôte Windows utilise aussi le GPU
4. Redémarrer l'hôte Windows après configuration

### La VM ne démarre pas

```powershell
# Voir les erreurs détaillées
Get-VM -Name "NomVM" | Format-List *

# Vérifier les logs
Get-WinEvent -LogName "Microsoft-Windows-Hyper-V-Worker-Admin" -MaxEvents 20
```

### Problème de réseau

```powershell
# Vérifier les commutateurs
Get-VMSwitch

# Recréer le commutateur par défaut
Remove-VMSwitch -Name "Default Switch" -Force
# Redémarrer le service Hyper-V
Restart-Service vmms
```

## 📚 Exemples de déploiement

### NixOS (Minimal)
```powershell
.\deploy-vm-hyperv.ps1 `
  -VMName "NixOS-Minimal" `
  -ISOPath "C:\ISOs\nixos-minimal-24.05.iso" `
  -Memory 4 `
  -CPUCount 2 `
  -DiskSize 40
```

### Ubuntu Desktop (Full)
```powershell
.\deploy-vm-hyperv.ps1 `
  -VMName "Ubuntu-Desktop" `
  -ISOPath "C:\ISOs\ubuntu-22.04-desktop.iso" `
  -Memory 16 `
  -CPUCount 8 `
  -DiskSize 120
```

### Serveur de développement
```powershell
.\deploy-vm-hyperv.ps1 `
  -VMName "DevServer" `
  -ISOPath "C:\ISOs\debian-12.iso" `
  -Memory 32 `
  -CPUCount 16 `
  -DiskSize 500 `
  -VMPath "D:\DevVMs"
```

## 🎁 Bonus : Script batch pour déploiement rapide

Créez un fichier `quick-deploy.bat` :

```batch
@echo off
echo Deploiement rapide de VM...
powershell.exe -ExecutionPolicy Bypass -File "%~dp0deploy-vm-hyperv.ps1" %*
```

Utilisation :
```
quick-deploy.bat -VMName "TestVM" -ISOPath "C:\ISOs\test.iso"
```

## 📄 Licence

Script libre d'utilisation. Modifiez selon vos besoins !

---

**Créé avec** : PowerShell + Hyper-V  
**Compatible** : Windows 10/11 Pro/Enterprise/Education  
**Version** : 1.0  
**Date** : Décembre 2025
