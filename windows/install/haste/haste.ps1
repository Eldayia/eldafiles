#!/usr/bin/env pwsh
# Script pour uploader du texte vers https://paste.eldadev.fr

param(
    [Parameter(ValueFromPipeline=$true)]
    [string]$InputText
)

begin {
    $lines = @()
}

process {
    if ($InputText) {
        $lines += $InputText
    }
}

end {
    if ($lines.Count -eq 0) {
        Write-Error "Aucune entrée fournie. Utilisez: command | haste"
        exit 1
    }

    $content = $lines -join "`n"
    
    try {
        $response = Invoke-RestMethod -Uri "https://paste.eldadev.fr/documents" `
                                       -Method Post `
                                       -Body $content `
                                       -ContentType "text/plain; charset=utf-8"
        
        if ($response.key) {
            $url = "https://paste.eldadev.fr/$($response.key)"
            Write-Host $url
            
            # Copier l'URL dans le presse-papiers (optionnel)
            if (Get-Command Set-Clipboard -ErrorAction SilentlyContinue) {
                Set-Clipboard $url
                Write-Host "URL copiée dans le presse-papiers!" -ForegroundColor Green
            }
        } else {
            Write-Error "Erreur: réponse inattendue du serveur"
            exit 1
        }
    }
    catch {
        Write-Error "Erreur lors de l'upload: $_"
        exit 1
    }
}
