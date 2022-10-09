/*
Window management (wm) functions
*/
#NoEnv
#SingleInstance, Force ; Replace the old instance
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

MaximizeActiveWindow() {
    WinMaximize, A ; A stands for active window
    return
}

; Window switching

NextWindow() {
    ; Switch to next window by sending Alt-Esc
    Send !{Esc}
    return
}

PreviousWindow() {
    ; Switch to previous window by sending Alt-Shift-Esc
    Send !+{Esc} 
    return
}
