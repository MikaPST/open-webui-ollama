# 🤖 Open-WebUI with Ollama: Installation and Configuration for Windows 📦
[🇫🇷 Read in French](README_FR.md) | [🇬🇧 Read in English](README.md)

This PowerShell script automates the installation and configuration of Open-WebUI with Ollama. It checks prerequisites, installs dependencies, downloads required models, and launches a Docker container.

## 🌟 Script Features

- 🛠️ Verification and installation of prerequisites (Docker Desktop and Ollama).
- 📥 Download of required LLM models.
- 🚀 Automatic deployment of a Docker container configured for Open-WebUI.

## 📋 Prerequisites

- **Recommended hardware configuration**  
  - Memory (RAM): Minimum 8 GB, 16 GB or more recommended.  
  - Storage: At least ~15 GB of free space.  
  - Processor: A relatively modern CPU (from the last 5 years).  
- **Windows 11 or later** with PowerShell installed.  
- **Docker Desktop** installed and functional. [(Download Docker Desktop)](https://www.docker.com/products/docker-desktop/)

## 📥 Usage

1. Ensure Docker Desktop is properly installed.  
2. Download the `.zip` archive of the project and extract it. [(Download the .zip archive)](https://github.com/MikaPST/open-webui-ollama/archive/refs/heads/main.zip)  
3. Open a PowerShell console by pressing `WINDOWS`+`R` and typing `powershell`.  
4. Navigate to the `install_windows` folder from the PowerShell console.  
5. Run the following command:  

```powershell
powershell.exe -ExecutionPolicy Bypass .\install_open-webui_windows.ps1
```

## 🔧 Configurable Variables

No prior configuration is required. The script automatically manages dependency verification and updates.

## 🤝 Contribution
Contributions are welcome! Feel free to open an issue or submit a pull request.
