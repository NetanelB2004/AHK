MOBA_PATH() {
    Return, "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MobaXterm\MobaXterm.lnk"
}

ORACLE_PATH() {
    Return, "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Oracle VM VirtualBox\Oracle VM VirtualBox.lnk"
}

PLAYLIST_PATH() {
    Return, "txt files/youtube.txt"
}

VS_CODE_PATH() {
    Return, "C:\Users\" . A_UserName . "\AppData\Local\Programs\Microsoft VS Code\Code.exe"
}

SCREENSHOT_PATH() {
    return, "C:\Users\" . A_UserName . "\Pictures\Screenshots"
}

SCRIPT_DIR() {
    Return, A_ScriptDir . "\scripts"
}