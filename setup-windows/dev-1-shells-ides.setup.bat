@ECHO OFF &:: Clean output and hide path of running command

TITLE IDEs, shells and programming tools

TITLE Shells and terminals

ECHO **** Nerd fonts [ADMIN] ****
powershell scoop bucket add nerd-fonts
powershell sudo scoop install -g CascadiaCode-NF-Mono
powershell sudo scoop install -g FiraCode-NF-Mono
powershell sudo scoop install -g JetBrainsMono-NF

ECHO **** Alacritty ****
powershell scoop install alacritty

ECHO **** Core utils ****
:: Basic cli tools (rm, cat, ls, etc.) used on Unix-like operating systems
powershell scoop install coreutils
:: Bat - a cat clone with syntax highlighting and Git integration
powershell scoop install bat
:: LSDeluxe - ls with colors, icons, tree-view, etc.
powershell scoop install lsd

ECHO **** Git-Bash ****
MKLINK /J "%USERPROFILE%\.bashrc" "%DOTFILES%\terminal\.bashrc"
:: Symlink works (not /J folder junction)
MKLINK "%SCOOP%\apps\git\current\usr\bin\tmux-sessionizer" "%DOTFILES%\terminal\tmux-sessionizer.sh"
:: # ln -sf "$DOTFILES\scripts\private\info.sh" "$SCOOP\apps\git\current\usr\bin\info"
:: # ln -sf "$DOTFILES\scripts\updater.sh" "$SCOOP\apps\git\current\usr\bin\updater"
:: Git-bash depencencies
:: Fuzzy find directories for path-switcher
powershell scoop install fzf

ECHO **** PowerShell ****
MKLINK /J "%USERPROFILE%\Documents\WindowsPowerShell" "%DOTFILES%\terminal\PowerShell"
powershell $PSVersionTable

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
MKLINK /J "%USERPROFILE%\.config\nvim" "%DOTFILES%\nvim"
powershell scoop install neovim
nvim --version
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

ECHO **** Git tools ****
powershell scoop install lazygit
IF NOT EXIST "%APPDATA%\jesseduffield\" MKDIR "%APPDATA%\jesseduffield\"
MKLINK /J "%APPDATA%\jesseduffield\lazygit\" "%DOTFILES%\terminal\lazygit"
:: Git-delta. git diff | delta
powershell scoop install delta

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

ECHO **** Rust ****
powershell scoop install rustup
winget install Microsoft.VisualStudio.2022.BuildTools
rustc --version
cargo --version

ECHO **** Go ****
powershell scoop install go
go version
