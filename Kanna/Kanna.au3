
#include "..\Utility.au3"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; key skill variable and initial setting
$BasicHauntKey = "f"
$EtherPulseSKey = "v"
$GoblinFootKey = "h"
$KishinKey = "LSHIFT"
$OrochiKey = "c"
$NimbusCurseKey = "y"
$CorralKey = "g"
$NineTailKey = "z"
$GrandPaKey = "e"
$FeedPetKey = "F5"
$ManaBalancekey = "2"


$BeAggressive = False ; use ManaBalance

$BuffKey = "q"	; this buff has 4 min interval and cast w8 time

$NeedSpamBuff = True	; put any buff/skill with cd time on these keys: 3,4,5,6,7,a,w,s,ALT,F1,F2

$TrippleHauntOrCoral = True

$startBuff = True	; do we buff character as first action when the trainer runs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; skill cooldown tracker
$Cycle3s = TimerInit()	; 3s cd tracker
$Cycle21s = TimerInit()
$Cycle51s = TimerInit()
$Cycle75s = TimerInit()
$Cycle121s = TimerInit()
$Cycle326s = TimerInit()
$Cycle240Buff = TimerInit()

Global $Kanna_Setting_GUI = 9999	; kanna setting ui handler
Global $SettingButton = GUICtrlCreateButton("Setting", $LEFT_MARGIN, $UI_HEIGHT - 25, 80, 20)	; button to trigger setting ui

GUICtrlSetTip(-1, "Strategy Setting (Key Binding and skill selection coming next patch)")
GUICtrlSetOnEvent($SettingButton, "Setting")

Global $UIAggressive, $idRadio1, $idRadio2	; settings handlers


; If pause button pressed sleep in this loop
Func Setting()
	GUICtrlSetState($SettingButton, $GUI_DISABLE)

	$Kanna_Setting_GUI = GUICreate("Kanna setting", 200, 200, 350, 350)
	GUISetOnEvent($GUI_EVENT_CLOSE, "On_Setting_Close") ; Run this function when the secondary GUI [X] is clicked
	Local $idButton3 = GUICtrlCreateButton("Save", 10, 10, 80, 30)
	GUICtrlSetOnEvent(-1, "Save_Setting")


	GUICtrlCreateLabel("Aggressive", $LEFT_MARGIN, 45, $LABEL_WIDTH - 100)
	GUICtrlSetTip(-1, "Use mana balance to trade HP for mana")
	$UIAggressive = GUICtrlCreateCheckbox("", $LEFT_MARGIN + 100, 30, $CHECKBOX_SIZE, $CHECKBOX_SIZE)
	If $BeAggressive Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	EndIf


	$idRadio1 = GUICtrlCreateRadio("Triple Haunt Teleport", 10, 70, 120, 20)
	GUICtrlSetTip(-1, "For basic kanna")
	$idRadio2 = GUICtrlCreateRadio("Corral Teleport", 10, 90, 120, 20)
	GUICtrlSetTip(-1, "For mana-rich aggressive kanna, high hp regeneration and mana recovery needed to support this mode")
	If $TrippleHauntOrCoral Then
		GUICtrlSetState($idRadio1, $GUI_CHECKED)
	Else
		GUICtrlSetState($idRadio2, $GUI_CHECKED)
	EndIf

	GUISetState()
EndFunc

; main loop for kanna
While 1
	
	While $isPaused
		Sleep(100)
	WEnd



	If ($startBuff) Then
		$startBuff = False
		Regular4MinBuff()
	EndIf

	; training strategy
	EfficientMobbing()
WEnd


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; strategy for kanna
Func EfficientMobbing()

	If(Round((TimerDiff($Cycle75s))/1000)>75) Then
		Kishin()
	EndIf


	If $NeedSpamBuff Then
		CooldownBuff()
	EndIf

	If(Round((TimerDiff($Cycle240Buff))/1000)>240) Then
		Regular4MinBuff()
	EndIf

	If(Round((TimerDiff($Cycle21s))/1000)>21) Then
		Orochi()
	EndIf

	If(Round((TimerDiff($Cycle51s))/1000)>51) Then
		NimbusCurse()
	EndIf

	If(Round((TimerDiff($Cycle121s))/1000)>121) Then
		GoblinFoot()
	EndIf

	If(Round((TimerDiff($Cycle326s))/1000)>326) Then
		NineTail()
	EndIf

	If $TrippleHauntOrCoral Then
		TripleHauntTeleport()
	Else
		CorralTeleport()
	EndIf

EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; skill combo for kanna

; TripleHaunt and teleport
Func TripleHauntTeleport()
	WinActivate($GMS)

	TripleHaunt()
	EtherPulse()
	; sleep time is dependant on attack speed, can be optimised
EndFunc

; Corral and teleport
Func CorralTeleport()
	WinActivate($GMS)

	Corral()
	EtherPulse()
EndFunc

; use this buff at 4mins interval
Func Regular4MinBuff()
	WinActivate($GMS)

	$Cycle240Buff = TimerInit()
	If($FeedBack) Then
		$feedBackString = "Regular4MinBuff"
	EndIf
	SpamKey($BuffKey)
	Sleep(4000)
	FeedPet()
EndFunc

; try to activate all these buff with cooldown
Func CooldownBuff()
	WinActivate($GMS)

	SpamKey("ALT")
	SpamKey("w")	; sengoku army
	SpamKey("F1")	; hilla	soul summon
	If $BeAggressive Then
		SpamKey($ManaBalancekey)
	EndIf
	SpamKey("a")	; frost girl
	SpamKey("3")	; decent HS
	SpamKey("4")	; decent crit
	SpamKey("5")	;
	SpamKey("6")	; princess
	SpamKey("7")	; heal tree
	SpamKey("F2")	; decent body
	SpamKey("s")	; rush across to loot
	
	SpamKey($GrandPaKey)	; rush across to loot
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; basic skill
; basic attack 3 times combo for kanna
Func TripleHaunt()
	WinActivate($GMS)

	If($FeedBack) Then    ; update and show feedback if User wants it
		$feedBackString = "Triple Haunt"
        ToolTip($feedBackString, 0, 0)
	EndIf

	SpamKey($BasicHauntKey)
    Sleep(100)
	SpamKey($BasicHauntKey)
    Sleep(100)
	SpamKey($BasicHauntKey)
	Sleep(100)
EndFunc

; Ether Pulse
Func EtherPulse()
	WinActivate($GMS)

	If($FeedBack) Then
        $feedBackString = "Ether Pulse"	
        ToolTip($feedBackString, 0, 0)
	EndIf
	SpamKey($EtherPulseSKey)
	Sleep(300)
EndFunc

; NineTail
Func NineTail()
	WinActivate($GMS)

	If($FeedBack) Then
		$feedBackString = "NineTail"
	EndIf
	Sleep(500)
	SpamKey($NineTailKey)
	$Cycle326s = TimerInit()
	Sleep(2000)
EndFunc

; Corral
Func Corral()
	WinActivate($GMS)

	If($FeedBack) Then
		$feedBackString = "Corral"
	EndIf
	SpamKey($CorralKey)
EndFunc

; Kishin
Func Kishin()
	WinActivate($GMS)

	If $BeAggressive Then	; ensure we have mana for kishin
		SpamKey($ManaBalancekey)
	EndIf

	If($FeedBack) Then
		$feedBackString = "===================================Kishin==============================="
	EndIf
	Sleep(500)	; ensure the previous skill ends
	SpamKey($KishinKey)
	$Cycle75s = TimerInit()
	Sleep(1000)
EndFunc

; Orochi
Func Orochi()
	WinActivate($GMS)

	If $BeAggressive Then
		SpamKey($ManaBalancekey)
	EndIf

	Sleep(500)	; ensure the previous skill ends
	If($FeedBack) Then
		$feedBackString = "Orochi"
	EndIf

	SpamKey($OrochiKey)
	$Cycle21s = TimerInit()
	Sleep(2000)

EndFunc

; Orochi
Func NimbusCurse()
	WinActivate($GMS)

	If($FeedBack) Then
		$feedBackString = "NimbusCurse"
	EndIf
	SpamKey($NimbusCurseKey)
	$Cycle51s = TimerInit()
	Sleep(200)
EndFunc

; GoblinFoot
Func GoblinFoot()
	WinActivate($GMS)

	If($FeedBack) Then
		$feedBackString = "GoblinFoot"
	EndIf
	SpamKey($GoblinFootKey)
	$Cycle121s = TimerInit()
	Sleep(200)
EndFunc

; Grandpa
Func Grandpa()
	WinActivate($GMS)

	If($FeedBack) Then
		$feedBackString = "Grand Pa"
	EndIf
	Sleep(500)
	SpamKey($GrandPaKey)
	Sleep(500)
EndFunc

Func On_Setting_Close()
	GUIDelete($Kanna_Setting_GUI)
	GUICtrlSetState($SettingButton, $GUI_ENABLE)
EndFunc   ;==>On_Close_Secondary

Func Save_Setting()
	
	$BeAggressive = _IsChecked($UIAggressive)
	$TrippleHauntOrCoral = (BitAND(GUICtrlRead($idRadio1), $GUI_CHECKED) = $GUI_CHECKED)
	
	GUIDelete($Kanna_Setting_GUI)
	GUICtrlSetState($SettingButton, $GUI_ENABLE)
EndFunc   ;==>On_Button3