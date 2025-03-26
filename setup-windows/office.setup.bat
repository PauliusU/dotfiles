@ECHO OFF &:: Clean output and hide path of running command

ECHO **** Anki ****
powershell scoop install anki
MKLINK /J "%APPDATA%\Anki2" "%SCOOP%\persist\anki\data"

ECHO **** GoldenDict ****
powershell scoop install goldendict
python -m pip install --upgrade --user -- google-translate-for-goldendict

ECHO **** KeePass ****
powershell scoop install keepass
:: KeePass associations [ADMIN]
ASSOC .kdbx=KDBXfile
FTYPE KeePassfile="%SCOOP%\apps\keepass\current\KeePass.exe" "%%1"

ECHO **** SumatraPDF ****
powershell scoop install sumatrapdf
:: SumatraPDF associations [ADMIN]
ASSOC .epub=EPUBfile
FTYPE EPUBfile="%SCOOP%\apps\sumatrapdf\current\SumatraPDF.exe" "%%1"
ASSOC .mobi=MOBIfile
FTYPE MOBIfile="%SCOOP%\apps\sumatrapdf\current\SumatraPDF.exe" "%%1"
ASSOC .pdf=PDFfile
FTYPE PDFfile="%SCOOP%\apps\sumatrapdf\current\SumatraPDF.exe" "%%1"
ASSOC .xps=XPSfile
FTYPE XPSfile="%SCOOP%\apps\sumatrapdf\current\SumatraPDF.exe" "%%1"

ECHO **** Microsoft 365 [Office] a.k.a. MSO ****
IF NOT EXIST "C:\Program Files\Microsoft Office\Office16" winget install Microsoft.Office &:: "Microsoft 365 Apps for enterprise"
ECHO Disable "Office Hub" keyboard shortcut {Ctrl + Alt + Shift + Win}
REG ADD HKCU\Software\Classes\ms-officeapp\Shell\Open\Command /t REG_SZ /d rundll32 /f

ECHO **** Microsoft Excel ****
IF NOT EXIST "%APPDATA%\Microsoft\Excel\XLSTART" MKDIR "%APPDATA%\Microsoft\Excel\XLSTART"
:: PERSONAL.XLSB does not work with folder junction
IF NOT EXIST "%APPDATA%\Microsoft\Excel\XLSTART\PERSONAL.XLSB" COPY "d:\Dropbox\soft\MSO\excel\PERSONAL.XLSB" "%APPDATA%\Microsoft\Excel\XLSTART"

ECHO **** Microsoft Word ****
DEL /Q "%APPDATA%\Microsoft\Templates"
MKLINK /J "%APPDATA%\Microsoft\Templates" "d:\Dropbox\soft\MSO\word"

ECHO **** Office spellcheckers ****
"d:\Dropbox\soft\MSO\proofingtools2016_fr-fr-x64.exe" /quiet
"d:\Dropbox\soft\MSO\proofingtools2016_lt-lt-x64.exe" /quiet
"d:\Dropbox\soft\MSO\proofingtools2016_ru-ru-x64.exe" /quiet
winget install Grammarly.Grammarly.Office &:: Grammarly for Microsoft Office Suite. No scoop alternative as of 2023-03-13

ECHO **** Toggl Track - time tracking ****
winget install Toggl.TogglTrack
