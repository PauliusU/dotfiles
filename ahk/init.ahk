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

; Nofity that script has loaded
MsgBox, , , AHK, 0.4 

; Imports
#Include, %A_ScriptDir%\functions.ahk
#Include, %A_ScriptDir%\sound.ahk
#Include, %A_ScriptDir%\window-manager.ahk
#Include, %A_ScriptDir%\private\MAIN.ahk

; Keyboard shortcuts

; AHK Control
^!+F5:: Reload ; Reload AHK script

; Window management (Alt-Win based)
#!T:: TaskbarToggle(hide := !hide)
!#Enter:: MaximizeActiveWindow()
CapsLock & Enter:: FullScreen()
!#[:: PreviousWindow()
!#]:: NextWindow()
!#WheelDown:: PreviousWindow()
!#WheelUp:: NextWindow()

; Sound
; Volume control - mute, increase or decrease sound level
^#Up:: Send, {Volume_Up 6}
^#Down:: Send, {Volume_Down 6}
^+#Up:: Send, {Volume_Up 20}
^+#Down:: Send, {Volume_Down 20}
^#NumpadAdd:: Send, {Volume_Up 3}
^#NumpadSub:: Send, {Volume_Down 3}
^+#NumpadAdd:: Send, {Volume_Up 10}
^+#NumpadSub:: Send, {Volume_Down 10}
!#Numpad0:: Send, {Volume_Mute}
^#NumpadEnter:: Run, "C:\Windows\System32\SndVol.exe" ; Volume mixer
^+#WheelUp:: Send, {Volume_Up 3}
^+#WheelDown:: Send, {Volume_Down 3}
; Media keys
#F6::Send, {Media_Stop}
#F7::Send, {Media_Prev}
#F8::Send, {Media_Play_Pause}
#F9::Send, {Media_Next}
; Playback devices
ScrollLock & Q:: setSoundDevice("Headphones")
ScrollLock & W:: setSoundDevice("Speakers")
ScrollLock & S:: toggleSoundDevice("Headphones", "Speakers")
