#include "..\Utility.au3"


Global $StartTime = TimerInit()
Global $TotalRunTime = 0
Global $left = False
Global $Cycle = TimerInit()
Global $Timer = 0
Global $MapleWarriorBuffTimer = 15000



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; key skill variable and initial setting
Global $N1_Cycle = 5
Global $N2_Cycle = 5
Global $N3_Cycle = 5
Global $startBuff = True
Global $Combo2 = False
Global $Combo3 = False


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Kinesis setting ui handler
Global $Kinesis_Setting_GUI = 9999
Global $idRadio1, $idRadio2, $idRadio3, $UI1_N_Cycle, $UI2_N_Cycle, $UI3_N_Cycle	; settings handlers

Global $SettingButton = GUICtrlCreateButton("Setting", $LEFT_MARGIN, $UI_HEIGHT - 25, 80, 20)	; button to trigger setting ui
GUICtrlSetTip(-1, "Strategy Setting (Key Binding and skill selection coming next patch)")
GUICtrlSetOnEvent($SettingButton, "Setting")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; main loop for Kinesis
While 1
	CheckPause()

	; running training automator strategy/skill combo
	ToolTip("Running Kinesis automator", 0, 0)
	
	$TotalRunTime = Round((TimerDiff($StartTime))/1000);
	
	If ($startBuff) Then
		$startBuff = False
		Regular3MinBuff()
	EndIf

	MasterBuff()
	
	If $Combo3 Then
		KinesisPush($N3_Cycle)
	ElseIf $Combo2 Then
		KinesisPush($N2_Cycle)
	Else
		KinesisPush($N1_Cycle)
	EndIf
WEnd


; Kinesis strategy
Func KinesisPush($n)

	If $left Then
		$dir = "left"
	Else
		$dir = "right"
	EndIf

	If $FeedBack Then
		$feedBackString = "Kinesis push towards" & $dir
	EndIf

	$count = 0


	While $count < $n
        CheckPause()
		WinActivate ( $GMS )
		DirectionDown($left)

		If $count == 2 Then
			SetDrain()
		EndIf
		If $count == 3 Then
			SpamKey("z")
		EndIf
		If $count == 1 Then
			SpamKey("b")
		EndIf
        If $Combo3 Then
            Kinesis3JumpGrab()
        ElseIf $Combo2 Then
            Kinesis2JumpGrab()
        Else
            KinesisJumpGrab()
        EndIf
		

		$count += 1
	WEnd

	SpamKey("2")
    DirectionUp($left)
	$left = not $left
EndFunc


; Kinesis Skill and combo
Func SetDrain()
	If $FeedBack Then
		$feedBackString = "Draining Force"
	EndIf
	SpamKey("y")
	Sleep(1000)
EndFunc

Func Kinesis3Jump()
	If $FeedBack Then
		$feedBackString = "Triple Jump (high)"
	EndIf
	SpamKey("d")
	Sleep(30)
	SpamKey("d")
	Sleep(140)
	SpamKey("d")
	Sleep(140)
	SpamKey("d")
EndFunc

Func Kinesis3JumpGrab()
	If $FeedBack Then
		$feedBackString = "Triple Jump (high) Grab"
	EndIf
	Kinesis3Jump()
	Sleep(100)
	SpamKey("f")
	Sleep(400)
EndFunc

Func Kinesis2JumpGrab()
	If $FeedBack Then
		$feedBackString = "Double Jump Grab"
	EndIf
	SpamKey("d")
	Sleep(30)
	SpamKey("d")
	SpamKey("d")
	Sleep(140)
	SpamKey("f")
	Sleep(500)
EndFunc

Func KinesisJumpGrab()
	If $FeedBack Then
		$feedBackString = "Jump Grab"
	EndIf
	SpamKey("d")
	Sleep(100)
	SpamKey("f")
	Sleep(500)
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Kinesis Buff
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
	While $isPaused
		Sleep(100)
	WEnd
EndFunc


Func On_Setting_Close()
	GUIDelete($Kinesis_Setting_GUI)
	GUICtrlSetState($SettingButton, $GUI_ENABLE)
EndFunc   ;==>On_Close_Secondary

Func Save_Setting()
	
	$Combo3 = (BitAND(GUICtrlRead($idRadio3), $GUI_CHECKED) = $GUI_CHECKED)
	$Combo2 = (BitAND(GUICtrlRead($idRadio2), $GUI_CHECKED) = $GUI_CHECKED)
	$N1_Cycle = GUICtrlRead($UI1_N_Cycle)
	$N2_Cycle = GUICtrlRead($UI2_N_Cycle)
	$N3_Cycle = GUICtrlRead($UI3_N_Cycle)


	GUIDelete($Kinesis_Setting_GUI)
	GUICtrlSetState($SettingButton, $GUI_ENABLE)
EndFunc   ;==>On_Button3

; If pause button pressed sleep in this loop
Func Setting()
	GUICtrlSetState($SettingButton, $GUI_DISABLE)

	$Kinesis_Setting_GUI = GUICreate("Kinesis setting", 200, 200, 350, 350)
	GUISetOnEvent($GUI_EVENT_CLOSE, "On_Setting_Close") ; Run this function when the secondary GUI [X] is clicked
	Local $idButton3 = GUICtrlCreateButton("Save", 10, 10, 80, 30)
	GUICtrlSetOnEvent(-1, "Save_Setting")


	$idRadio1 = GUICtrlCreateRadio("1 Jump Attack", 10, 45, 100, 20)
	$UI1_N_Cycle = GUICtrlCreateInput($N1_Cycle,  120, 45, $INPUT_WIDTH/2)

	
	$idRadio2 = GUICtrlCreateRadio("2 Jump Attack", 10, 65, 100, 20)
	$UI2_N_Cycle = GUICtrlCreateInput($N2_Cycle,  120, 65, $INPUT_WIDTH/2)


	$idRadio3 = GUICtrlCreateRadio("3 Jump Attack", 10, 85, 100, 20)
	$UI3_N_Cycle = GUICtrlCreateInput($N3_Cycle,  120, 85, $INPUT_WIDTH/2)

	; Show the current selection
	If $Combo3 Then
		GUICtrlSetState($idRadio3, $GUI_CHECKED)
	ElseIf $Combo2 Then
		GUICtrlSetState($idRadio2, $GUI_CHECKED)
	Else
		GUICtrlSetState($idRadio1, $GUI_CHECKED)
	EndIf

	GUISetState()
EndFunc