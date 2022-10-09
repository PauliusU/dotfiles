/*
AHK main entry point
Used to import other modules and set keyboar shortcuts in single place
Syntax: AutoHotkey v1.1 (originally called AutoHotkey_L)
*/
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
; Window management
CapsLock & Enter:: MaximizeActiveWindow()
![:: PreviousWindow()
!]:: NextWindow()
^#,:: NextWindow()
^#.:: PreviousWindow()
^#WheelDown:: PreviousWindow()
^#WheelUp:: NextWindow()