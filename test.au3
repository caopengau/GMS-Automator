#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>

Opt("GUIOnEventMode", 1)
$random_numbers = GUICreate("Random numbers", 351, 171, -1, -1, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "close")
$lavel_number = GUICtrlCreateLabel("", 117, 36, 98, 26, BitOR($SS_CENTER, $SS_CENTERIMAGE), $WS_EX_STATICEDGE)
GUICtrlSetBkColor(-1, "0xFFFFFF")
$start = GUICtrlCreateButton("Start", 34, 95, 100, 30, -1, -1)
GUICtrlSetOnEvent(-1, "start")
$stop = GUICtrlCreateButton("Pause", 182, 95, 100, 30, -1, -1)
GUICtrlSetOnEvent(-1, "pause")
$exit = GUICtrlCreateButton("Exit", 112, 136, 100, 30, -1, -1)
GUICtrlSetOnEvent(-1, "close")
GUISetState(@SW_SHOW)
Global $OptChoosen = 0

While 1
    Sleep(50)
    While $OptChoosen = 1
        Sleep(100)
        Local $a = Random(1, 10, 1)
        GUICtrlSetData($lavel_number, $a)
    WEnd
WEnd

Func start()
    $OptChoosen = 1
EndFunc   ;==>start

Func pause()
    $OptChoosen = 0
EndFunc   ;==>pause

Func close()
    Exit
EndFunc   ;==>c