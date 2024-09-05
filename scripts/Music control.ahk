^!s::Send, {Media_Play_Pause}
^!d::Send, {Media_Next}
^!a::Send, {Media_Prev}
^!e::Send, {Volume_Up}
^!q::Send, {Volume_Down}
^!w::Send, {Volume_Mute}
!^+w::superMute()

superMute() {
    Send, {Volume_Mute}
    Sleep, 26000
    Send, {Volume_Mute}
    return
}