@ECHO OFF &:: Clean output and hide path of running command

ECHO **** AHK ****

powershell scoop install autohotkey
ASSOC .ahk=ahkfile
FTYPE ahkfile="%SCOOP%\apps\autohotkey\current\v2\AutoHotkey64.exe" "%%1"

:: Run AHK
START "%SCOOP%\apps\autohotkey\current\v2\AutoHotkey64.exe" "%DOTFILES%\ahk\main.ahk"

:: AHK system startup link
:: %DOTFILES% uses forward slashes; normalize to backslashes or the .lnk target ends up blank.
SET TARGET='%DOTFILES%\ahk\main.ahk'
SET SHORTCUT='%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\AHK_MAIN_startup.lnk'
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut((%SHORTCUT%).Replace('/','\')); $S.TargetPath = (%TARGET%).Replace('/','\'); $S.Save()"