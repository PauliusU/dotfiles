/*
Text manipulation functions (change case, convert folder paths) 📜
*/
#NoEnv
#SingleInstance, Force ; Replace the old instance
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

ToUppercase() {
    ; Convert clipboard text to uppercase. example => EXAMPLE
    StringUpper, Clipboard, Clipboard
    Send, %Clipboard%
    return
}

ToLowercase() {
    ; Convert clipboard text to lowercase. EXAMPLE => example
    StringLower, Clipboard, Clipboard
    Send, %Clipboard%
    return
}

ToInverted() {
    ; Convert text to inverted (invert case). Example => eXAMPLE
    invertedChars := ""
    loop % Strlen(Clipboard) {
        workingChar := Substr(Clipboard, A_Index, 1)
        if workingChar is upper
            invertedChars := invertedChars Chr(Asc(workingChar) + 32)
        else if workingChar is lower
            invertedChars := invertedChars Chr(Asc(workingChar) - 32)
        else
            invertedChars := invertedChars workingChar
    }
    Send, %invertedChars%
    return
}

ToEachCapitalized() {
    ; Convert text to capitalized (first letter of each word)
    ; quick example => Quick Example
    StringUpper, Clipboard, Clipboard, T
    Send, %Clipboard%
    return
}

ToSentenceCase() {
    ; Convert text sentence case. quick example => Quick example
    StringLower, Clipboard, Clipboard
    Clipboard := RegExReplace(Clipboard, "((?:^|[.!?]\s+)[a-z])", "$u1")
    Send, %Clipboard%
    return
}

PathWindows() {
    ; Replace '\' with '\\'. Useful for Windows paths in JSON.
    if InStr(Clipboard, "\") {
        output := Strreplace(Clipboard, "\", "\\")
        SendInput, %output%
    } else {
        MsgBox, , , Clipboard does not contain path:`n`n%Clipboard%, 5
    }
    return
}

PathUnix() {
    ; Convert Windows paths to Git-Bash and WSL2 frienldy format
    ; c:\windows\path\example => /c/windows/path/example
    if InStr(Clipboard, "\") {
        output := Strreplace(Clipboard, "\", "/")
        output := StrReplace(output, ":", "")
        SendInput, /%output%
    } else {
        MsgBox, , , Clipboard does not contain path:`n`n%Clipboard%, 5
    }
    return
}