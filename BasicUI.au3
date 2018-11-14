
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
$LABEL_WIDTH = 200
$INPUT_WIDTH = 100
$LEFT_MARGIN = 10
$RIGHT_MARGIN = $UI_WIDTH - $LEFT_MARGIN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UI layout
$R1 = 10
$R2 = 40
$R3 = 65
$R4 = 90
$R5 = 115

Global $isPaused = False

Global $hMainGUI = GUICreate("GMS Traing Automator", $UI_WIDTH, $UI_HEIGHT)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEButton")


GUICtrlCreateLabel("Welcome to GMS traning automator - by Cao", $LEFT_MARGIN, $R1)

GUICtrlCreateLabel("Key Spam Number: (natural number)", $LEFT_MARGIN, $R2, $LABEL_WIDTH) ; first cell 70 width
local $UIKeySpamN = GUICtrlCreateInput("",  $RIGHT_MARGIN - $INPUT_WIDTH, $R2, $INPUT_WIDTH)

GUICtrlCreateLabel("Key-Stroke Interval: (in milliseconds)", $LEFT_MARGIN, $R3, $LABEL_WIDTH) ; first cell 70 width
local $UIKeySpamSleep = GUICtrlCreateInput("",  $RIGHT_MARGIN - $INPUT_WIDTH, $R3, $INPUT_WIDTH)

GUICtrlCreateLabel("Key-Stroke Variation: (natural number)", $LEFT_MARGIN, $R4, $LABEL_WIDTH) ; first cell 70 width
local $UIKeySpamVariation = GUICtrlCreateInput("",  $RIGHT_MARGIN - $INPUT_WIDTH, $R4, $INPUT_WIDTH)


GUICtrlCreateLabel("Class", $LEFT_MARGIN, $R5, $LABEL_WIDTH) ; first cell 70 width
Local $UIClass = GUICtrlCreateCombo("", $RIGHT_MARGIN - $INPUT_WIDTH, $R5, $BUTTON_WIDTH, $INPUT_WIDTH)
; Add additional items to the combobox.
GUICtrlSetData($UIClass, "Kanna|NextOne", "Kanna")


$buttonText = "Stop(F9)"
local $PauseButton = GUICtrlCreateButton($buttonText, $UI_WIDTH - $BUTTON_WIDTH, $UI_HEIGHT - $BUTTON_HEIGHT, $BUTTON_WIDTH, $BUTTON_HEIGHT)
GUICtrlSetBkColor($PauseButton, $COLOR_RED)
GUICtrlSetOnEvent($PauseButton, "Pause")
GUISetState(@SW_SHOW, $hMainGUI)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; reading from GUI
Global $KeySpamN = GUICtrlRead($UIKeySpamN)
Global $KeySpamSleep = GUICtrlRead($UIKeySpamSleep)
Global $KeySpamVariation = GUICtrlRead($UIKeySpamVariation)
Global $Class = GUICtrlRead($UIClass)


While 1
    If($isPaused) Then
        Sleep(100) ; Paused, Sleep to reduce CPU usage
    Else
        Sleep(1000) ; running training automator
    EndIf
WEnd

Func Pause()
    $isPaused = not $isPaused
    If($isPaused) Then
        $buttonText = "Go(F9)"
        GUICtrlSetBkColor($PauseButton, $COLOR_GREEN)
    Else
        $buttonText = "Stop(F9)"
        GUICtrlSetBkColor($PauseButton, $COLOR_RED)
    EndIf

    GUICtrlSetData($PauseButton, $buttonText)

EndFunc

Func CLOSEButton()
    Exit
EndFunc