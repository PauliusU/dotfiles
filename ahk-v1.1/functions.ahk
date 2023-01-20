#NoEnv
#SingleInstance, Force ; Replace the old instance
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

OpenAppOrFile(pathToOpen, winName) {
    ; "Activate window if exists, otherwise open it
    ; "2" - window's title can contain WinTitle anywhere inside it to be a match
    SetTitleMatchMode, 2
    if WinExist(winName) {
        WinActivate
        WinMaximize
    } else {
        Run, %pathToOpen%, , max ; run maximized
        WinActivate, %winName%
    }
    return
}

EmptyRecycleBin() {
    ; Empty Recycle Bin if it is active
    ; 2: A window's title can contain WinTitle anywhere inside it to be a match
    SetTitleMatchMode, 2
    if WinActive("Recycle Bin") {
        FileRecycleEmpty
    }
    return
}

TurnOffCapsLock() {
    SetCapsLockState, AlwaysOff
    Msgbox, , OFF, CapsLock is OFF, 0.3
    return
}

TurnOnCapsLock() {
    SetCapsLockState, AlwaysOn
    Msgbox, , ON, CapsLock is OFF, 0.3
    return
}

ToggleHiddenFiles() {
    ; Toggle showing hidden files in File Explorer (previously known as Windows Explorer)

    RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
    if (HiddenFiles_Status = 2) {
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
        MsgBox, , , Showing hidden files, 1
    } else {
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
        MsgBox, , , Not showing hidden files (back to default), 1
    }

    if WinActive("ahk_exe explorer.exe") {
        Send, {F5}
    }

    return
}

OpenYoutube() {
    ; Open Youtube URL in player locally

    global PLAYER
    global YOUTUBE_PLAYLIST

    if (GetKeyState("Shift", "P")) {
        Run, %PLAYER% --ytdl-format=bestvideo[height<=1080]+bestaudio/best %YOUTUBE_PLAYLIST%
        MsgBox, , Launching in player, Playlist is loading, 6
        WinActive("ahk_exe mpv.exe")
    } else {
        if WinActive("ahk_class Chrome_WidgetWin_1") or WinActive("ahk_class MozillaWindowClass") {
            ; If Chromium based browser or Firefox is  active
            Send, ^l ; Go to address bar
            Sleep, 100
            Send, ^c ; Copy URL
            Sleep, 100
            if ErrorLevel {
                MsgBox, The attempt to copy text onto the clipboard failed.
                return
            }
        }
        Run, %PLAYER% --ytdl-format=bestvideo[height<=1080]+bestaudio/best %clipboard%
        MsgBox, , Launching in player, Clipboard:`n%clipboard%, 0.9
    }
    return
}
