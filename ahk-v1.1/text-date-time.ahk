/*
Date and time functions 📅
*/
#NoEnv
#SingleInstance, Force ; Replace the old instance
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

CurrentDate() {
    ; Type date in YYYY-MM-DD format => 2029-12-31
    FormatTime, CurrentDateTime,, yyyy-MM-dd
    Send, %CurrentDateTime%
    return
}

CurrentShortDate() {
    ; Type date in YYYYMMDD format => 20291231
    FormatTime, CurrentDateTime,, yyyyMMdd
    SendInput, %CurrentDateTime%
    return
}

CurrentWeek() {
    ; Type week number in wNN format => w37
    StringRight, Week, A_YWeek, 2 ; Extract week number into variable  "Week"
    SendInput, w%Week%
    return
}

CurrentYearDay() {
    ; Type day of the year number in NN format => 305
    SendInput, %A_YDay%
    return
}

FullDate() {
    ; Type current date and time => 2029-12-31 23:59
    Send, %A_Year%-%A_Mon%-%A_MDay% %A_Hour%:%A_Min%
    return
}
