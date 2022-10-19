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
