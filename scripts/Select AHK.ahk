Global AHKFunction
^!j::dothing()


dothing() {
    AHKs := getAllAHKs()

    Gui, Destroy
    Gui, New,,Open AHK script with VScode
    Gui, Font, s15
    Gui, Add, Text, Center, Select AHK file to open
    Gui, Add, DropDownList, w325 choose1 vAHKFunction, %AHKs%
    Gui, Add, Button, w150 gAHK +Default, Open
    Gui, Add, Button, w150 x+25 , Cancel

    Gui, show
   }

AHK() {
    Global AHKFunction

    Gui, submit, Hide
    hotKey := StrSplit(AHKFunction," ")[1]
    arrayarray := StrSplit(hotKey)
    key := ""
    for index in arrayarray
    {
        ;msgbox, % arrayarray[index]
        key .= "{" . arrayarray[index] . "}"
    }

    msgbox, % key
    Sendinput, % key
}   

getAllAHKs() {
    regexKey := "^\s*([\^\!\+\#]+[^\:\s]+)"
    FileRead, fileContent, hotkeys list.txt
    strings := ""

    Loop, Parse, fileContent, `n, `r
        {
            line := A_LoopField
            if (RegExMatch(line, regexKey)) {
                strings .= line . "|"
            }
        }
    return strings 
}    