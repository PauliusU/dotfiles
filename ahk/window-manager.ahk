#NoEnv
#SingleInstance, Force ; Replace the old instance
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

MaximizeActiveWindow() {
    WinMaximize, A ; A stands for active window
    Return
}
