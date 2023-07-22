; AHK v2

#Include WinClipAPI.ahk
#Include WinClip.ahk

If FileExist("clip.txt")
    FileDelete "clip.txt"

wc := WinClip()


msgbox "copy some text on clipboard"
msgbox text := wc.GetText()


msgbox "copy some SMALL text piece from browser"
msgbox html := wc.GetHTML()


msgbox "copy some picture"
hBitmap := wc.GetBitmap()
If hBitmap {
    g := Gui()
    pic := g.Add("Picture", "+0xE") ; SS_BITMAP
    SendMessage( STM_SETIMAGE := 0x0172, IMAGE_BITMAP := 0, hBitmap, pic.hwnd)
    DllCall("DeleteObject", "Ptr", hBitmap )
    g.Show("w1000 h700")
}


msgbox "copy few files from explorer window"
msgbox fileslist := wc.GetFiles()


obj := inputbox("Enter text you want to put on clipboard","Input Something")
if obj.value
{
  wc.Clear()
  wc.SetText( obj.value )
}
msgbox text := wc.GetText()


obj := inputbox("Enter text you want to APPEND to the one currently on clipboard", "Input Something")
if obj.value
  wc.AppendText( obj.value )
msgbox text := wc.GetText()


obj := inputbox("Enter path to the picture you want to place on clipboard ( without quotes )","Input path to Picture")
if obj.value
{
  wc.Clear()
  wc.SetBitmap( Trim(obj.value,Chr(34)) )
  msgbox "the picture should be on clipboard now"
}


msgbox "copy some data to clipboard"
msgbox "All clipboard data has been saved to clip.txt`nSize: " wc.Save( "clip.txt" )


wc.Clear()
msgbox "clipboard should now be empty`r`n`r`n"
     . "ClipboardAll size: " ClipboardAll().size


bytes := wc.Load( "clip.txt" )
msgbox bytes " bytes loaded from 'clip.txt' file to clipboard"


obj := inputbox("Enter some text you want to place on clipboard as HTML"
               ,"Html to clipboard","w300 h200"
               ,"<a href=" Chr(34) "www.hello.com" Chr(34) ">link</a>")
if obj.value
{
  wc.Clear()
  wc.SetHTML( obj.value )
  msgbox "html data should be on clipboard"
}

If FileExist("clip.txt")
    FileDelete "clip.txt"