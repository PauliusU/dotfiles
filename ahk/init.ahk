/*
AHK main entry point
Used to import other modules and set keyboard shortcuts in a single place
Syntax: AutoHotkey v1.1 (originally called AutoHotkey_L)
*/
#NoEnv
#SingleInstance, Force ; Replace the old instance
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; Startup
MsgBox, , , AHK, 0.4 ; Nofity that script has loaded
TaskbarToggle(true) ; Hide taskbar
SetNumLockState, on ; Turn on NumLock

; Imports
#Include, %A_ScriptDir%\functions.ahk
#Include, %A_ScriptDir%\sound.ahk
#Include, %A_ScriptDir%\variables.ahk
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

; Apps, folders and files
CapsLock & A:: OpenAppOrFile(TERMINAL, "ahk_exe WindowsTerminal.exe")
CapsLock & C:: OpenAppOrFile(CHROME, "ahk_exe chrome.exe")
CapsLock & D:: OpenAppOrFile(EDITOR_VISUAL, "ahk_exe Code.exe")
CapsLock & F:: OpenAppOrFile(BROWSER, "ahk_class MozillaWindowClass")
CapsLock & G:: OpenAppOrFile(BROWSER . " mail.google.com/mail/", "Gmail")
CapsLock & I:: OpenAppOrFile(IMAGE_VIEWER, "IrfanView")
CapsLock & K:: OpenAppOrFile(USER_HOME . "\scoop\apps\ferdi\current\Ferdi.exe", "Ferdi")
CapsLock & L:: OpenAppOrFile(BROWSER . " calendar.google.com", "Google Calendar")
CapsLock & N:: Run, %EDITOR_VISUAL% %NOTES%
CapsLock & O:: Run, %EDITOR_VISUAL% %DOTFILES%
CapsLock & Q:: toggleSoundDevice("Headphones", "Speakers")
CapsLock & S:: OpenAppOrFile(FILE_MANAGER, "ahk_exe TOTALCMD64.EXE")
CapsLock & T:: OpenAppOrFile("d:\Dropbox\soft\todotxt.net\todotxt.exe", "todotxt.net")
CapsLock & V:: OpenAppOrFile(VIVALDI " --start-fullscreen" , "ahk_exe vivaldi.exe")
CapsLock & Z:: OpenAppOrFile(FILE_SEARCH, "ahk_exe Everything64.exe")
Capslock:: TurnOffCapsLock()
+Capslock:: TurnOnCapsLock()

; Win-Fn
#F1:: Run, "%SCRIPTS_PATH%\processes-kill.bat"
#F2:: Run, "%SCRIPTS_PATH%\fs-backup.private.bat"
#F3:: Run, "%SCRIPTS_PATH%\fs-cleanup.private.bat"

; Ctrl-Win
^#Numpad0:: OpenAppOrFile(USER_HOME . "\Desktop", "Desktop")
^#Numpad1:: OpenAppOrFile("::{645FF040-5081-101B-9F08-00AA002F954E}", "Recycle Bin")
^#Numpad2:: EmptyRecycleBin()
^#Numpad3:: OpenAppOrFile(USER_HOME . "\Downloads", "Downloads")
^#Numpad4:: Run, "F:\dwn"

^#I:: Run, "d:\Dropbox\DropsyncFiles"
^#L:: OpenAppOrFile("D:\Dropbox\linked\shared_IL", "shared_IL")

; Ctrl-Alt-Win
^!#C:: ToEachCapitalized()
^!#I:: ToInverted()
^!#I:: FullDate()
^!#J:: CurrentShortDate()
^!#D:: CurrentYearDay()
^!#W:: CurrentWeek()
^!#H:: CurrentDate()
^!#G:: PathWindows()
^!#T:: PathUnix()
^!#K:: Run, C:\Windows\System32\osk.exe ; On screen keyboard
^!#L:: ToLowercase()
^!#N:: Run, control /name Microsoft.NetworkAndSharingCenter ; Network and sharing center
^!#O:: ToSentenceCase()
^!#U:: ToUppercase()
^+#Left:: Run, control ; classic Control Panel

#NumpadMult:: Run, "C:\Windows\SysWOW64\calc.exe" ; Calculatr, replaces magnifier 

^!Z:: OpenAppOrFile(TERMINAL, "ahk_exe WindowsTerminal.exe")
