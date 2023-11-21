@ECHO OFF &:: Clean output and hide path of running command

TITLE FILE MANAGEMENT AND SEARCH

ECHO **** 7z / 7zip / Archive.****
powershell scoop install 7zip
ASSOC .7z=Archive.7z
FTYPE Archive.7z="%SCOOP%\apps\7zip\current\7zFM.exe" "%%1"
ASSOC .zip=7-Archive.ZIP
FTYPE Archive.ZIP="%SCOOP%\apps\7zip\current\7zFM.exe" "%%1"
ASSOC .rar=7-Archive.RAR
FTYPE Archive.RAR="%SCOOP%\apps\7zip\current\7zFM.exe" "%%1"
:: .zip
REG ADD "HKCR\Archive.ZIP\shell\E&xtract to folder (7Z)\command" /VE /t REG_SZ /D "%SCOOP%\apps\7zip\current\7z.exe x \"%%1\" -o* -aou" /F
REG ADD "HKCR\Archive.ZIP\shell\E&xtract to folder (7Z)" /V Icon /D "%SCOOP%\apps\7zip\current\7zip.ico" /F
:: .7z
REG ADD "HKCR\Archive.7z\shell\E&xtract to folder (7Z)\command" /VE /T REG_SZ /d "%SCOOP%\apps\7zip\current\7z.exe x \"%%1\" -o* -aou" /F
REG ADD "HKCR\Archive.7z\shell\E&xtract to folder (7Z)" /V Icon /D "%SCOOP%\apps\7zip\current\7zip.ico" /F
:: .rar
REG ADD "HKCR\Archive.rar\shell\E&xtract to folder (7Z)\command" /VE /T REG_SZ /d "%SCOOP%\apps\7zip\current\7z.exe x \"%%1\" -o* -aou" /F
REG ADD "HKCR\Archive.rar\shell\E&xtract to folder (7Z)" /V Icon /D "%SCOOP%\apps\7zip\current\7zip.ico" /F
:: .exe with 7z
REG ADD "HKCR\exefile\shell\E&xtract to folder (7Z)\command" /VE /T REG_SZ /D "%SCOOP%\apps\7zip\current\7z.exe x \"%%1\" -o* -aou" /F
REG ADD "HKCR\exefile\shell\E&xtract to folder (7Z)" /V Icon /D "%SCOOP%\apps\7zip\current\7zip.ico" /F

ECHO **** btop system monitor ****
powershell scoop install btop
btop --version

ECHO **** Everything file search ****
powershell scoop bucket add versions
powershell scoop install everything-alpha
REG IMPORT "%SCOOP%\apps\everything-alpha\current\install-context.reg"
:: powershell scoop install everything

ECHO **** SpaceSniffer ****
powershell scoop install spacesniffer
REG ADD "HKEY_CLASSES_ROOT\Folder\shell\SpaceSniffer" /VE /D "&SpaceSniffer Here" /F
REG ADD "HKEY_CLASSES_ROOT\Folder\shell\SpaceSniffer" /V Icon /D "%SCOOP%\apps\spacesniffer\current\SpaceSniffer.exe" /F
REG ADD "HKEY_CLASSES_ROOT\Folder\shell\SpaceSniffer\command" /ve /t REG_SZ /d "%SCOOP%\apps\spacesniffer\current\SpaceSniffer.exe scan \"%%1\"" /f

ECHO **** Midnight commander ****
powershell scoop install mc

ECHO **** Unlocker in context menu ****
powershell scoop install unlocker
REG ADD "HKEY_CLASSES_ROOT\Directory\shell\Unlocker" /VE /D "Send to &Unlocker" /F
REG ADD "HKEY_CLASSES_ROOT\Directory\shell\Unlocker" /v Icon /d "%SCOOP%\apps\unlocker\current\Unlocker.exe" /F
REG ADD "HKEY_CLASSES_ROOT\Directory\shell\Unlocker\Command" /ve /d "%SCOOP%\apps\unlocker\current\Unlocker.exe \"%%1\"" /F

ECHO **** Yazi file manager ****
powershell scoop install yazi
powershell scoop install unar jq poppler fd ripgrep fzf zoxide
yazi --version
