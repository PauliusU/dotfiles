; AHK main entry point

#NoEnv
#SingleInstance, Force ; Replace the old instance
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

MsgBox, , , AHK, 0.4 ; Nofity that script has loaded

; Imports
#Include, %A_ScriptDir%\window-manager.ahk
#Include, %A_ScriptDir%\private\MAIN.ahk

; Keyboard shortcuts
CapsLock & Enter:: MaximizeActiveWindow()