#SingleInstance Force

^+y::addToList()
^+u::playList()

addToList() {
	playlist := PLAYLIST_PATH()
	Send, ^l
	Send, ^c
	Send, {Esc}
	match := RegExMatch(clipboard, "https://www.youtube.com/watch")
	
	if (%match% == 0) {
		return
	}	

	URL := clipboard
	;YoutubeTitle := StrReplace(YouTubeTitle(URL), "&#39;", "'")
	YoutubeTitle := ""

	Loop, read, %playlist%
	{
		if (cutURL(URL) == cutURL(StrSplit(A_LoopReadLine, A_Tab)[1])) {
			return
		}
	}

	urlAndName := URL . A_Tab . YoutubeTitle . "`n"
	;msgbox, %YouTubeTitle%
	;msgbox, %urlAndName%

	FileAppend %urlAndName% , %playlist%

}

YouTubeTitle(url) {
	hObject := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	hObject.Open("GET", url)
	hObject.Send()
	RegExMatch(hObject.ResponseText, "(?<=title>).*?(?= - YouTube</title>)", title)
	;msgbox, %title%
	return title
}

cutURL(URL) {
	startPos := InStr(URL, "=") +1
	endPos := InStr(URL, "&", false, startPos) -1
	
	if (endPos < startPos) {
		endPos := StrLen(URL)
	}

	ID := SubStr(URL, startPos, endPos - startPos +1)
	return ID
}

playList() {
	playlist := PLAYLIST_PATH()
	setURL := "http://www.youtube.com/watch_videos?video_ids="
	songArray := []
	Loop, read, %playlist%
	{
		StrLen(A_LoopReadLine) == 0 ? continue : songArray.Push(cutURL(StrSplit(A_LoopReadLine,A_Tab)[1]))
	}

	shuffledArray := shuffleArray(songArray)

		for index in shuffledArray {
			ID := StrSplit(shuffledArray[index], A_Tab)[1]
			setURL .=  ID ","		
		}
		Run, %setURL%	
		;msgbox, %setURL%	
}

shuffleArray(arrayToShuffle) {
	currentIndex := arrayToShuffle.length()

	while (currentIndex != 0) {
		Random, randomIndex, 1, currentIndex

		temp := arrayToShuffle[currentIndex]
		arrayToShuffle[currentIndex] := arrayToShuffle[randomIndex]
		arrayToShuffle[randomIndex] := temp
		
		
		currentIndex := currentIndex - 1
	}

	return arrayToShuffle
}