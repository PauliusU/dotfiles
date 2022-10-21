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