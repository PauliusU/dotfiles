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
#Include, %A_ScriptDir%\variables.ahk
#Include, %A_ScriptDir%\functions.ahk
#Include, %A_ScriptDir%\sound.ahk
#Include, %A_ScriptDir%\text-code.ahk
#Include, %A_ScriptDir%\text-date-time.ahk
#Include, %A_ScriptDir%\text-manipulation.ahk
#Include, %A_ScriptDir%\window-manager.ahk
#Include, %A_ScriptDir%\private\MAIN.ahk

; Keyboard shortcuts

; AHK Control
^!#F5:: Reload ; Reload AHK script

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
ScrollLock & Q:: SetSoundDevice("Headphones")
ScrollLock & W:: SetSoundDevice("Speakers")

; Apps, folders and files
CapsLock & A:: OpenAppOrFile(TERMINAL, "ahk_exe WindowsTerminal.exe")
CapsLock & B:: OpenAppOrFile(USER_HOME . "\scoop\apps\mongodb-compass\current\MongoDBCompass.exe", "ahk_exe MongoDBCompass.exe")
CapsLock & C:: OpenAppOrFile(CHROME, "ahk_exe chrome.exe")
CapsLock & D:: OpenAppOrFile(EDITOR_VISUAL, "ahk_exe Code.exe")
CapsLock & E:: return
CapsLock & F:: OpenAppOrFile(BROWSER, "ahk_class MozillaWindowClass")
CapsLock & G:: OpenAppOrFile(BROWSER . " mail.google.com/mail/", "Gmail")
CapsLock & H:: return
CapsLock & I:: OpenAppOrFile(IMAGE_VIEWER, "IrfanView")
CapsLock & J:: return
CapsLock & K:: OpenAppOrFile(USER_HOME . "\scoop\apps\ferdi\current\Ferdi.exe", "Ferdi")
CapsLock & L:: OpenAppOrFile(BROWSER . " calendar.google.com", "Google Calendar")
CapsLock & N:: Run, %EDITOR_VISUAL% %NOTES%
CapsLock & O:: Run, %EDITOR_VISUAL% %DOTFILES%
CapsLock & Q:: ToggleSoundDevice("Headphones", "Speakers")
CapsLock & R:: return
CapsLock & S:: OpenAppOrFile(FILE_MANAGER, "ahk_exe TOTALCMD64.EXE")
CapsLock & T:: OpenAppOrFile("d:\Dropbox\soft\todotxt.net\todotxt.exe", "todotxt.net")
CapsLock & U:: OpenAppOrFile(USER_HOME . "\scoop\apps\anki\current\anki.exe", "Anki")
CapsLock & V:: OpenAppOrFile(VIVALDI " --start-fullscreen" , "ahk_exe vivaldi.exe")
CapsLock & W:: return
CapsLock & Y:: OpenAppOrFile(USER_HOME . "\scoop\apps\toggl\current\TogglDesktop.exe", "ahk_exe TogglDesktop.exe")
CapsLock & Z:: OpenAppOrFile(FILE_SEARCH, "ahk_exe Everything64.exe")
CapsLock & Numpad0:: OpenAppOrFile(USER_HOME . "\Desktop", "Desktop")
CapsLock & Numpad1:: OpenAppOrFile("::{645FF040-5081-101B-9F08-00AA002F954E}", "Recycle Bin")
CapsLock & Numpad2:: EmptyRecycleBin()
CapsLock & Numpad3:: OpenAppOrFile(USER_HOME . "\Downloads", "Downloads")
CapsLock & Numpad4:: Run, "F:\dwn"
CapsLock & Numpad5:: Run, "d:\Dropbox\DropsyncFiles"
CapsLock & Numpad6:: OpenAppOrFile("D:\Dropbox\linked\shared_IL", "shared_IL")
CapsLock & Numpad7:: OpenAppOrFile("D:\Dropbox\DropsyncFiles\audiob\DBs\input.xlsx", "input")
CapsLock & Numpad8:: OpenAppOrFile(BROWSER . " drive.google.com", "Drive")
CapsLock & Numpad9:: OpenAppOrFile("D:\Dropbox\DropsyncFiles\audiob\DBs\input_charts.xlsx", "input_charts")
CapsLock & NumpadMult:: Run, "C:\Windows\SysWOW64\calc.exe" ; Calculator

Capslock:: TurnOffCapsLock()
+Capslock:: TurnOnCapsLock()

; Win-Fn
#F1:: Run, "%SCRIPTS_PATH%\processes-kill.bat"
#F2:: Run, "%SCRIPTS_PATH%\fs-backup.private.bat"
#F3:: Run, "%SCRIPTS_PATH%\fs-cleanup.private.bat"
#F5:: Run, %EDITOR_VISUAL% "d:\Dropbox\dev\utils"

; Ctrl-Alt-Win
^!#C:: ToEachCapitalized()
^!#D:: CurrentYearDay()
^!#F:: FullDate()
^!#G:: PathWindows()
^!#H:: CurrentDate()
^!#I:: ToInverted()
^!#J:: CurrentShortDate()
^!#K:: Run, C:\Windows\System32\osk.exe ; On screen keyboard
^!#L:: ToLowercase()
^!#N:: Run, control /name Microsoft.NetworkAndSharingCenter ; Network and sharing center
^!#O:: ToSentenceCase()
^!#T:: PathUnix()
^!#U:: ToUppercase()
^!#W:: CurrentWeek()
^!#F1:: Run, "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" ; PowerShell
^!#F2:: Run, "c:\Windows\System32\cmd.exe" ; Command Prompt (vanilla)
^!#F3:: Run, "c:\Windows\System32\cmd.exe" /K "%DOTFILES%\terminal\cmdrc.cmd" & @echo on ; Command Prompt (custom)
^!#F4:: OpenAppOrFile(TERMINAL, "ahk_exe WindowsTerminal.exe")
^!#Left:: Run, control ; classic Control Panel

^!Z:: OpenAppOrFile(TERMINAL, "ahk_exe WindowsTerminal.exe")
