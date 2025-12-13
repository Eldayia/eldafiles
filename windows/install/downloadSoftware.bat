@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ===============================================
echo Script de téléchargement des programmes
echo ===============================================
echo.

set "DOWNLOAD_DIR=%~dp0Downloads"
if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

echo Répertoire de téléchargement: %DOWNLOAD_DIR%
echo.
echo Démarrage des téléchargements...
echo.

REM 1. 1Password
echo [1/68] 1Password
winget download --id AgileBits.1Password --download-folder "%DOWNLOAD_DIR%\1Password" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\1PasswordSetup.exe" "https://downloads.1password.com/win/1PasswordSetup-latest.exe" 2>nul
)

REM 1b. 1Password CLI
echo [1b/68] 1Password CLI
winget download --id AgileBits.1Password.CLI --download-folder "%DOWNLOAD_DIR%\1Password-CLI" 2>nul
if errorlevel 1 (
    echo   ^> Téléchargement alternatif...
    curl -L -o "%DOWNLOAD_DIR%\1password-cli.zip" "https://downloads.1password.com/win/1password-cli-latest.zip" 2>nul
)

REM 2. 7-Zip
echo [2/68] 7-Zip
winget download --id 7zip.7zip --download-folder "%DOWNLOAD_DIR%\7-Zip" 2>nul
if errorlevel 1 (
    echo   ^> Téléchargement alternatif...
    curl -L -o "%DOWNLOAD_DIR%\7z-x64.exe" "https://www.7-zip.org/a/7z2501-x64.exe" 2>nul
)

REM 3. Acronis True Image
echo [3/68] Acronis True Image
winget download --id Acronis.TrueImage --download-folder "%DOWNLOAD_DIR%\Acronis" 2>nul
if errorlevel 1 (
    echo   ^> Non disponible sur winget - téléchargement manuel requis
    echo   ^> https://www.acronis.com/
)

REM 4. Adobe Creative Cloud
echo [4/68] Adobe Creative Cloud
winget download --id Adobe.CreativeCloud --download-folder "%DOWNLOAD_DIR%\Adobe-CC" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\CreativeCloudSetup.exe" "https://creativecloud.adobe.com/apps/download/creative-cloud" 2>nul
)

REM 5. Amazon Games
echo [5/68] Amazon Games
winget download --id Amazon.Games --download-folder "%DOWNLOAD_DIR%\Amazon-Games" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\AmazonGamesSetup.exe" "https://download.amazongames.com/AmazonGamesSetup.exe" 2>nul
)

REM 6. Ankama Launcher
echo [6/68] Ankama Launcher
winget download --id Ankama.AnkamaLauncher --download-folder "%DOWNLOAD_DIR%\Ankama" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\Ankama-Launcher-Setup.exe" "https://launcher.cdn.ankama.com/installers/production/Ankama%20Launcher-Setup.exe" 2>nul
)

REM 7. Apple Music
echo [7/68] Apple Music
winget download --id Apple.AppleMusic --download-folder "%DOWNLOAD_DIR%\Apple-Music" 2>nul
if errorlevel 1 (
    winget download --id Apple.iTunes --download-folder "%DOWNLOAD_DIR%\Apple-Music" 2>nul
)

REM 8. Battle.net
echo [8/68] Battle.net
winget download --id Blizzard.BattleNet --download-folder "%DOWNLOAD_DIR%\BattleNet" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\Battle.net-Setup.exe" "https://downloader.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe" 2>nul
)

REM 9. Bitdefender Total Security
echo [9/68] Bitdefender Total Security
winget download --id Bitdefender.Bitdefender --download-folder "%DOWNLOAD_DIR%\Bitdefender" 2>nul
if errorlevel 1 (
    echo   ^> Non disponible - téléchargement manuel requis
    echo   ^> https://www.bitdefender.com/
)

REM 10. BlueStacks
echo [10/68] BlueStacks
winget download --id BlueStack.BlueStacks --download-folder "%DOWNLOAD_DIR%\BlueStacks" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\BlueStacksInstaller.exe" "https://cdn3.bluestacks.com/downloads/windows/nxt/latest/BlueStacksInstaller.exe" 2>nul
)

REM 11. CMake
echo [11/68] CMake
winget download --id Kitware.CMake --download-folder "%DOWNLOAD_DIR%\CMake" 2>nul

REM 12. Comet
echo [12/68] Comet
winget download --id 115.Comet --download-folder "%DOWNLOAD_DIR%\Comet" 2>nul
if errorlevel 1 (
    echo   ^> Non disponible sur winget
)

REM 13. CurseForge
echo [13/68] CurseForge
winget download --id Overwolf.CurseForge --download-folder "%DOWNLOAD_DIR%\CurseForge" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\CurseForge-Setup.exe" "https://curseforge.overwolf.com/downloads/curseforge-latest-x64.exe" 2>nul
)

REM 14. Cursor
echo [14/68] Cursor
winget download --id Cursor.Cursor --download-folder "%DOWNLOAD_DIR%\Cursor" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\CursorSetup.exe" "https://downloader.cursor.sh/windows/nsis/x64" 2>nul
)

REM 15. Discord
echo [15/68] Discord
winget download --id Discord.Discord --download-folder "%DOWNLOAD_DIR%\Discord" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\DiscordSetup.exe" "https://discord.com/api/download?platform=win" 2>nul
)

REM 16. DisplayLink Graphics
echo [16/68] DisplayLink Graphics
winget download --id DisplayLink.GraphicsDriver --download-folder "%DOWNLOAD_DIR%\DisplayLink" 2>nul
if errorlevel 1 (
    echo   ^> Non disponible - téléchargement manuel requis
    echo   ^> https://www.synaptics.com/products/displaylink-graphics
)

REM 17. EA app
echo [17/68] EA app
winget download --id ElectronicArts.EADesktop --download-folder "%DOWNLOAD_DIR%\EA-App" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\EAappInstaller.exe" "https://origin-a.akamaihd.net/EA-Desktop-Client-Download/installer-releases/EAappInstaller.exe" 2>nul
)

REM 18. Elgato Stream Deck
echo [18/68] Elgato Stream Deck
winget download --id Elgato.StreamDeck --download-folder "%DOWNLOAD_DIR%\StreamDeck" 2>nul
if errorlevel 1 (
    echo   ^> Non disponible sur winget - téléchargement manuel requis
    echo   ^> https://www.elgato.com/
)

REM 19. eM Client
echo [19/68] eM Client
winget download --id eMClient.eMClient --download-folder "%DOWNLOAD_DIR%\eMClient" 2>nul

REM 20. Epic Games Launcher
echo [20/68] Epic Games Launcher
winget download --id EpicGames.EpicGamesLauncher --download-folder "%DOWNLOAD_DIR%\Epic-Games" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\EpicInstaller.msi" "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi" 2>nul
)

REM 21. Epic Online Services
echo [21/68] Epic Online Services
echo   ^> Inclus avec Epic Games Launcher

REM 22. FileZilla
echo [22/68] FileZilla
winget download --id TimKosse.FileZilla.Client --download-folder "%DOWNLOAD_DIR%\FileZilla" 2>nul

REM 23. Git
echo [23/68] Git
winget download --id Git.Git --download-folder "%DOWNLOAD_DIR%\Git" 2>nul

REM 24. GitKraken
echo [24/68] GitKraken
winget download --id Axosoft.GitKraken --download-folder "%DOWNLOAD_DIR%\GitKraken" 2>nul

REM 25. GOG GALAXY
echo [25/68] GOG GALAXY
winget download --id GOG.Galaxy --download-folder "%DOWNLOAD_DIR%\GOG-Galaxy" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\GOG-Galaxy-Setup.exe" "https://webinstallers.gog-statics.com/download/GOG_Galaxy_2.0.exe" 2>nul
)

REM 26. Google Chrome
echo [26/68] Google Chrome
winget download --id Google.Chrome --download-folder "%DOWNLOAD_DIR%\Chrome" 2>nul

REM 27. Google Chrome Canary
echo [27/68] Google Chrome Canary
winget download --id Google.Chrome.Canary --download-folder "%DOWNLOAD_DIR%\Chrome-Canary" 2>nul

REM 28. HoYoPlay
echo [28/68] HoYoPlay
winget download --id Cognosphere.HoYoPlay --download-folder "%DOWNLOAD_DIR%\HoYoPlay" 2>nul
if errorlevel 1 (
    echo   ^> Non disponible sur winget
)

REM 29. LM Studio
echo [29/68] LM Studio
winget download --id LMStudio.LMStudio --download-folder "%DOWNLOAD_DIR%\LM-Studio" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\LM-Studio-Setup.exe" "https://releases.lmstudio.ai/windows/latest/LM-Studio-Setup.exe" 2>nul
)

REM 30. Logi Options+
echo [30/68] Logi Options+
winget download --id Logitech.OptionsPlus --download-folder "%DOWNLOAD_DIR%\Logi-Options-Plus" 2>nul

REM 31. Logitech G HUB
echo [31/68] Logitech G HUB
winget download --id Logitech.GHUB --download-folder "%DOWNLOAD_DIR%\Logitech-GHUB" 2>nul

REM 32. Microsoft Visual Studio Code
echo [32/68] Visual Studio Code
winget download --id Microsoft.VisualStudioCode --download-folder "%DOWNLOAD_DIR%\VSCode" 2>nul

REM 33. Microsoft Visual Studio Installer
echo [33/68] Visual Studio Installer
echo   ^> Inclus avec Visual Studio

REM 34. Mp3tag
echo [34/68] Mp3tag
winget download --id Florian.Heidenreich.Mp3tag --download-folder "%DOWNLOAD_DIR%\Mp3tag" 2>nul

REM 35. Node.js
echo [35/68] Node.js
winget download --id OpenJS.NodeJS --download-folder "%DOWNLOAD_DIR%\NodeJS" 2>nul

REM 36. NordVPN
echo [36/68] NordVPN
winget download --id NordVPN.NordVPN --download-folder "%DOWNLOAD_DIR%\NordVPN" 2>nul

REM 37. OrcaSlicer
echo [37/68] OrcaSlicer
winget download --id SoftFever.OrcaSlicer --download-folder "%DOWNLOAD_DIR%\OrcaSlicer" 2>nul

REM 38. PowerToys
echo [38/68] PowerToys
winget download --id Microsoft.PowerToys --download-folder "%DOWNLOAD_DIR%\PowerToys" 2>nul

REM 39. Python 3.12
echo [39/68] Python 3.12
winget download --id Python.Python.3.12 --download-folder "%DOWNLOAD_DIR%\Python" 2>nul

REM 40. qBittorrent
echo [40/68] qBittorrent
winget download --id qBittorrent.qBittorrent --download-folder "%DOWNLOAD_DIR%\qBittorrent" 2>nul

REM 41. QNAP Qsync Client
echo [41/68] QNAP Qsync Client
echo   ^> Non disponible sur winget - téléchargement manuel requis
echo   ^> https://www.qnap.com/

REM 42. Rainmeter
echo [42/68] Rainmeter
winget download --id Rainmeter.Rainmeter --download-folder "%DOWNLOAD_DIR%\Rainmeter" 2>nul

REM 43. Raspberry Pi Imager
echo [43/68] Raspberry Pi Imager
winget download --id RaspberryPiFoundation.RaspberryPiImager --download-folder "%DOWNLOAD_DIR%\RPi-Imager" 2>nul

REM 44. ReNamer
echo [44/68] ReNamer
winget download --id DenisKozlov.ReNamer --download-folder "%DOWNLOAD_DIR%\ReNamer" 2>nul

REM 45. Revo Uninstaller Pro
echo [45/68] Revo Uninstaller Pro
winget download --id RevoUninstaller.RevoUninstallerPro --download-folder "%DOWNLOAD_DIR%\Revo-Uninstaller" 2>nul

REM 46. Riot Client
echo [46/68] Riot Client
winget download --id RiotGames.LeagueOfLegends.EUW --download-folder "%DOWNLOAD_DIR%\Riot-Client" 2>nul
if errorlevel 1 (
    winget download --id RiotGames.Valorant.EU --download-folder "%DOWNLOAD_DIR%\Riot-Client" 2>nul
)

REM 47. Rustup
echo [47/68] Rustup
winget download --id Rustlang.Rustup --download-folder "%DOWNLOAD_DIR%\Rustup" 2>nul

REM 48. Samsung Magician
echo [48/68] Samsung Magician
winget download --id Samsung.SamsungMagician --download-folder "%DOWNLOAD_DIR%\Samsung-Magician" 2>nul

REM 49. Shutter
echo [49/68] Shutter
echo   ^> Non disponible sur winget - téléchargement manuel requis

REM 50. Stardock Multiplicity
echo [50/68] Stardock Multiplicity
echo   ^> Non disponible sur winget - téléchargement manuel requis
echo   ^> https://www.stardock.com/

REM 51. Stardock Start11
echo [51/68] Stardock Start11
winget download --id Stardock.Start11 --download-folder "%DOWNLOAD_DIR%\Start11" 2>nul

REM 52. Steam
echo [52/68] Steam
winget download --id Valve.Steam --download-folder "%DOWNLOAD_DIR%\Steam" 2>nul

REM 53. TeamViewer
echo [53/68] TeamViewer
winget download --id TeamViewer.TeamViewer --download-folder "%DOWNLOAD_DIR%\TeamViewer" 2>nul

REM 54. TreeSize
echo [54/68] TreeSize
winget download --id JAMSoftware.TreeSize.Free --download-folder "%DOWNLOAD_DIR%\TreeSize" 2>nul

REM 55. Ubisoft Connect
echo [55/68] Ubisoft Connect
winget download --id Ubisoft.Connect --download-folder "%DOWNLOAD_DIR%\Ubisoft-Connect" 2>nul

REM 56. UltraSearch
echo [56/68] UltraSearch
winget download --id JAMSoftware.UltraSearch --download-folder "%DOWNLOAD_DIR%\UltraSearch" 2>nul

REM 57. UniGetUI
echo [57/68] UniGetUI
winget download --id MartiCliment.UniGetUI --download-folder "%DOWNLOAD_DIR%\UniGetUI" 2>nul

REM 58. Visual Studio Community 2026
echo [58/68] Visual Studio Community 2026
winget download --id Microsoft.VisualStudio.2022.Community --download-folder "%DOWNLOAD_DIR%\Visual-Studio" 2>nul

REM 59. VLC media player
echo [59/68] VLC media player
winget download --id VideoLAN.VLC --download-folder "%DOWNLOAD_DIR%\VLC" 2>nul

REM 60. VMware Workstation
echo [60/68] VMware Workstation
winget download --id VMware.WorkstationPro --download-folder "%DOWNLOAD_DIR%\VMware" 2>nul
if errorlevel 1 (
    echo   ^> Non disponible - téléchargement manuel requis
    echo   ^> https://www.vmware.com/
)

REM 61. Wargaming.net Game Center
echo [61/68] Wargaming.net Game Center
winget download --id Wargaming.GameCenter --download-folder "%DOWNLOAD_DIR%\Wargaming" 2>nul

REM 62. Warp
echo [62/68] Warp
winget download --id Warp.Warp --download-folder "%DOWNLOAD_DIR%\Warp" 2>nul

REM 63. WinSCP
echo [63/68] WinSCP
winget download --id WinSCP.WinSCP --download-folder "%DOWNLOAD_DIR%\WinSCP" 2>nul

REM 64. Wondershare Recoverit
echo [64/68] Wondershare Recoverit
winget download --id Wondershare.Recoverit --download-folder "%DOWNLOAD_DIR%\Recoverit" 2>nul
if errorlevel 1 (
    echo   ^> Non disponible - téléchargement manuel requis
    echo   ^> https://recoverit.wondershare.com/
)

REM 65. UPDF
echo [65/68] UPDF
winget download --id Superace.UPDF --download-folder "%DOWNLOAD_DIR%\UPDF" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\UPDF-Setup.exe" "https://www.updf.com/downloads/updf-win.exe" 2>nul
)

REM 66. Docker Desktop
echo [66/68] Docker Desktop
winget download --id Docker.DockerDesktop --download-folder "%DOWNLOAD_DIR%\Docker-Desktop" 2>nul
if errorlevel 1 (
    curl -L -o "%DOWNLOAD_DIR%\Docker-Desktop-Installer.exe" "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe" 2>nul
)

REM 67. NanaZip
echo [67/68] NanaZip
winget download --id M2Team.NanaZip --download-folder "%DOWNLOAD_DIR%\NanaZip" 2>nul
if errorlevel 1 (
    echo   ^> Non disponible - téléchargement manuel requis
    echo   ^> https://github.com/M2Team/NanaZip/releases
)

echo.
echo ===============================================
echo Téléchargements terminés!
echo ===============================================
echo.
echo Les fichiers sont dans: %DOWNLOAD_DIR%
echo.
echo Programmes nécessitant un téléchargement manuel:
echo - Bitdefender Total Security (si non disponible)
echo - DisplayLink Graphics
echo - QNAP Qsync Client
echo - Shutter
echo - Stardock Multiplicity
echo - VMware Workstation (si non disponible)
echo.
pause
