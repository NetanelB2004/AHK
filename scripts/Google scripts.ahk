;^+s::SearchPromptInGoogle("Google search")
;^+h::SearchPromptInGoogle("Google images")
^+s::SearchPromptInGoogle("Youtube search")
^+d::searchInGoogle("Google search")
^+f::searchInGoogle("Youtube search")
^+g::searchInGoogle("Google translate")
^+c::searchForTab("chatGPT")
^+v::searchForTab("Spotify")
!^+d::searchForTab("Google docs")
^+b::searchForTab("Whatsapp")

searchForTab(prompt) {
	;saveClipboard := Clipboard
	SetTitleMatchMode, 2
	WinActivate, - Google
	Send, ^+a
	Send, % prompt
	Send, {Enter}
	Send, {Esc}
	sleep, 100
	Send, ^l^c{Esc}
	theURL := Clipboard
	URL := getURL(prompt)
	
	if (!regexmatch(theURL, URL)) {
		Run, %URL%
	}

	;Clipboard := saveClipboard
}

searchInGoogle(name) {
	URL := getURL(name)
	Send, ^c
	Sleep, 10
	Run, %URL%%clipboard%
}

SearchPromptInGoogle(prompt) {
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

openTab(Name) {
	saveClipBoard := Clipboard
	URLToSend := getURL(Name)
	SetTitleMatchMode, 2
	WinActivate, - Google
	SetTitleMatchMode, 1
	If WinExist(Title)
	    WinActivate
	else {
		WinGetActiveTitle, StartingTitle
		Send, ^l^c
		ClipWait
		Send, {Esc}
		url := Clipboard
		if InStr(url, Name) { ;|| RegExMatch(StartingTitle, Name)) {
			return
		}
		startURL := url
		url := ""

		while (startURL != url)
		{
			send, ^{tab}
			WinGetActiveTitle, CurrentTabTitle
			sleep, 100
			Send, ^l
			Send, ^c
			ClipWait
			Send, {Esc}
			
			url := Clipboard
			
			if InStr(url, Name) { ;|| RegExMatch(CurrentTabTitle, Name)) {
				return
			}

			;if (CurrentTabTitle != StartingTitle) {
			;	break
			;}
		}
	    Run, %URLToSend%
	}
	Clipboard := saveClipBoard
	Return
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
		, "Google search"	
		, "Youtube search"
		, "Google translate"
		, "Google images"	]

	for index in nameArray
		{
			if (RegExMatch(name, nameArray[index]) > 0)
				{
					break
				}
		}

	return urlArray[index]
}