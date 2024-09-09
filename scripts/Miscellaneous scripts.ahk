;#s::Screenshot()
^!b::selectFullLine()
!^+s::supersave()
#s::showLinuxShortcuts()
^v::Send +{Insert}

Screenshot() {
    send, #{PrintScreen}
    Run, % SCREENSHOT_PATH()
}

selectFullLine() {
    Send {Home}{Shift down}{End}{Shift up}
}


showLinuxShortcuts() {
    FileRead, fileContent, linux shortcuts.txt
    lines := StrSplit(fileContent, "`n")
    Random, randomIndex, 1, lines.MaxIndex()
    selectedLine := lines[randomIndex]
    MsgBox, % selectedLine
}

supersave() {
    send, ^s
    Run, "Run all.ahk"
    Run, "Master.ahk"
}