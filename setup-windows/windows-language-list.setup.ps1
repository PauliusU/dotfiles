# Set language list
# Based on: 
# https://scribbleghost.net/2018/04/30/add-keyboard-language-to-windows-10-with-powershell/

# Set WinUserLanguageList as a variable
$lang = Get-WinUserLanguageList

# Clear the WinUserLanguageList
$lang.Clear()

# Add languages to the language list
$lang.add("en-US")
$lang.add("lt-LT")
$lang.add("ru-RU")

# Remove whatever input method is present
$lang[0].InputMethodTips.Clear()

# Remove en-US keyboard layout by overwriting it with lt-LT layout
$lang[0].InputMethodTips.Add('0427:00010427')

# Set language list as default
Set-WinUserLanguageList $lang -Force

# Test language list
Get-WinUserLanguageList
