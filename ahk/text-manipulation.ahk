/*
Text manipulation functions (change case, convert folder paths) 📜
*/

ToUppercase() {
    ; Convert clipboard text to uppercase. example => EXAMPLE
    Clipboard := StrUpper(A_Clipboard)
    Send(Clipboard)
    return
}

ToLowercase() {
    ; Convert clipboard text to lowercase. EXAMPLE => example
    Clipboard := StrLower(A_Clipboard)
    Send(Clipboard)
    return
}

ToInverted() {
    ; Convert text to inverted (invert case). Example => eXAMPLE
    invertedChars := ''
    loop (Strlen(A_Clipboard)) {
        workingChar := Substr(A_Clipboard, A_Index, 1)
        if (IsUpper(workingChar))
            invertedChars := invertedChars Chr(Ord(workingChar) + 32)
        else if (IsUpper(workingChar))
            invertedChars := invertedChars Chr(Ord(workingChar) - 32)
        else
            invertedChars := invertedChars workingChar
    }
    Send(invertedChars)
    return
}

ToEachCapitalized() {
    ; Convert text to capitalized (first letter of each word)
    ; quick example => Quick Example
    Clipboard := StrTitle(A_Clipboard)
    Send(Clipboard)
    return
}

ToSentenceCase() {
    ; Convert text sentence case. quick example => Quick example
    Clipboard := StrUpper(A_Clipboard)
    Clipboard := RegExReplace(Clipboard, '((?:^|[.!?]\s+)[a-z])', '$u1')
    Send(Clipboard)
    return
}

PathWindows() {
    ; Replace '\' with '\\'. Useful for Windows paths in JSON.
    if (InStr(A_Clipboard, '\')) {
        output := Strreplace(A_Clipboard, '\', '\\')
        SendInput(output)
    } else {
        MsgBox('Clipboard does not contain path:`n`n' . A_Clipboard, 'T5')
    }
    return
}

PathUnix() {
    ; Convert Windows paths to Git-Bash and WSL2 frienldy format
    ; c:\windows\path\example => /c/windows/path/example
    if (InStr(A_Clipboard, '\')) {
        output := Strreplace(A_Clipboard, '\', '/')
        output := StrReplace(output, ':', '')
        SendInput('/'.output)
    } else {
        MsgBox('Clipboard does not contain path:`n`n' . A_Clipboard, 'T5')
    }
    return
}