^+s::SearchPrompt("Youtube")
^+d::searchGoogle("Google")
^+f::searchGoogle("Youtube")
^+g::searchGoogle("Google translate")
^+h::searchSongLyrics()
^+c::openTab("ChatGPT")
^+x::openTab("Spotify")
!^+d::openTab("Google docs")
^+b::openTab("Whatsapp")
^.::sendKeyNTimes(4, "+", ">")
^,::sendKeyNTimes(4, "+", "<")
#f::SendInput, thisisunsafe
openTab(prompt) {
	Send, {Esc}
	SetTitleMatchMode, 2
	WinActivate, - Google
	Send, ^+a
	sleep, 200
	Send, % prompt
	Send, {Enter}
	Send, {Esc}
}

searchGoogle(name) {
	URL := getURL(name)
	sendKeyNTimes(3, "^", "c")
	Sleep, 10
	Run, %URL%%clipboard%
}

SearchPrompt(prompt) {
	URL := getURL(prompt)
	InputBox, userInput, Search %prompt%, enter prompt, , 250, 125
	if (ErrorLevel) {
		return
	}

	input := Trim(userInput, " ")
	if (StrLen(input) == 0) {
		return
	}
	
	if (prompt == "Google images") {
		Run, %URL%%input%&udm=2
		Return
	}
	Run, %URL%%input%
}

getURL(name) {
    static urlMap = "
    (LTrim
        ChatGPT=https://chatgpt.com/
        Spotify=https://open.spotify.com/
        Google docs=https://docs.google.com/document/d/1KsRwgVc_12W5SHanOWQS57zGE_gwQy3wbeqsuRLE4HU/edit
        Whatsapp=https://web.whatsapp.com/
        Google=https://www.google.com/search?q=
        Youtube=https://www.youtube.com/results?search_query=
        Google translate=https://translate.google.ie/?sl=auto&tl=iw&text=
        Google images=https://www.google.com/search?q=
    )"
    
    Loop, Parse, urlMap, `n, `r
    {
        pos := InStr(A_LoopField, "=")
        if (pos > 0) {
            key := SubStr(A_LoopField, 1, pos - 1)
            value := SubStr(A_LoopField, pos + 1)
            if (key = name)
                return value
        }
    }
    return ""
}

searchSongLyrics() {
    clipsave := Clipboard
    
    openTab("Spotify")
    sleep, 200
    send, {esc}
    send, ^d
    sleep, 200
    sendKeyNTimes(3, "^", "c")
    ClipWait, 2

    sendKeyNTimes(3, "{tab}", "")
    send, {enter}

    if !Clipboard {
        return
    }

    song := Clipboard
    if InStr(song, "spotify") || !(InStr(song, "•") || InStr(song, Chr(8226))) {
        return
    }

    URL := getURL("Google")
    Run, %URL%%song% Lyrics

    Clipboard := clipsave
}