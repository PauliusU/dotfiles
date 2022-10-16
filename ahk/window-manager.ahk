/*
Window management (wm) functions
*/
#NoEnv
#SingleInstance, Force ; Replace the old instance
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; Window tiling

FullScreen() {
    ; Maximizes window even over taskbar (taskbar is not visible)
    WinRestore, A
    WinMove, A, , 0, 0, A_ScreenWidth, A_ScreenHeight
    return
}

MaximizeActiveWindow() {
    ; Maximizes windows but keeps taksbar visible
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
