;^+s::SearchPrompt("Google")
;^+h::SearchPrompt("Google images")
^+s::SearchPrompt("Youtube")
^+d::searchGoogle("Google")
^+f::searchGoogle("Youtube")
^+g::searchGoogle("Google translate")
^+c::openTab("ChatGPT")
^+x::openTab("Spotify")
!^+d::openTab("Google docs")
^+b::openTab("Whatsapp")
^.::sendKeyNTimes(4, "+", ">")
^,::sendKeyNTimes(4, "+", "<")

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
	urlArray := [
	, "https://chatgpt.com/"
	, "https://open.spotify.com/"
	, "https://docs.google.com/document/d/1KsRwgVc_12W5SHanOWQS57zGE_gwQy3wbeqsuRLE4HU/edit"
	, "https://web.whatsapp.com/"
	, "https://www.google.com/search?q="
	, "https://www.youtube.com/results?search_query="
	, "https://translate.google.ie/?sl=auto&tl=iw&text="
	, "https://www.google.com/search?q="	]

	nameArray := [
		, "ChatGPT"
		, "Spotify"
		, "Google docs"
		, "Whatsapp"
		, "Google"
		, "Youtube"
		, "Google translate"
		, "Google images"	]

	for index in nameArray
		{
			if (nameArray[index] == name)
				{
					break
				}
		}

	return urlArray[index]
}

sendKeyNTimes(times, key1, key2) {
    loop, % times {
        Send, % key1 key2
    }
}