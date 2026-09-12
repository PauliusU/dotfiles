@ECHO OFF &:: Clean output and hide path of running command

TITLE JavaScript and TypeScript ecosystem

ECHO **** mise [Node.js / dev-tool version manager] *****
WHERE mise >nul 2>&1
IF %errorlevel% neq 0 (
    ECHO mise is not found. Installing via scoop...
    powershell scoop install mise
) else (
    ECHO mise is already installed
)
:: Global tool set is declared in .config/mise/config.toml, shared across operating systems
IF NOT EXIST "%USERPROFILE%\.config\mise" MD "%USERPROFILE%\.config\mise"
IF EXIST "%USERPROFILE%\.config\mise\config.toml" DEL /F /Q "%USERPROFILE%\.config\mise\config.toml"
MKLINK "%USERPROFILE%\.config\mise\config.toml" "%DOTFILES%\.config\mise\config.toml"
mise install
:: Create a symlink to the npm config file
MKLINK "%USERPROFILE%\.npmrc" "d:\Dropbox\dev\config\.npmrc"
:: Check installed versions
mise --version
node -v
npm -v
pnpm -v
bun --version
tsc -v
mise ls
