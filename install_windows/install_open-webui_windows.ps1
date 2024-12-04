# -------------------------------------------------------------------------
# Script Name   : script_install.ps1
# Description   : Ce script automatise l'installation et la configuration d'Open-WebUI avec Ollama,
#                 en vérifiant les prérequis comme Docker et Ollama, en installant ou mettant à jour
#                 ces composants si nécessaire, en téléchargeant les modèles requis,
#                 et en démarrant un conteneur Docker pour l'application Open-WebUI.
# Author        : Michael PASTOR
# Last Modified : 2024/12/02
# Version       : 1.0
# License       : Apache 2.0
# -------------------------------------------------------------------------


# Fonction pour verifier si une commande est disponible
function Is-CommandAvailable {
    param (
        [string]$Command
    )
    return (Get-Command $Command -ErrorAction SilentlyContinue) -ne $null
}

# Fonction pour verifier si Docker repond
function Is-DockerOperational {
    $result = & docker -v 2>$null
    return $result -like "*Docker version*"
}

# Fonction pour verifier si Ollama repond
function Is-OllamaOperational {
    $result = & ollama --version 2>$null
    return $result -like "*version*"
}

Write-Host "=== Installation et Configuration de Open-WebUI avec Ollama ===" -ForegroundColor Cyan

# Etape 1 : Verification de Docker Desktop
Write-Host "Verification de Docker Desktop..." -ForegroundColor Yellow
if (-not (Is-CommandAvailable -Command "docker")) {
    Write-Host "Docker Desktop n'est pas installe sur ce systeme." -ForegroundColor Red
    Write-Host "Veuillez telecharger et installer Docker Desktop depuis le lien suivant :" -ForegroundColor Yellow
    Write-Host "https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe" -ForegroundColor Cyan
    Write-Host "Une fois Docker Desktop installe et lance, appuyez sur [Entree] pour continuer..."
    Read-Host
} else {
    Write-Host "Docker Desktop est deja installe." -ForegroundColor Green
}

# Verification si Docker Desktop est lance
Write-Host "Verification de l'etat de Docker Desktop..." -ForegroundColor Yellow
if (-not (docker info -ErrorAction SilentlyContinue)) {
    Write-Host "Docker Desktop ne semble pas lance." -ForegroundColor Red
    Write-Host "Veuillez lancer Docker Desktop manuellement et vous assurer que son interface graphique est bien ouverte." -ForegroundColor Yellow
    Write-Host "Veuillez confirmer que Docker Desktop est bien lance pour continuer. (Y/N)" -ForegroundColor Cyan
    $confirmation = Read-Host
    if ($confirmation -notmatch '^(Y|y)$') {
        Write-Host "Arret du script. Veuillez verifier Docker Desktop avant de relancer." -ForegroundColor Red
        exit
    }
}
Write-Host "Docker Desktop est lance. Continuation du script." -ForegroundColor Green

# Etape 2 : Verification et installation d'Ollama
Write-Host "Verification de l'installation d'Ollama..." -ForegroundColor Yellow
if (-not (Is-CommandAvailable -Command "ollama")) {
    Write-Host "Ollama n'est pas installe. Installation en cours..." -ForegroundColor Yellow
    winget install --id Ollama.Ollama -e --accept-source-agreements --accept-package-agreements
} else {
    Write-Host "Ollama est deja installe. Mise a jour en cours..." -ForegroundColor Green
    winget upgrade --id Ollama.Ollama -e --accept-source-agreements --accept-package-agreements
}

# Verification si Ollama est operationnel
Write-Host "Verification de l'etat d'Ollama..." -ForegroundColor Yellow
$ollamaReady = $false
$duration = 30 # Duree de la verification en secondes
for ($i = 0; $i -le $duration; $i++) {
    $percent = [math]::Round(($i / $duration) * 100)
    Write-Progress -Activity "Verification d'Ollama" -Status "$percent% complete" -PercentComplete $percent
    if (Is-OllamaOperational) {
        $ollamaReady = $true
        break
    }
    Start-Sleep -Seconds 1
}

if (-not $ollamaReady) {
    Write-Host "Ollama ne semble pas operationnel." -ForegroundColor Red
    Write-Host "Veuillez demarrer Ollama manuellement puis appuyez sur [Entree] pour continuer." -ForegroundColor Yellow
    Read-Host
}

Write-Host "Ollama est operationnel !" -ForegroundColor Green

# Etape 3 : Telechargement des modeles
Function DownloadModel($modelName) {
    Write-Host "Voulez-vous telecharger le modele $modelName ? (Y/N)" -ForegroundColor Cyan
    $response = Read-Host
    if ($response -eq "Y" -or $response -eq "y") {
        Write-Host "Telechargement du modele $modelName en cours..." -ForegroundColor Yellow
        & ollama pull $modelName
        if ($?) {
            Write-Host "Modele $modelName telecharge avec succes." -ForegroundColor Green
        } else {
            Write-Host "Echec du telechargement du modele $modelName." -ForegroundColor Red
        }
    } else {
        Write-Host "Modele $modelName ignore." -ForegroundColor Yellow
    }
}

DownloadModel "llama3.1"
DownloadModel "mistral"

# Etape 4 : Demarrage du conteneur Docker pour Open-WebUI
Write-Host "Demarrage du conteneur Open-WebUI..." -ForegroundColor Yellow
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=http://host.docker.internal:11434 -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main

# Initialisation avec barre de progression
Write-Host "Initialisation du conteneur Open-WebUI..." -ForegroundColor Yellow
$duration = 60 # Duree en secondes
for ($i = 0; $i -le $duration; $i++) {
    $percent = [math]::Round(($i / $duration) * 100)
    Write-Progress -Activity "Initialisation" -Status "$percent% complete" -PercentComplete $percent
    Start-Sleep -Seconds 1
}

# Etape finale : Affichage de l'URL d'acces
Write-Host "Conteneur Open-WebUI demarre avec succes." -ForegroundColor Green
Write-Host "Votre application est accessible ici : http://localhost:3000" -ForegroundColor Cyan
