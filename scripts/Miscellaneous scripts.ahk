#s::Screenshot()
^!b::selectFullLine()

Screenshot() {
    send, #{PrintScreen}
    run, C:\Users\%A_UserName%\Pictures\Screenshots

}

selectFullLine() {
    Send {Home}{Shift down}{End}{Shift up}
}