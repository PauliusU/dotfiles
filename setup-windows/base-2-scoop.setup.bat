@ECHO OFF &:: Clean output and hide path of running command

ECHO **** scoop ****

:: Change powershell execution policy to allow running a remote script
powershell Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

:: Install scoop - installation does not run under admin console by default:
:: https://github.com/ScoopInstaller/Install?tab=readme-ov-file#for-admin
powershell "irm get.scoop.sh | iex"

:: Update scoop itself and all scoop programs [REQUIRES: git]
powershell scoop status
powershell scoop install git
powershell scoop update
powershell scoop update *

:: Add "extras" collection of apps. Mostly GUI tools like VSCode, Googlec Chrome, etc.
powershell scoop bucket add extras

:: Enable Scoop multi-connection downloads with aria2 and disable warning
powershell scoop install aria2
powershell scoop config aria2-warning-enabled false

powershell scoop install sudo
powershell scoop install refreshenv
CALL RefreshEnv.cmd

powershell scoop -v
