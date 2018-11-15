#include "BasicUI.au3"
#include "Utility.au3"

; UI constants
$UI_LEFT = 0    ; starting UI location
$UI_TOP = 0
$UI_WIDTH = 300 ; UI size
$UI_HEIGHT = 300
$BUTTON_WIDTH = 100 ; button size
$BUTTON_HEIGHT = 100
$LABEL_WIDTH = 200  ; label size
$INPUT_WIDTH = 50  ; input size
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

; UI column layout
$C1 = 10
$C2 = 60
$C3 = 110
$C4 = 160
$C5 = 210
$C6 = 260

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; setting UI
Global $SettingGUI = GUICreate("SettingGUI for GMS Traing Automator", $UI_WIDTH, $UI_HEIGHT, 10, 10)
GUISetOnEvent($GUI_EVENT_CLOSE, "Terminate")

GUICtrlCreateLabel("key", $C1, $R1, $LABEL_WIDTH)
GUICtrlCreateLabel("before delay", $C3, $R1, $LABEL_WIDTH)
GUICtrlCreateLabel("after delay", $C5, $R1, $LABEL_WIDTH)

Global $key = GUICtrlCreateInput("",  $C1, $R2, $INPUT_WIDTH)
Global $beforedelay = GUICtrlCreateInput("",  $C3, $R2, $INPUT_WIDTH)
Global $afterdelay = GUICtrlCreateInput("",  $C5, $R2, $INPUT_WIDTH)

Local $idButton_Add = GUICtrlCreateButton("Add", $C1 , $R3, 75, 25)
Local $idButton_Clear = GUICtrlCreateButton("Clear", $RIGHT_MARGIN - $INPUT_WIDTH, $R3, 75, 25)

Local $idMylist = GUICtrlCreateList("", $LEFT_MARGIN, $R4, 121, 97)

GUISetState(@SW_SHOW, $SettingGUI)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; main loop for Trainer
While 1
    If($isPaused) Then
        Sleep(100) ; Paused, Sleep to reduce CPU usage
        ToolTip("Paused", 0, 0)
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop
            Case $idButton_Add
                GUICtrlSetData($idMylist, "added")
            Case $idButton_Clear
                GUICtrlSetData($idMylist, "")
        EndSwitch

    Else
        ; running training automator strategy/skill combo
         TripleHauntTeleport()
    EndIf
WEnd