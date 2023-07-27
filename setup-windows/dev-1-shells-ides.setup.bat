@ECHO OFF &:: Clean output and hide path of running command

TITLE IDEs, shells and programming tools

TITLE Shells and terminals

ECHO **** Nerd fonts and PowerLine fonts [ADMIN] ****
powershell scoop bucket add nerd-fonts
powershell sudo scoop install -g Cascadia-Code
powershell sudo scoop install -g CascadiaCode-NF-Mono
powershell sudo scoop install -g FiraCode-NF-Mono

ECHO **** Alacritty ****
powershell scoop install alacritty

ECHO **** Core utils ****
powershell scoop install coreutils

ECHO **** Git-Bash ****
MKLINK /J "%USERPROFILE%\.bashrc" "%DOTFILES%\terminal\.bashrc"

ECHO **** PowerShell ****
MKLINK /J "%USERPROFILE%\Documents\WindowsPowerShell" "%DOTFILES%\terminal\PowerShell"
powershell $PSVersionTable

ECHO **** SSH ****
MKLINK /J "%USERPROFILE%\.ssh" "%USER_BAK%\.ssh"

ECHO **** Windows Terminal ****
MKLINK /J "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\" "%DOTFILES%\terminal\WindowsTerminal"

TITLE IDEs and text editors

ECHO **** JetBrains ****
MKLINK /J "%APPDATA%\JetBrains" "%USER_BAK%\AppData\Roaming\JetBrains"
MKLINK /J "%LOCALAPPDATA%\JetBrains" "%USER_BAK%\AppData\Local\JetBrains"
:: TODO: test if installed IDEs integrate with OS properly
:: winget install JetBrains.Toolbox
powershell scoop install jetbrains-toolbox

ECHO **** Notepad++ ****
powershell scoop install notepadplusplus
REG IMPORT "%SCOOP%\apps\notepadplusplus\current\install-context.reg"
ASSOC .ini=inifile
FTYPE inifile="%SCOOP%\apps\notepadplusplus\current\notepad++.exe" "%%1"
ASSOC .md=markdown
FTYPE markdown="%SCOOP%\apps\notepadplusplus\current\notepad++.exe" "%%1"
ASSOC .nfo=MSInfoFile
FTYPE MSInfoFile="%SCOOP%\apps\notepadplusplus\current\notepad++.exe" "%%1"
ASSOC .txt=txtfile
FTYPE txtfile="%SCOOP%\apps\notepadplusplus\current\notepad++.exe" "%%1"
REG ADD "HKEY_CLASSES_ROOT\txtfile\DefaultIcon" /ve /t REG_EXPAND_SZ /d "C:\Windows\System32\Shell32.dll,260" /f
:: List extensions containing "txtfile" [.txt, .exc, .txt]
assoc | findstr /i "txtfile"

ECHO **** Neovim ****
MKLINK /J "%LOCALAPPDATA%\nvim" "%DOTFILES%\nvim"
powershell scoop install neovim
nvim --version
git clone https://github.com/wbthomason/packer.nvim "%LOCALAPPDATA%\nvim-data\site\pack\packer\start\packer.nvim"
:: Neovim dependencies
:: fzf, telescope and other search tools use ripgrep and fd
powershell scoop install ripgrep
powershell scoop install fd
:: C and C++ compiler for LSP dependencies
powershell scoop install gcc
g++ --version

ECHO **** Visual Studio Code [VSCode] ****
powershell scoop install vscode
REG IMPORT "%SCOOP%\apps\vscode\current\install-context.reg"
REG IMPORT "%SCOOP%\apps\vscode\current\install-associations.reg"
powershell code -v

TITLE DBs

ECHO **** DB Browser for SQLite ****
powershell scoop install sqlitebrowser

ECHO **** TablePlus ****
powershell scoop install tableplus

ECHO **** MongoDB ****
MKLINK /J "%LOCALAPPDATA%\mongodb" "%USER_BAK%\AppData\Local\mongodb"
MKLINK /J "%APPDATA%\MongoDB Compass" "%USER_BAK%\AppData\Roaming\MongoDB Compass"
powershell scoop install mongodb-compass
powershell scoop install mongosh

TITLE Other programming tools

ECHO **** AWS CLI ****
MKLINK /J "%USERPROFILE%\.aws\" "d:\Dropbox\dev\config\.aws"
powershell scoop install aws
aws --version

ECHO **** GitHub CLI ****
powershell scoop install gh
gh --version

ECHO **** Postman ****
powershell scoop install postman

TITLE Virtualization

ECHO **** Docker ****
MKLINK /J "%APPDATA%\Docker" "%USER_BAK%\AppData\Roaming\Docker"
MKLINK /J "%APPDATA%\Docker Desktop" "%USER_BAK%\AppData\Roaming\Docker Desktop"
MKLINK /J "%LOCALAPPDATA%\Docker" "%USER_BAK%\AppData\Local\Docker"
winget install Docker.DockerDesktop
docker --version
:: Disable running Docker Desktop at startup
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Docker Desktop" /f

ECHO **** WSL ****
:: Install recommended Windows Subsystem for Linux features
wsl.exe --install
:: Update WSL Linux kernel
wsl --update
:: See WSL and kernel version
wsl --status