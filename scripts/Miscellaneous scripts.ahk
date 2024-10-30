;#s::Screenshot()
^!b::selectFullLine()
!^+s::supersave()
!^+c::supercopy()
#s::showLinuxShortcuts()
^v::Send +{Insert}
;^g::translate()
Screenshot() {
    send, #{PrintScreen}
    Run, % SCREENSHOT_PATH()
}

selectFullLine() {
    Send {Home}{Shift down}{End}{Shift up}
}


showLinuxShortcuts() {
    FileRead, fileContent, txt files\linux shortcuts.txt
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

supercopy() {
    Send, ^c
    ClipWait
    text := Clipboard
    clipboard := text
}