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
:: Recreate Dropbox ignore rules from Maestral's synced .mignore
IF EXIST "d:\Dropbox\.mignore" (
    COPY /Y "d:\Dropbox\.mignore" "d:\Dropbox\rules.dropboxignore"
) ELSE (
    ECHO WARNING: .mignore not found, Dropbox may not have synced yet
)

ECHO **** OneDrive ****
MKLINK /J "%LOCALAPPDATA%\Microsoft\OneDrive" "%USER_BAK%\AppData\Local\Microsoft\OneDrive"
MKLINK /J "%USERPROFILE%\OneDriveLinked" "%OneDrive%"

ECHO **** pCloud ****
winget install pCloudAG.pCloudDrive
MKLINK /D "e:\dwn\video" "P:\tor"

ECHO **** Rclone - CLI for cloud storage ****
powershell scoop install rclone
rclone version
