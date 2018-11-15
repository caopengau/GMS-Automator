
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <ColorConstants.au3>


Opt("GUIOnEventMode", 1)        ; Change to OnEvent mode for GUI
Opt("WinTitleMatchMode", 2)     ; 1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase


; hotkey control
HotKeySet("{F9}", "Pause")
HotKeySet("{F10}", "Terminate")

; UI constants
$UI_LEFT = 0    ; starting UI location
$UI_TOP = 0
$UI_WIDTH = 300 ; UI size
$UI_HEIGHT = 300
$BUTTON_WIDTH = 100 ; button size
$BUTTON_HEIGHT = 100
$LABEL_WIDTH = 200  ; label size
$INPUT_WIDTH = 100  ; input size
$LEFT_MARGIN = 10   ; margin left
$RIGHT_MARGIN = $UI_WIDTH - $LEFT_MARGIN    ; margin right
$CHECKBOX_SIZE = 50 ; checkbox size

; UI row layout
$R1 = 10
$R2 = 40
$R3 = 65
$R4 = 90
$R5 = 115
$R6 = 140
$R7 = 165

Global $hMainGUI = GUICreate("GMS Traing Automator", $UI_WIDTH, $UI_HEIGHT, 0, 0)
GUISetOnEvent($GUI_EVENT_CLOSE, "Terminate")

GUICtrlCreateLabel("Welcome to GMS traning automator - by Cao", $LEFT_MARGIN, $R1)  ; greeting

GUICtrlCreateLabel("Key Spam Number: (natural number)", $LEFT_MARGIN, $R2, $LABEL_WIDTH) ; first cell 70 width
GUICtrlSetTip(-1, "More strokes will ensure the skill to go off at the cost of higher delay and attracting GM, less than 3 is recommanded")
Global $UIKeySpamN = GUICtrlCreateInput("1",  $RIGHT_MARGIN - $INPUT_WIDTH, $R2, $INPUT_WIDTH)

GUICtrlCreateLabel("Key-Stroke Interval: (in milliseconds)", $LEFT_MARGIN, $R3, $LABEL_WIDTH) ; first cell 70 width
GUICtrlSetTip(-1, "Longer interval will simulate better human reaction time at the cost of skill/command delay\n 5-50 is recommanded")
Global $UIKeySpamSleep = GUICtrlCreateInput("11",  $RIGHT_MARGIN - $INPUT_WIDTH, $R3, $INPUT_WIDTH)

GUICtrlCreateLabel("Key-Stroke Variation: (natural number)", $LEFT_MARGIN, $R4, $LABEL_WIDTH) ; first cell 70 width
GUICtrlSetTip(-1, "To create some random key strokes to simulate variation in key strokes, less than 3 is recommanded")
Global $UIKeySpamVariation = GUICtrlCreateInput("1",  $RIGHT_MARGIN - $INPUT_WIDTH, $R4, $INPUT_WIDTH)


GUICtrlCreateLabel("Class", $LEFT_MARGIN, $R5, $LABEL_WIDTH) ; first cell 70 width
Local $UIClass = GUICtrlCreateCombo("Kanna", $RIGHT_MARGIN - $INPUT_WIDTH, $R5, $BUTTON_WIDTH, $INPUT_WIDTH)
; Add additional items to the combobox.
GUICtrlSetData($UIClass, "Kanna|NextOne", "Kanna")


GUICtrlCreateLabel("Feedback", $LEFT_MARGIN, $R6, $LABEL_WIDTH) ; first cell 70 width
GUICtrlSetTip(-1, "Report what skill(button) is it doing right now")
Global $UIFeedBack = GUICtrlCreateCheckbox("", $RIGHT_MARGIN - $INPUT_WIDTH, $R6, $CHECKBOX_SIZE, $CHECKBOX_SIZE)

$buttonText = "Go(F9)"
Global $PauseButton = GUICtrlCreateButton($buttonText, $UI_WIDTH - $BUTTON_WIDTH, $UI_HEIGHT - $BUTTON_HEIGHT, $BUTTON_WIDTH, $BUTTON_HEIGHT)
GUICtrlSetBkColor($PauseButton, $COLOR_GREEN)
GUICtrlSetOnEvent($PauseButton, "Pause")

GUISetState(@SW_SHOW, $hMainGUI)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; reading from GUI
Global $KeySpamN = GUICtrlRead($UIKeySpamN)
Global $KeySpamSleep = GUICtrlRead($UIKeySpamSleep)
Global $KeySpamVariation = GUICtrlRead($UIKeySpamVariation)
Global $Class = GUICtrlRead($UIClass)
Global $UIFeedBack

; initial variables and value
Global $GMS = "MapleStory"      ; target program to send key stroke
Global $isPaused = True        ; pause script, status indicator
Global $devMode = False         ; developer mode for shortcutting
Global $feedBackString
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func Pause()

    $KeySpamN = GUICtrlRead($UIKeySpamN)
    $KeySpamSleep = GUICtrlRead($UIKeySpamSleep)
    $KeySpamVariation = GUICtrlRead($UIKeySpamVariation)
    $Class = GUICtrlRead($UIClass)
    $UIFeedBack = _IsChecked($UIFeedBack)

    $isPaused = not $isPaused
    If($isPaused) Then
        
        ToolTip("Paused. keyspamN: "&$KeySpamN&"\nKeysleep: "&$KeySpamSleep&"\nkeyvariation: "&$KeySpamVariation, 0, 0)
        $buttonText = "Go(F9)"
        GUICtrlSetBkColor($PauseButton, $COLOR_GREEN)
    Else
        $buttonText = "Stop(F9)"
        GUICtrlSetBkColor($PauseButton, $COLOR_RED)
    EndIf

    GUICtrlSetData($PauseButton, $buttonText)
EndFunc

Func Terminate()
    Exit
EndFunc



; check the status of the checkbox
Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked