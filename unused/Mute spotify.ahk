#Persistent
DetectHiddenWindows, on
initial_title = null
sleep_interval = 100

SetTimer, Checkify, 1500
Checkify:
{
  IfWinExist ahk_class SpotifyMainWindow
  {
    WinGetTitle, curent_title
    if(curent_title=initial_title or curent_title="Spotify")
    { 
    }
    else
    {
      SoundGet, is_mute, , mute
      if is_mute = On
          Send, {Volume_Mute}
      sleep %sleep_interval%
      initial_title:=curent_title
      
      Send, {Volume_Mute}
      sleep %sleep_interval%
      WinGetTitle, muted_title
      if(curent_title=muted_title)
      {
        Send, {Volume_Mute}
      }
      else
      {
        Send, {Media_Play_Pause}
      }
    }
  }
}