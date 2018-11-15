
#include "..\Utility.au3"
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; key skill variable
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; skill cooldown tracker
Global $Cycle3s = TimerInit()	; 3s cd tracker
Global $Cycle21s = TimerInit() + 20000	; 21s
Global $Cycle51s = TimerInit() + 40000	; 51
Global $Cycle75s = TimerInit() + 86000
Global $Cycle121s = TimerInit() + 103000
Global $Cycle326s = TimerInit() + 303000
Global $Cycle240Buff = TimerInit() + 241000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; kanna UI
; UI constants

$R_3 = $UI_HEIGHT - 20
$R_2 = $UI_HEIGHT - 40
$R_1 = $UI_HEIGHT - 80


GUICtrlCreateLabel("Aggressive", $LEFT_MARGIN, $R_1, $LABEL_WIDTH - 100)
GUICtrlSetTip(-1, "Use mana balance to trade HP for mana")
Global $UIAggressive = GUICtrlCreateCheckbox("", $LEFT_MARGIN + 100, $R_1, $CHECKBOX_SIZE, $CHECKBOX_SIZE)

Local $idRadio1 = GUICtrlCreateRadio("Triple Haunt Teleport", 10, $R_2, 120, 20)
GUICtrlSetTip(-1, "For basic kanna")
Local $idRadio2 = GUICtrlCreateRadio("Corral Teleport", 10, $R_3, 120, 20)
GUICtrlSetTip(-1, "For strong kanna, coupled well with aggressive")
GUICtrlSetState($idRadio1, $GUI_CHECKED)

$xOryTeleport = True

; main loop for kanna
While 1
    If($isPaused) Then
        Sleep(100) ; Paused, Sleep to reduce CPU usage

		$BeAggressive = _IsChecked($UIAggressive)
		$xOryTeleport = (BitAND(GUICtrlRead($idRadio1), $GUI_CHECKED) = $GUI_CHECKED)

    Else
        ; running training automator strategy/skill combo
        ; TripleHauntTeleport()
		EfficientMobbing()
    EndIf
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

	If $xOryTeleport Then
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