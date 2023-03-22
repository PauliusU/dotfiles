@ECHO OFF &:: Clean output and hide path of running command

ECHO **** Microsoft Windows 11 Bloatware uninstall ****

:: Windows media player
powershell Disable-WindowsOptionalFeature -Online -FeatureName 'WindowsMediaPlayer'

:: Edge
taskkill /f /im msedge.exe
winget uninstall Microsoft.Edge
winget uninstall Microsoft.EdgeWebView2Runtime --accept-source-agreements --silent

:: Microsoft applications
winget uninstall cortana
winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe &:: Cortana
winget uninstall Microsoft.GetHelp_8wekyb3d8bbwe &:: Get Help
winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe &:: Microsoft Tips
winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe &:: Microsoft Solitaire Collection
winget uninstall Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe &:: Sticky Notes
winget uninstall Microsoft.Office.OneNote_8wekyb3d8bbwe &:: OneNote for Windows 10
winget uninstall Microsoft.Paint_8wekyb3d8bbwe &:: Paint
winget uninstall Microsoft.People_8wekyb3d8bbwe &:: Microsoft People
winget uninstall Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe &:: Power Automate [previously Microfost Flow]
winget uninstall Microsoft.SkypeApp_kzf8qxf38zg5c &:: Skype
winget uninstall Microsoft.StorePurchaseApp_8wekyb3d8bbwe &:: Store Experience Host [required to run downloaded apps from the Store]
winget uninstall Microsoft.Todos_8wekyb3d8bbwe &:: Microsoft To Do
winget uninstall Microsoft.Windows.Photos_8wekyb3d8bbwe &:: Microsoft Photos
winget uninstall microsoft.windowscommunicationsapps_8wekyb3d8bbwe &:: Mail and Calendar
winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe &:: Feedback Hub
winget uninstall Microsoft.WindowsMaps_8wekyb3d8bbwe &:: Windows Maps
winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe &:: Groove Music
winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe &:: Movies & TV
winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe &:: Quick Assist
winget uninstall MicrosoftOfficeHub_8wekyb3d8bbwe &:: Office Hub, Miscrosoft Office
winget uninstall MicrosoftTeams_8wekyb3d8bbwe &:: Teams
winget uninstall MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy &:: Windows Web Experience Pack
winget uninstall skype
winget uninstall Teams
:: Microsoft Teams startup items
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run /v TeamsMachineUninstallerLocalAppData /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run /v TeamsMachineUninstallerProgramData /f

:: Apps that are left undeleted
:: winget uninstall Microsoft.BingNews_8wekyb3d8bbwe &:: News [required for widgets]
:: winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe &:: Weather
:: winget uninstall Microsoft.WindowsAlarms_8wekyb3d8bbwe &:: Windows Alarms & Clock
:: winget uninstall Microsoft.WindowsCamera_8wekyb3d8bbwe &:: Windows Camera
:: winget uninstall Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe &:: Windows Voice Recorder
:: winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe &:: Phone link [previously Your Phone]
:: winget uninstall Microsoft.ScreenSketch_8wekyb3d8bbwe &:: Snipping tool [previously Screen Sketch]

:: Xbox Applications
winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe
winget uninstall Microsoft.XboxApp_8wekyb3d8bbwe &:: Xbox
winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe &:: Xbox TCUI
winget uninstall Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe &:: Xbox Game Speech Window
winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe &:: Xbox Identity Provider
winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe &:: Xbox Game Bar
winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe &:: Xbox Game Bar Plugin

:: Third-Party Preinstalled bloat
winget uninstall Clipchamp.Clipchamp_yxz26nhyzhsrt &:: Clipchamp - Video Editor

ECHO **** Disable unused aliased for Windows apps ****
DEL %LOCALAPPDATA%\Microsoft\WindowsApps\python.exe
DEL %LOCALAPPDATA%\Microsoft\WindowsApps\python3.exe