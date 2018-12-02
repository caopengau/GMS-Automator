
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <ColorConstants.au3>


Opt("GUIOnEventMode", 1)        ; Change to OnEvent mode for GUI
Opt("WinTitleMatchMode", 2)     ; 1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase


; hotkey control
HotKeySet("{F9}", "Pause")
HotKeySet("{F10}", "Terminate")

INIT_VARS()
UI_BASICS()

Func INIT_VARS()
    ; UI constants
    Global $UI_LEFT = 0    ; starting UI location
    Global $UI_TOP = 0
    Global $UI_WIDTH = 300 ; UI size
    Global $UI_HEIGHT = 300
    Global $BUTTON_WIDTH = 100 ; button size
    Global $BUTTON_HEIGHT = 100
    Global $LABEL_WIDTH = 200  ; label size
    Global $INPUT_WIDTH = 100  ; input size
    Global $LEFT_MARGIN = 10   ; margin left
    Global $RIGHT_MARGIN = $UI_WIDTH - $LEFT_MARGIN    ; margin right
    Global $CHECKBOX_SIZE = 40 ; checkbox size

    ; UI row layout
    Global $R1 = 10
    Global $R2 = 40
    Global $R3 = 65
    Global $R4 = 90
    Global $R5 = 115
    Global $R6 = 140
    Global $R7 = 175

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    Global $KeySpamN
    Global $KeySpamSleep
    Global $KeySpamVariation
    ; Global $Class = GUICtrlRead($UIClass)
    Global $PetFoodKey
    Global $FeedBack

    ; initial variables and value
    Global $GMS = "MapleStory"      ; target program to send key stroke
    Global $isPaused = True        ; pause script, status indicator
    Global $devMode = False         ; developer mode for shortcutting
    Global $feedBackString
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EndFunc

Func UI_BASICS()

    Global $hMainGUI = GUICreate("GMS Traing Automator", $UI_WIDTH, $UI_HEIGHT, 0, 0)
    GUISetOnEvent($GUI_EVENT_CLOSE, "Terminate")

    GUICtrlCreateLabel("Welcome to GMS traning automator - by Cao", $LEFT_MARGIN, $R1)  ; greeting

    GUICtrlCreateLabel("Key Spam Number: (natural number)", $LEFT_MARGIN, $R2, $LABEL_WIDTH)
    GUICtrlSetTip(-1, "More strokes will ensure the skill to go off at the cost of higher delay and attracting GM, less than 3 is recommanded")
    Global $UIKeySpamN = GUICtrlCreateInput("1",  $RIGHT_MARGIN - $INPUT_WIDTH, $R2, $INPUT_WIDTH)

    GUICtrlCreateLabel("Key-Stroke Interval: (in milliseconds)", $LEFT_MARGIN, $R3, $LABEL_WIDTH)
    GUICtrlSetTip(-1, "Longer interval will simulate better human reaction time at the cost of skill/command delay. Reduce if you want faster action")
    Global $UIKeySpamSleep = GUICtrlCreateInput("11",  $RIGHT_MARGIN - $INPUT_WIDTH, $R3, $INPUT_WIDTH)

    GUICtrlCreateLabel("Key-Stroke Variation: (natural number)", $LEFT_MARGIN, $R4, $LABEL_WIDTH)
    GUICtrlSetTip(-1, "To create some random key strokes to simulate variation in key strokes, less than 3 is recommanded")
    Global $UIKeySpamVariation = GUICtrlCreateInput("1",  $RIGHT_MARGIN - $INPUT_WIDTH, $R4, $INPUT_WIDTH)


    ;GUICtrlCreateLabel("Class", $LEFT_MARGIN, $R5, $LABEL_WIDTH)
    ;Local $UIClass = GUICtrlCreateCombo("Kanna", $RIGHT_MARGIN - $INPUT_WIDTH, $R5, $BUTTON_WIDTH, $INPUT_WIDTH)
    ; ;;Add additional items to the combobox.
    ;GUICtrlSetData($UIClass, "Kanna|PersonalTrainer", "-")


    GUICtrlCreateLabel("Feedback", $LEFT_MARGIN, $R5, $LABEL_WIDTH)
    GUICtrlSetTip(-1, "Report what skill(button) is it doing right now")
    Global $UIFeedBack = GUICtrlCreateCheckbox("", $RIGHT_MARGIN - $INPUT_WIDTH -  $INPUT_WIDTH, $R5 - 5, $CHECKBOX_SIZE, $CHECKBOX_SIZE)

    GUICtrlCreateLabel("Pet Food key: ", $LEFT_MARGIN, $R6, $LABEL_WIDTH)
    GUICtrlSetTip(-1, "key for pet food (default F5)")
    Global $UIPetFood = GUICtrlCreateInput("F5",  $RIGHT_MARGIN - $INPUT_WIDTH, $R6, $INPUT_WIDTH)


    Global $PauseButton = GUICtrlCreateButton("Go(F9)", $UI_WIDTH - $BUTTON_WIDTH, $UI_HEIGHT - $BUTTON_HEIGHT, $BUTTON_WIDTH, $BUTTON_HEIGHT)
    GUICtrlSetBkColor($PauseButton, $COLOR_GREEN)
    GUICtrlSetOnEvent($PauseButton, "Pause")

    GUISetState(@SW_SHOW, $hMainGUI)
EndFunc

Func Pause()
    $isPaused = not $isPaused
    If($isPaused) Then
        GUICtrlSetBkColor($PauseButton, $COLOR_GREEN)
        GUICtrlSetData($PauseButton, "Go(F9)")
    Else
        GUICtrlSetBkColor($PauseButton, $COLOR_RED)
        GUICtrlSetData($PauseButton,  "Stop(F9)")
    EndIf
   

    $KeySpamN = GUICtrlRead($UIKeySpamN)
    $KeySpamSleep = GUICtrlRead($UIKeySpamSleep)
    $KeySpamVariation = GUICtrlRead($UIKeySpamVariation)
    ; $Class = GUICtrlRead($UIClass)
    $FeedBack = _IsChecked($UIFeedBack)
    $PetFoodKey = GUICtrlRead($UIPetFood)
EndFunc

Func Terminate()
    Exit
EndFunc

; check the status of the checkbox
Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked