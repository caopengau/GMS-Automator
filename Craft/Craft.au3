; Press Esc to terminate script, 0 to Pause/Break to "pause"

#include <AutoItConstants.au3>

Global $Paused
HotKeySet("{F9}", "TogglePause")
HotKeySet("{F10}", "Terminate")
HotKeySet("{F11}", "Restart")
HotKeySet("{DOWN}", "UpAir")
;HotKeySet("{s}", "Rush")


Global $GMS = "MapleStory"
Opt("WinWaitDelay",30)
Opt("WinDetectHiddenText",1)
Opt("MouseCoordMode",0)
Opt("WinTitleMatchMode",6)

WinActivate ( $GMS )
Click()
Global $Cycle30s = TimerInit()

While $GMS="Maplestory"

	Sleep(1000)

	ToolTip("Clicking"&Round((TimerDiff($Cycle30s))/1000),0,0)

	Local $hWnd = WinGetHandle("Maplestory", "")


	If (Round((TimerDiff($Cycle30s))/1000>30)) Then
		Click()
	EndIf

WEnd

Func TogglePause()
	$Paused = NOT $Paused
	While $Paused
		Sleep(100)
		ToolTip("Press F9 to Pause and UnPause, F10 to Exit",0,0)
	WEnd
	ToolTip("Drinking",0,0)
EndFunc

Func Terminate()
	Exit 0
EndFunc

Func Restart()

EndFunc

Func Drink()
	Send("m")
	Sleep(100)
EndFunc

Func Click()
	ToolTip("Clicking",0,0)
	WinActivate ( $GMS )
	MouseClick($MOUSE_CLICK_LEFT, 344,288)
	MouseClick($MOUSE_CLICK_LEFT, 344,288)
	Send("{ENTER}")

	Sleep(4000)

	WinActivate ( $GMS )
	MouseClick($MOUSE_CLICK_LEFT, 193, 275)
	MouseClick($MOUSE_CLICK_LEFT, 193, 275)

	$Cycle30s = TimerInit()
EndFunc