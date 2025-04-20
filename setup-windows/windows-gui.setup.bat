@ECHO OFF &:: Clean output and hide path of running command

ECHO **** Enable dark theme ****
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

ECHO **** Disable UAC [ADMIN] ****
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f

ECHO **** Show hibernation, lock and sleep options in power menu [ADMIN] ****
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /f /v "ShowLockOption" /t REG_DWORD /d 1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /f /v "ShowHibernateOption" /t REG_DWORD /d 1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /f /v "ShowSleepOption" /t REG_DWORD /d 1

TITLE TASKBAR

ECHO **** Remove taskbar buttons ****
:: Widget
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f
:: Search box
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
:: Task View
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
:: Chat
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d 0 /f

TITLE EXPLORER, CONTEXT MENUS, DESKTOP

ECHO **** Start File Explorer with "This PC" instead of "Quick Access" ****
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f

ECHO **** Show file extensions ****
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

ECHO **** Show hidden extensions [.URL, .LNK, .library-ms] ****
REG DELETE "HKCR\InternetShortcut" /v "NeverShowExt" /f &:: *.URL [Internet Shortcut]
REG DELETE "HKCR\LibraryFolder" /v "NeverShowExt" /f &:: *.library-ms
REG DELETE "HKCR\lnkfile" /v "NeverShowExt" /f &:: *.LNK [File/Folder Shortcut]

ECHO **** Hide desktop icons ****
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideIcons" /T REG_DWORD /D 1 /F
TASKKILL /f /im explorer.exe
START explorer.exe

TITLE Backup and Windows Libraries for File History

ECHO **** Create "DDiskFiles" Library for backups ***
d:\Dropbox\soft\cli-tools\ShLib_and_SLUtil_win32\ShLib\ShLib.exe create "%APPDATA%\Microsoft\Windows\Libraries\DDiskFiles.library-ms"
d:\Dropbox\soft\cli-tools\ShLib_and_SLUtil_win32\ShLib\ShLib.exe add "%APPDATA%\Microsoft\Windows\Libraries\DDiskFiles.library-ms" "D:\Dropbox"
d:\Dropbox\soft\cli-tools\ShLib_and_SLUtil_win32\ShLib\ShLib.exe add "%APPDATA%\Microsoft\Windows\Libraries\DDiskFiles.library-ms" "D:\linked"
d:\Dropbox\soft\cli-tools\ShLib_and_SLUtil_win32\ShLib\ShLib.exe add "%APPDATA%\Microsoft\Windows\Libraries\DDiskFiles.library-ms" "D:\soft"

ECHO **** Set display refresh rate ****
IF EXIST %PC_HOME_FILE% d:\Dropbox\soft\cli-tools\nircmd-x64\nircmd.exe setdisplay monitor:0 1920 1080 32 75 -updatereg
