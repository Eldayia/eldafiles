@echo off
chcp 65001 >nul
REM Script de déploiement rapide de VM Hyper-V avec GPU-PV
REM Usage: quick-deploy.bat [-VMName "NomVM"] [-ISOPath "C:\path\to.iso"] [autres paramètres]

echo.
echo ╔═══════════════════════════════════════════════════════════╗
echo ║   Déploiement Rapide VM Hyper-V avec GPU-PV              ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

REM Vérifier les privilèges administrateur
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERREUR] Privileges administrateur requis !
    echo.
    echo Clic droit sur ce fichier et selectionnez "Executer en tant qu'administrateur"
    pause
    exit /b 1
)

REM Exécuter le script PowerShell avec tous les arguments en UTF-8
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; & '%~dp0deploy-vm-hyperv.ps1' %*"

pause
