; Folders
USER_HOME := EnvGet('USERPROFILE')    ; Get USERPROFILE env variable and save to USER_HOME
SCOOP := EnvGet('SCOOP')
SplitPath(A_ScriptDir, , &DOTFILES)    ; Get parent of A_ScriptDir and save to DOTFILES
SCRIPTS_PATH := DOTFILES . '\scripts'

; Apps
BROWSER := SCOOP . '\apps\googlechrome\current\chrome.exe'
FIREFOX := SCOOP . '\apps\firefox\current\firefox.exe'
DICTIONARY := SCOOP . '\apps\goldendict\current\GoldenDict.exe'
EDITOR_VISUAL := SCOOP . '\apps\vscode\current\Code.exe'
FILE_MANAGER := 'd:\Dropbox\soft\totalcmd\TOTALCMD64.EXE'
FILE_SEARCH := SCOOP . '\apps\everything-alpha\current\Everything.exe'
IMAGE_VIEWER:= SCOOP . '\apps\irfanview\current\i_view64.exe'
PLAYER := SCOOP . '\apps\mpv\current\mpv.exe'
TERMINAL := 'wt'
VIVALDI := SCOOP . '\apps\vivaldi\current\Application\vivaldi.exe'

; Files
NOTES := 'd:\Dropbox\DropsyncFiles\audiob\notes-pc.md'

; Keyboard layouts
EN_layout := 0x0409 ; English (USA)
LT_layout := 0x0427
