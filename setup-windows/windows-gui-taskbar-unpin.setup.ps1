function Unpin-App([string]$appname) {
    <#
    .SYNOPSIS
        Unpin apps from taskbar.
    .DESCRIPTION
        Works with Windows 11 22H2, except for "File Explorer".
    .PARAMETER appname
        Could be single or multiple name, with or without REGEX. View examples.
    .EXAMPLE
        Unpin-App("Microsoft Edge")
        Unpin-App("^Microsoft Edge$")
        Unpin-App("^Microsoft Edge$|^Microsoft Store$|^File Explorer$|^Windows Explorer$|^Explorer$")
    .LINK
        https://stackoverflow.com/questions/45152335/unpin-the-microsoft-edge-and-store-taskbar-shortcuts-programmatically
    .NOTES
        To view "Applications" and available actions run: shell:::{4234d49b-0245-4df3-b780-3893943456e1}
    #>

    Write-Output "Unpin $appname"
    ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() |
        Where-Object { $_.Name -match $appname }).Verbs() |
    Where-Object { $_.Name.replace('&', '') -match 'Unpin from taskbar|Von "Start" lösen' } |
    ForEach-Object { $_.DoIt() }
}

Unpin-App("Chat")
Unpin-App("Microsoft Edge")
Unpin-App("Microsoft Store")
Unpin-App("File Explorer") # Does not support unpin!
Write-Output "Unpin from taskbar done"
