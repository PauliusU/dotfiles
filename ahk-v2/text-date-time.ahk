/*
Date and time functions 📅
*/

CurrentDate() {
    ; Type date in YYYY-MM-DD format => 2029-12-31
    currentDateTime := FormatTime(, 'yyyy-MM-dd')
    Send(currentDateTime)
    return
}

CurrentShortDate() {
    ; Type date in YYYYMMDD format => 20291231
    currentDateTime := FormatTime(, 'yyyyMMdd')
    Send(currentDateTime)
    return
}

CurrentWeek() {
    ; Type week number in wNN format => w37, w03    
    weekNo := SubStr(A_YWeek, -2)
    SendInput('w' . weekNo)
    return
}

CurrentYearDay() {
    ; Type day of the year number in NN format => 305
    SendInput(A_YDay)
    return
}

FullDate() {
    ; Type current date and time => 2029-12-31 23:59
    Send(A_Year . '-' . A_Mon . '-' . A_MDay . ' ' . A_Hour . ':' . A_Min)
    return
}