; Folders
USER_HOME := EnvGet('USERPROFILE')    ; Get USERPROFILE env variable and save to USER_HOME
SplitPath(A_ScriptDir, , &DOTFILES)    ; Get parent of A_ScriptDir and save to DOTFILES
SCRIPTS_PATH := DOTFILES . '\scripts'

; Apps
BROWSER := USER_HOME . '\scoop\apps\firefox\current\firefox.exe'
CHROME := USER_HOME . '\scoop\apps\googlechrome\current\chrome.exe'
DICTIONARY := 'd:\Dropbox\soft\GoldenDict\GoldenDict.exe'
EDITOR_VISUAL := USER_HOME . '\scoop\apps\vscode\current\Code.exe'
FILE_MANAGER := 'd:\Dropbox\soft\totalcmd\TOTALCMD64.EXE'
FILE_SEARCH := 'c:\Program Files\Everything\Everything64.exe'
IMAGE_VIEWER := 'd:\Dropbox\soft\IrfanView\i_view64.exe'
PLAYER := 'd:\Dropbox\soft\mpv_portable\mpv.exe'
TERMINAL := 'wt'
VIVALDI := 'd:\soft\network\vivaldi\Application\vivaldi.exe'

; Files
NOTES := 'd:\Dropbox\DropsyncFiles\audiob\notes_PC.md'