# PowerShell config $profile

### Aliases ###

# Navigation
Set-Alias .. Set-ParentFolderLocation
Set-Alias ~~ Set-WD-To-Downloads
Set-Alias dev Set-WD-To-Dev
Set-Alias dwn Set-WD-To-Downloads

# Software management
Set-Alias si Use-ScoopInstall -force -option 'Constant','AllScope' # scoop install $args
Set-Alias sl Use-ScoopList  -force -option 'Constant','AllScope' # scoop list
Set-Alias ss Use-ScoopSearch # scoop search $args
Set-Alias su Use-ScoopUpdateAll # scoop update *
Set-Alias sun Use-ScoopUninstall # scoop uninstall $args

# Script control
Set-Alias bb Use-GitBash
Set-Alias cc Use-CMD # CMD /c
Set-Alias ee Quit
Set-Alias rr Get-ReloadedSettings

# Other aliases
Set-Alias -Name n -Value nvim
Set-Alias -Name v -Value nvim

### Functions ###

function Set-ParentFolderLocation() {
    # Navigate one folder up
    Set-Location ..
}

function Set-WD-To-Downloads() {
    # Set working directory to user's "Downloads" folder
    Set-Location $env:UserProfile\Downloads
}

function Set-WD-To-Dev() {
    # Set working directory to user's "dev" folder
    Set-Location D:\Dropbox\dev
}

function Use-CMD {
    # Run single CMD command and go back to PowerShell. /c - close, /k - keep
    cmd /c $args
}

function Use-GitBash {
    # Run single Git-Bash command and go back to PowerShell
    bash -c $args
}

function Use-ScoopInstall {
    # Install programs with scoop system
    scoop install $args
}

function Use-ScoopList {
    # List installed apps
    scoop list
}

function Use-ScoopSearch {
    # Searche for programs in scoop system
    scoop search $args
}

function Use-ScoopUpdateAll {
    # Update all programs in scoop system
    scoop update # update scoop itself
    scoop update * # update apps inside scoop
}

function Use-ScoopUninstall {
    # Uninstall a program in scoop system
    scoop uninstall $args
}

function Quit {
    # Exit form PowerShell
    Invoke-command -ScriptBlock { exit }
}

function Get-ReloadedSettings {
    # Reload PowerShell profile
    . $profile

    # Update PATH environment variable
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    # Update PowerShell session environment variables
    foreach ($level in "Machine", "User") {
        [Environment]::GetEnvironmentVariables($level)
    }

    refreshenv

    Write-Output 'PS Profile reloaded'
}

### Key bindings ###
Set-PSReadlineKeyHandler -Chord Ctrl+e -Function EndOfLine
Set-PSReadlineKeyHandler -Chord Ctrl+d -Function DeleteCharOrExit
# Ctrl+a overrides default 'select all'
# Set-PSReadlineKeyHandler -Chord Ctrl+a -Function BeginningOfLine

