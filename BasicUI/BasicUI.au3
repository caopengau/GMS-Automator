
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <ColorConstants.au3>

Opt("GUIOnEventMode", 1) ; Change to OnEvent mode

; hotkey control
HotKeySet("{F9}", "Pause")

; UI sizes
$UI_WIDTH = 300
$UI_HEIGHT = 300
$BUTTON_WIDTH = 100
$BUTTON_HEIGHT = 100


Global $isPaused = False
Global $buttonText = "Running(F9)"

Global $hMainGUI = GUICreate("GMS Traing Automator", $UI_WIDTH, $UI_HEIGHT)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEButton")
GUICtrlCreateLabel("Welcome to GMS traning automator - by Cao", 30, 10)
Global $PauseButton = GUICtrlCreateButton($buttonText, $UI_WIDTH - $BUTTON_WIDTH, $UI_HEIGHT - $BUTTON_HEIGHT, $BUTTON_WIDTH, $BUTTON_HEIGHT)
GUICtrlSetOnEvent($PauseButton, "Pause")
GUISetState(@SW_SHOW, $hMainGUI)

While 1
    If($isPaused) Then
        Sleep(100) ; Paused, Sleep to reduce CPU usage
    Else
        Sleep(100) ; running training automator
    EndIf
WEnd

Func Pause()
    $isPaused = not $isPaused
    If($isPaused) Then
        $buttonText = "Paused(F9)"
        GUICtrlSetBkColor($PauseButton, $COLOR_RED)
    Else
        $buttonText = "Running(F9)"
        GUICtrlSetBkColor($PauseButton, $COLOR_GREEN)
    EndIf

    GUICtrlSetData($PauseButton, $buttonText)

EndFunc

Func CLOSEButton()
    Exit
EndFunc