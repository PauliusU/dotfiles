@ECHO OFF &:: Clean output and hide path of running command

ECHO **** GIT ****

powershell scoop install git

git config --global user.name "PauliusU"
git config --global user.email "48020370+PauliusU@users.noreply.github.com"
:: Line endings for OS compatability
git config --global core.autocrlf input 
git config --global core.editor "nvim"
git config --global core.excludesfile "%DOTFILES%\.gitignore_global"

:: Git global aliases
:: ref: https://dev.to/michaelcurrin/dotfiles-git-config-348o
:: More useful branch list -a all branches, -v verbose
git config --global alias.br "branch -a -v"
:: Cleaner status output
git config --global alias.st "status -s -b"
:: View tags sorted by version number oldest first (use -r for newest first)
git config --global alias.tags "! git tag | sort -V"

git --version

ECHO **** SSH ****
MKLINK /J "%USERPROFILE%\.ssh" "%USER_BAK%\.ssh"
IF NOT EXIST "%USERPROFILE%\.ssh\id_rsa" (
    :: Generate public/private rsa key pair.
    ssh-keygen -t rsa -C "48020370+PauliusU@users.noreply.github.com"
    :: Copy contents of public key
    type %USERPROFILE%\.ssh\id_rsa.pub | clip
)
:: Test SSH
ssh -T git@github.com
