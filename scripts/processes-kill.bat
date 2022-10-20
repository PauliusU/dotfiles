@ECHO OFF &:: Clean output and hide path of running command

:: TASKKILL:
:: /F       forcefully terminate the process(es).
:: /IM      switch specifies the image name of the process to be terminated. 
::          It also supports wildcard '*' to specify all tasks and a part of 
::          the image name.

ECHO General
TASKKILL /F /IM "GoogleDriveFS.exe" &:: Google Drive
TASKKILL /F /IM "Mongod.exe" &:: MongoDB
TASKKILL /F /IM "Taskmgr.exe" &:: Task Manager

ECHO Forti
TASKKILL /F /IM "FortiESNAC.exe" &:: Forti
TASKKILL /F /IM "fortifws.exe" &:: Forti
TASKKILL /F /IM "FortiSettings.exe" &:: Forti
TASKKILL /F /IM "FortiSSLVPNdaemon.exe" &:: Forti
TASKKILL /F /IM "FortiTray.exe" &:: Forti

ECHO TeamViewer
TASKKILL /F /IM "TeamViewer_Service.exe" &:: TeamViewer
TASKKILL /F /IM "TeamViewer.exe" &:: TeamViewer
TASKKILL /F /IM "tv_w32.exe" &:: TeamViewer
TASKKILL /F /IM "tv_x64.exe" &:: TeamViewer

TIMEOUT 60