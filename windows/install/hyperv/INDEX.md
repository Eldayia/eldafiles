# 📑 Index des Scripts et Fichiers

## 🎯 Scripts de Déploiement (Recommandés)

### **deploy-vm-hyperv.ps1** ⭐
**Le script principal de déploiement automatique**
- ✅ Gère tout de A à Z (Hyper-V, VM, GPU-PV)
- ✅ Mode interactif ou avec paramètres
- ✅ Portable sur n'importe quel PC Windows Pro/Enterprise
- 📖 Documentation : `README-DEPLOIEMENT.md`

**Utilisation :**
```powershell
# Mode interactif
.\deploy-vm-hyperv.ps1

# Avec paramètres
.\deploy-vm-hyperv.ps1 -VMName "MaVM" -ISOPath "C:\ISOs\linux.iso" -Memory 16 -CPUCount 8
```

### **quick-deploy.bat**
**Wrapper batch pour déploiement rapide**
- Exécution en double-clic (avec droits admin)
- Passe tous les arguments au script PowerShell

**Utilisation :**
```
Clic droit → Exécuter en tant qu'administrateur
```

---

## 🚀 Scripts de Démarrage Hyper-V

### **start-hyperv.bat**
Lance la VM NixOS existante sur Hyper-V

### **start-hyperv.ps1**
Version PowerShell détaillée du script de démarrage

---

## 🔧 Scripts QEMU (Anciens - Conservés pour référence)

### **start-nixos.bat**
QEMU avec WHPX et tentative d'accélération virtio-vga-gl

### **start-nixos-fixed.bat**
QEMU avec configuration simplifiée (sans GPU)

### **start-nixos-pc.bat**
QEMU avec machine type "pc" (plus stable)

### **start-nixos-3d.bat**
QEMU avec virtio-vga-gl pour accélération 3D logicielle

---

## 📖 Documentation

### **README-DEPLOIEMENT.md** ⭐
**Guide complet du script de déploiement**
- Tous les paramètres disponibles
- Exemples d'utilisation
- Dépannage
- Commandes PowerShell utiles

### **README-GPU.md**
Guide spécifique pour l'accélération GPU
- Configuration NixOS pour GPU-PV
- Tests d'accélération 3D
- Informations GPU détectés

### **INDEX.md** (ce fichier)
Index de tous les fichiers disponibles

---

## 🗄️ Fichiers de Données

### **nixos-24.05.iso** (1.5 GB)
Image ISO d'installation NixOS

### **nixos-disk.qcow2** (194 KB)
Ancien disque QEMU (vide)

### **nixos-disk.vhdx** (2.8 GB)
Disque Hyper-V actuel (80 GB dynamique)

---

## 🔍 Scripts par Cas d'Usage

### "Je veux déployer une nouvelle VM sur un autre PC"
→ **Copiez :** `deploy-vm-hyperv.ps1` + `quick-deploy.bat` + `README-DEPLOIEMENT.md`
→ **Exécutez :** `quick-deploy.bat` (en tant qu'admin)

### "Je veux démarrer ma VM NixOS existante"
→ **Utilisez :** `start-hyperv.bat` (Hyper-V) ou `start-nixos.bat` (QEMU)

### "Je veux comprendre la configuration GPU-PV"
→ **Lisez :** `README-GPU.md`

### "Je veux créer une VM manuellement"
→ **Référez-vous à :** `setup-hyperv-gpu.ps1`

---

## 📦 Package Minimal pour Déploiement

Pour déployer sur un autre PC, copiez ces fichiers :

```
deploy-vm-hyperv.ps1       (Script principal)
quick-deploy.bat            (Lanceur rapide)
README-DEPLOIEMENT.md      (Documentation)
<votre-iso>.iso            (Image d'installation)
```

---

## 🎓 Hiérarchie des Scripts

```
Déploiement Complet
├── deploy-vm-hyperv.ps1      ← Script principal (RECOMMANDÉ)
└── quick-deploy.bat           ← Wrapper batch

Hyper-V (Actuel)
├── start-hyperv.bat           ← Pour démarrer la VM existante
├── start-hyperv.ps1
└── setup-hyperv-gpu.ps1       ← Configuration manuelle (référence)

QEMU (Ancien)
├── start-nixos.bat
├── start-nixos-fixed.bat
├── start-nixos-pc.bat
└── start-nixos-3d.bat
```

---

## 💡 Astuces

### Pour déployer rapidement sur un nouveau PC :
1. Copiez le dossier `C:\VMs\NixOS` entier
2. Exécutez `quick-deploy.bat` en admin
3. Sélectionnez votre ISO
4. Laissez le script tout configurer !

### Pour tester si GPU-PV est disponible :
```powershell
Get-VMHostPartitionableGpu
```

### Pour voir toutes les VMs :
```powershell
Get-VM
```

---

**Dernière mise à jour :** 16 décembre 2025  
**Version des scripts :** 1.0
