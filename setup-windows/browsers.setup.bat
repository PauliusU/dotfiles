@ECHO OFF &:: Clean output and hide path of running command

ECHO **** Google Chrome ****
IF NOT EXIST "%LOCALAPPDATA%\Google" MKDIR "%LOCALAPPDATA%\Google"
MKLINK /J "%LOCALAPPDATA%\Google\Chrome" "%USER_BAK%\AppData\Local\Google\Chrome"
powershell scoop install googlechrome

ECHO **** Extensions for Chrome based browsers [Vivaldi, Brave] ****
:: AdBlock — best ad blocker - gighmmpiobklfepjocnamgkkbiglidom
REG ADD "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\gighmmpiobklfepjocnamgkkbiglidom" /v "update_url" /t REG_SZ /d "https://clients2.google.com/service/update2/crx" /f
:: Dark reader - eimadpbcbfnmbkopoojfekhnkhdbieeh
REG ADD "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\eimadpbcbfnmbkopoojfekhnkhdbieeh" /v "update_url" /t REG_SZ /d "https://clients2.google.com/service/update2/crx" /f
:: Reddit Enhancement Suite - kbmfpngjjgdllneeigpgjifpgocmfgmb
REG ADD "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\kbmfpngjjgdllneeigpgjifpgocmfgmb" /v "update_url" /t REG_SZ /d "https://clients2.google.com/service/update2/crx" /f
:: Vimium - dbepggeogbaibhgnhhndojpepiihcmeb
REG ADD "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\dbepggeogbaibhgnhhndojpepiihcmeb" /v "update_url" /t REG_SZ /d "https://clients2.google.com/service/update2/crx" /f

ECHO **** Firefox *****
MKLINK /J "%APPDATA%\Mozilla" "%USER_BAK%\AppData\Roaming\Mozilla"
powershell scoop install firefox
