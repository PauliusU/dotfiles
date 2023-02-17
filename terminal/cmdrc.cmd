@ECHO OFF &:: Clean output and hide path of running command
TITLE Custom CMD &:: Title is needed for AHK to auto close script
COLOR A &:: Color "bright green"
CD /D %USERPROFILE%\Downloads\

SET SCRIPTS=d:\Dropbox\code\dotfiles\scripts

:: -------------------------------- Navigation  --------------------------------
::      /D switch is necessary to allow CD to change drives
DOSKEY .. = CD ..
DOSKEY ... = CD ..\..
DOSKEY ~ = CD /D %USERPROFILE%
DOSKEY ~~ = CD /D %USERPROFILE%\Downloads
DOSKEY cde = CD /D d:\Dropbox\code
DOSKEY desk = CD /D %USERPROFILE%\Desktop
DOSKEY dev = CD /D d:\Dropbox\dev
DOSKEY docs = CD /D %USERPROFILE%\Documents
DOSKEY drb = CD /D %USERPROFILE%\Dropbox
DOSKEY dt = CD /D %USERPROFILE%\Desktop
DOSKEY dwn = CD /D %USERPROFILE%\Downloads

:: ------------------------------ Shell control --------------------------------
DOSKEY c = clear
DOSKEY ee = exit
DOSKEY ps = powershell -NoProfile $*

:: -------------------------------- coreutils ----------------------------------
:: DOSKEY ls = dir

:: -------------------------- Settings (Control apps) --------------------------
DOSKEY cbl = control /name Microsoft.BitLockerDriveEncryption
DOSKEY cnet = control.exe /name Microsoft.NetworkAndSharingCenter 
DOSKEY cpr = control printers &:: Devices and printers
DOSKEY cfh = control /name Microsoft.FileHistory

:: ---------------------------- Software management ----------------------------
DOSKEY si = scoop install $*
DOSKEY sl = scoop list
DOSKEY ss = scoop search $*
DOSKEY su = scoop update $*
DOSKEY sua = scoop update *
DOSKEY sun = scoop uninstall $*
DOSKEY wi = winget install $*
DOSKEY ws = winget search $*
DOSKEY wun = winget uninstall $*

:: ----------------------------- Program access --------------------------------
DOSKEY nv = nvim
DOSKEY rdd = RD /s /q $* &:: remove non empty directory
DOSKEY vim = nvim
DOSKEY yy = yarn install --check-files

:: --------------------------------- Scripts  ----------------------------------
DOSKEY di = python %SCRIPTS%\fs_dropbox_ignore_node_modules.private.py
DOSKEY nd = node d:\Dropbox\code\daily-tasks-ts\dist\app.js