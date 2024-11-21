^!b::selectFullLine()
^!j::SwitchPlaces()
!^+s::supersave()
#s::showLinuxShortcuts()
^v::Send +{Insert}
Screenshot() {
    send, #{PrintScreen}
    Run, % SCREENSHOT_PATH()
}
;!^+c::supercopy()
;#s::Screenshot()
;^g::translate()

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

 SwitchPlaces() {
    sendKeyNTimes(3, "^", "c")
    Text := Clipboard
    message := "Enter character to switch by"
    InputBox, userInput, %message%, %Text%, show, 250, 125

    if (userInput = "") {
        Return
    }
    
    StringSplit, Part, Text, %userInput%
    Part1 := Trim(Part1)
    Part2 := Trim(Part2)
    Switched := Part2 . userInput . " " . Part1
    Send, %Switched%
 }

 sendKeyNTimes(times, key1, key2) {
    loop, % times {
        Send, % key1 key2
    }
}