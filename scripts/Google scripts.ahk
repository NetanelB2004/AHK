^+s::SearchPromptInGoogle(0, "Google")
^+d::GoogleSearch()
^+f::YoutubeSearch()
^+g::GoogleTranslate()
;^+h::SearchPromptInGoogle(2, "Google images")
^+c::openTab("Teams")
^+v::openTab("Spotify")
;^+v::Run, https://open.spotify.com/

GoogleSearch()
{
	Send, ^c
	Sleep, 10
	Run, https://www.google.com/search?q=%clipboard%
}

YoutubeSearch()
{
	Send, ^c
	Sleep, 10
	Run, https://www.youtube.com/results?search_query=%clipboard%
}

GoogleTranslate()
{
	Send, ^c
	Sleep, 10
	Run, https://translate.google.ie/?sl=auto&tl=iw&text=%clipboard%&op=translate
}

SearchPromptInGoogle(int, prompt) {
	InputBox, userInput, Seach %prompt%, enter prompt, , 250, 125
	if (ErrorLevel) {
		return
	}

	input := Trim(userInput, " ")
	if (StrLen(input) == 0) {
		return
	}

	Run, https://www.google.com/search?q=%input%&udm=%int%
}

openTab(Name) {
	URL := getTitleAndURL(Name)
	SetTitleMatchMode, 2
	WinActivate, - Google
	SetTitleMatchMode, 1
	If WinExist(Title)
	    WinActivate
	else {
	    WinGetActiveTitle, StartingTitle
	    loop{
			send {Control down}{Tab}{Control Up}
			WinGetActiveTitle, CurrentTabTitle
			
			if(RegExMatch(CurrentTabTitle, Name))
				{
					clipboard := CurrentTabTitle
					Return
				}
				
				
				If (CurrentTabTitle == StartingTitle)
					break

			}
	    Run, %URL%
	}
	Return
}

getTitleAndURL(name) {
	teamsURL := "https://teams.microsoft.com/v2/"
	spotifyURL := "https://open.spotify.com/"
	names := ["Teams", "Spotify"]
	titleAndURL := [teamsURL, spotifyURL]

	for index in names
		{
			if (name == names[index])
				{
					break
				}
		}

	return titleAndURL[index]
}