@ECHO OFF &:: Clean output and hide path of running command

ECHO **** Dropbox ****
:: TODO test dropbox reg files
@REM REG IMPORT "%DOTFILES%\Dropbox_HOME_backup.reg"
@REM REG IMPORT "%DOTFILES%\DropboxUpdate_HOME_backup.reg"
MKLINK /J "%APPDATA%\Dropbox" "%USER_BAK%\AppData\Roaming\Dropbox"
MKLINK /J "%LOCALAPPDATA%\Dropbox" "%USER_BAK%\AppData\Local\Dropbox"
MKLINK /J "%USERPROFILE%\code" "d:\Dropbox\code"
MKLINK /J "%USERPROFILE%\dev" "d:\Dropbox\dev"
MKLINK /J "%USERPROFILE%\Dropbox" "d:\Dropbox"
MKLINK /J "%USERPROFILE%\media" "d:\Dropbox\DropsyncFiles\media"
winget install Dropbox.Dropbox

ECHO **** Google Drive ****
MKLINK /J "%USERPROFILE%\Google Drive" "D:\linked\gDrive"
MKLINK /J "%USERPROFILE%\gDrive" "D:\linked\gDrive"
IF NOT EXIST "%LOCALAPPDATA%\Google" MKDIR "%LOCALAPPDATA%\Google"
:: WARNING Google Drive does not work with folder junctions
XCOPY /E /I "%USER_BAK%\AppData\Local\Google\DriveFS" "%LOCALAPPDATA%\Google\DriveFS"
winget install Google.Drive
