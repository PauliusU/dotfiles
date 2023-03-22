$host.UI.RawUI.WindowTitle = 'Time, language, keyboard layouts'

# Timezone - FLE: Finland, Lithuania, Estonia
Set-TimeZone -Id 'FLE Standard Time'
# Language List. Note Microsoft Store apps will appear in the first supported language
'$env:DOTFILES\setup-windows\windows-time-language_language_list.setup.ps1'
# Location - 141: LT
Set-WinHomeLocation -GeoID 141
# Regional format [date/time etc.]
Set-Culture lt-LT
# Language for non-Unicode programs
Set-WinSystemLocale lt-LT

# Check time and language settings
Get-ItemProperty -path 'HKCU:\Control Panel\International'
Get-ChildItem -path 'HKCU:\Control Panel\International'
Get-WinUserLanguageList
Get-TimeZone
Get-WinHomeLocation
Get-Culture
Get-WinSystemLocale
Get-WinCultureFromLanguageListOptOut
# Keyboard Identifiers
# Ref: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-language-pack-default-values
#          Lithuanian              0x00010427
#          Russian                 0x00000419
#          English (United States) 0x00000409
#          French                  0x0000040c
Get-Item -path 'HKCU:\Keyboard Layout\Preload'
