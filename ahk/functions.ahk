OpenAppOrFile(pathToOpen, winName) {
    ; 'Activate window if exists, otherwise open it
    ; '2' - window's title can contain WinTitle anywhere inside it to be a match
    SetTitleMatchMode(2)
    if WinExist(winName) {
        WinActivate
        WinMaximize
    } else {
        Run(pathToOpen, , 'max')    ; run maximized
        ; WinActivate(winName)
    }
    return
}

EmptyRecycleBin() {
    ; Empty Recycle Bin if it is active
    ; 2: A window's title can contain WinTitle anywhere inside it to be a match
    SetTitleMatchMode(2)
    if WinActive('Recycle Bin') {
        FileRecycleEmpty
    }
    return
}

TurnOffCapsLock() {
    SetCapsLockState('AlwaysOff')
    Msgbox('CapsLock is OFF', 'OFF', 'T0.3')
    return
}

TurnOnCapsLock() {
    SetCapsLockState('AlwaysOn')
    Msgbox('CapsLock is ON', 'ON', 'T0.3')
    return
}

SetKeyboard(layout) {
    ; Set keyboard layout of active window
    ; layout - hexadecimal language/region ID. For list of available IDs see:
    ; https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows?view=windows-11

    WM_INPUTLANGCHANGEREQUEST := 0x0050
    PostMessage(WM_INPUTLANGCHANGEREQUEST, 0, layout, , "A")
    SoundBeep(750, 900)
    return
}

ToggleHiddenFiles() {
    ; Toggle showing hidden files in File Explorer (previously known as Windows Explorer)

    HiddenFiles_Status := RegRead('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced', 'Hidden')
    if (HiddenFiles_Status = 2) {
        RegWrite(1, 'REG_DWORD', 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced', 'Hidden')
        MsgBox('Showing hidden files', , 'T1')
    } else {
        RegWrite(2, 'REG_DWORD', 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced', 'Hidden')
        MsgBox('Not showing hidden files (back to default)', , 'T1')
    }

    if WinActive('ahk_exe explorer.exe') {
        Send('{F5}')
    }

    return
}

OpenYoutube() {
    ; Open Youtube URL in player locally

    global PLAYER
    global YOUTUBE_PLAYLIST

    if (GetKeyState('Shift', 'P')) {
        Run(PLAYER . ' --ytdl-format=bestvideo[height<=1080]+bestaudio/best ' . YOUTUBE_PLAYLIST)
        MsgBox('Playlist is loading', 'Launching in player', 'T6')
        WinActive('ahk_exe mpv.exe')
    } else {
        if WinActive('ahk_class Chrome_WidgetWin_1') or WinActive('ahk_class MozillaWindowClass') {
            ; If Chromium based browser or Firefox is  active
            Send('^l')    ; Go to address bar
            Sleep(100)
            Send('^c')    ; Copy URL
            Sleep(100)
            ; An exception is thrown on failure instead of setting ErrorLevel in AHK v2
            ; if (ErrorLevel) {
            ;     MsgBox('The attempt to copy text onto the clipboard failed.')
            ;     return
            ; }
        }
        Run(PLAYER . ' --ytdl-format=bestvideo[height<=1080]+bestaudio/best ' . A_Clipboard)
        MsgBox('Clipboard:`n' . A_Clipboard, 'Launching in player', 'T0.9')
    }
    return
}
