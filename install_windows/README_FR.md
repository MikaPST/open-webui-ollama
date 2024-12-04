# 🤖 Open-WebUI avec Ollama : Installation et Configuration pour Windows 📦
[🇫🇷 Lire en Français](README_FR.md) | [🇬🇧 Read in English](README.md)

Ce script PowerShell automatise l'installation et la configuration d'Open-WebUI avec Ollama. Il vérifie les prérequis, installe les dépendances, télécharge les modèles nécessaires, et démarre un conteneur Docker.

## 🌟 Fonctionnalités du Script

- 🛠️ Vérification et installation des prérequis (Docker Desktop et Ollama).
- 📥 Téléchargement des modèles LLM nécessaires.
- 🚀 Déploiement automatique d'un conteneur Docker configuré pour Open-WebUI.

## 📋 Prérequis

- **Configuration matériel recommandée**
  - Mémoire (RAM) : 8 Go minimum, 16 Go ou plus recommandés.
  - Stockage : Au moins ~15 Go d'espace libre.
  - Processeur : Un CPU relativement moderne (des 5 dernières années).
- **Windows 11 ou supérieur** avec PowerShell installé.
- **Docker Desktop** installé et fonctionnel. [(Télécharger Docker Desktop)](https://www.docker.com/products/docker-desktop/)

## 📥 Utilisation

1. Assurez-vous que Docker Desktop est correctement installé.
2. Téléchargez l'archive `.zip` du projet et décompressez le. [(Télécharger l'archive .zip)](https://github.com/MikaPST/open-webui-ollama/archive/refs/heads/main.zip)
3. Ouvrez une console powershell avec les touches `WINDOWS`+`R` et en écrivant `powershell`.
4. Depuis la console PowerShell placez vous dans le dossier `install_windows`.
4. Exécutez la commande suivante :

```powershell
powershell.exe -ExecutionPolicy Bypass .\install_open-webui_windows.ps1
```

## 🔧 Variables Configurables

Aucune configuration préalable n'est nécessaire. Le script gère automatiquement la vérification des dépendances et les mises à jour.

## 🤝 Contribution
Les contributions sont les bienvenues! N'hésitez pas à ouvrir une issue ou à soumettre une pull request.
