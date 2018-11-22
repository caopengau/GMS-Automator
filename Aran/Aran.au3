#include "..\Utility.au3"


Global $StartTime = TimerInit()
Global $TotalRunTime = 0
Global $left = False
Global $Cycle = TimerInit()
Global $Timer = 0
Global $MapleWarriorBuffTimer = 15000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; key skill variable and initial setting
Global $Combo_N_Cycle = 5
Global $Basic_Attack_Key = "f"
Global $startBuff = True	; do we buff character as first action when the trainer runs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Aran setting ui handler
Global $Aran_Setting_GUI = 9999
Global $UICombo_N_Cycle, $UIBasic_Attack; settings handlers

Global $SettingButton = GUICtrlCreateButton("Setting", $LEFT_MARGIN, $UI_HEIGHT - 25, 80, 20)	; button to trigger setting ui
GUICtrlSetTip(-1, "Strategy Setting (Key Binding and skill selection coming next patch)")
GUICtrlSetOnEvent($SettingButton, "Setting")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; main loop for Aran
While 1
	CheckPause()

	; running training automator strategy/skill combo
	ToolTip("Running Aran automator", 0, 0)
	
	$TotalRunTime = Round((TimerDiff($StartTime))/1000);
	
	If ($startBuff) Then
		$startBuff = False
		Regular3MinBuff()
	EndIf

	MasterBuff()
	
	AranPush($Combo_N_Cycle)
WEnd

Func AranPush($n)

	If $left Then
		$dir = "left"
	Else
		$dir = "right"
	EndIf

	If $FeedBack Then
		$feedBackString = "AranPush towards" & $dir
	EndIf

	$count = 0
	While $count < $n
        CheckPause()
		WinActivate ( $GMS )
		DirectionDown($left)
		;Send("{f down}")
        SpamKey($Basic_Attack_Key &" down")
		Sleep(1000)
		$count += 1
	WEnd

	DirectionUp($left)
	$left = not $left
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Aran Buff
Func MasterBuff()

	WinActivate($GMS)
	$Timer = Round((TimerDiff($Cycle))/1000);
	ToolTip($Timer, 0, 0)
	If $Timer>=179 Then
		$Timer = 0
		Regular3MinBuff()
		Sleep(1000)
		$Cycle = TimerInit()
	EndIf
    
    CooldownBuff()

EndFunc

Func CooldownBuff()
	WinActivate($GMS)

    SpamKey("F1")
    SpamKey("z")
	SpamKey("x")
	SpamKey("3")
	SpamKey("w")
EndFunc

Func Regular3MinBuff()
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Regular3MinBuff"
	EndIf
	SpamKey("a")
	Sleep(3000)
	FeedPet()

	$MapleWarriorBuffTimer += 3

	If($MapleWarriorBuffTimer>=15) Then
		MapleWarrior()
	EndIf

EndFunc

Func MapleWarrior()
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "MapleWarrior"
	EndIf

	Sleep(1000)
	SpamKey("LSHIFT")
	Sleep(1500)

	$MapleWarriorBuffTimer = 0
EndFunc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



; If pause button pressed sleep in this loop
Func CheckPause()
    SpamKey($Basic_Attack_Key&" up")
	DirectionUp($left)
	DirectionUp(Not $left)

	While $isPaused
		Sleep(100)
	WEnd
EndFunc


Func On_Setting_Close()
	GUIDelete($Aran_Setting_GUI)
	GUICtrlSetState($SettingButton, $GUI_ENABLE)
EndFunc   ;==>On_Close_Secondary

Func Save_Setting()
	
	$Combo_N_Cycle = GUICtrlRead($UICombo_N_Cycle)
    $Basic_Attack_Key = GUICtrlRead($UIBasic_Attack)
	GUIDelete($Aran_Setting_GUI)
	GUICtrlSetState($SettingButton, $GUI_ENABLE)
EndFunc   ;==>On_Button3

; If pause button pressed sleep in this loop
Func Setting()
	GUICtrlSetState($SettingButton, $GUI_DISABLE)

	$Aran_Setting_GUI = GUICreate("Aran setting", 300, 500, 300, 0)
	GUISetOnEvent($GUI_EVENT_CLOSE, "On_Setting_Close") ; Run this function when the secondary GUI [X] is clicked
	Local $idButton3 = GUICtrlCreateButton("Save", 10, 10, 80, 30)
	GUICtrlSetOnEvent(-1, "Save_Setting")
    
	Local $idButton4 = GUICtrlCreateButton("Default", 150, 10, 80, 30)
	GUICtrlSetOnEvent(-1, "Default_Setting")

	GUICtrlCreateLabel("Combo x times x = ", $LEFT_MARGIN, 45, $LABEL_WIDTH - 100)
	$UICombo_N_Cycle = GUICtrlCreateInput($Combo_N_Cycle,  120, 45, $INPUT_WIDTH/2)

    KeybindUI()

	GUISetState()
EndFunc

Func KeybindUI()

	; key skill variable and initial setting
	GUICtrlCreateLabel("*Basic Attack", $LEFT_MARGIN, 110, $LABEL_WIDTH - 100)
	GUICtrlSetTip(-1, "You need at least have this skill")
	$UIBasic_Attack = GUICtrlCreateInput($Basic_Attack_Key,  $LEFT_MARGIN + 150, 110, $INPUT_WIDTH/2)


	GUICtrlCreateLabel("NOTE: Leave the following key empty or put skills/buffs with long cd on them", $LEFT_MARGIN, 350, $LABEL_WIDTH, 60)
	GUICtrlCreateLabel("F1,z,x,3,w", $LEFT_MARGIN, 380, $LABEL_WIDTH)

EndFunc

Func Default_Setting()

    Global $Combo_N_Cycle = 5
    Global $Basic_Attack_Key = "f"

	GUIDelete($Aran_Setting_GUI)
	GUICtrlSetState($SettingButton, $GUI_ENABLE)

	Setting()
EndFunc   ;==>On_Button3