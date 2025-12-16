@echo off
REM Démarrage de la VM NixOS avec Hyper-V + GPU-PV

echo Demarrage de la VM NixOS avec acceleration GPU...
powershell.exe -ExecutionPolicy Bypass -File "%~dp0start-hyperv.ps1"
