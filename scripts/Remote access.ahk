#SingleInstance Force

^!p::Putty()
^!o::MSTSC()
^!v::Moba()

Putty() {
    remoteConnect(1)
}

MSTSC() {
    remoteConnect(2)
}

Moba() {
    remoteConnect(3)
}

remoteConnect(option) {
    outputFile := "remote access IPs.txt"
    appTitleArray := ["Putty SSH", "Windows MSTSC", "Moba SSH"]
    appNameArray := ["putty -ssh", "mstsc -v", ""]
    matchNameArray := ["SSH", "MSTSC", "MOBA"]
    didGetNewIP := false

    appTitle := appTitleArray[option]
    appName := appNameArray[option]
    matchName := matchNameArray[option]

    msgbox, 291, %appTitle%, New IP address?
    IfMsgBox cancel
        return

	IfMsgBox yes 
    {
        didGetNewIP := true
        newIP := getIP(option)

        if (!newIP) { 
            remoteConnect(option)
            return
        }

        IPAddress := newIP
        Goto, ConnectToVM
    }

    Loop, Read, %outputFile%
    {
        if (RegExMatch(A_LoopReadLine, matchName)) {
            IPAddress := StrSplit(A_LoopReadLine, "=")[2]
        }           
    }

    ConnectToVM:
    if (option == 3) {
        runMoba(IPAddress)
        return
    }

    send, #r
    sleep, 100
    send, %appName% %IPAddress%
    send, {enter}
}

getIP(option) {
    titleArray := ["Linux", "Windows", "Linux"]
    title := titleArray[option]

    InputBox, userInput, Connect to %title% machine, Enter new IP address for %title% machine, show, 300, 125
    input := Trim(userInput, " ")

    if (ErrorLevel) {
        return false
    }

	if (!RegExMatch(input, validRegex())) {
		msgbox, invalid input
		return getIP(option)
	}

    changeIP(option, input)
    return input
}

changeIP(option, newIPAddress) {
    FileName = remote access IPs.txt
    typeNameArray := ["SSH", "MSTSC", "MOBA"]
    typeName := typeNameArray[option]

    Loop, Read, %FileName%, NewFile.txt
    {
        If (InStr(A_LoopReadLine, typeName)) {
            NewData := StrReplace(A_LoopReadLine, A_LoopReadLine, typeName . " IP=" . newIPAddress)
            FileAppend, % NewData "`r`n"
        } Else {
            FileAppend, % A_LoopReadLine "`r`n"
        }
    }
    FileDelete, %FileName%
    FileMove, NewFile.txt, %FileName%
    return
}

validRegex() {
    return "^(([0-9]{1,2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]{1,2}|1[0-9]{2}|2[0-4][0-9]|25[0-5]){1}$"
    ;return "^([0-9]{1,3}\.){3}[0-9]{1,3}$"
}

runMoba(IPAddress) {
    Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MobaXterm\MobaXterm.lnk
    WinWait, MobaXterm
    Send, ^+n
    Send, %IPAddress%
    send, {Enter}
    return
}