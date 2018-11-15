#include "..\Utility.au3"

Global $StartTime = TimerInit()
Global $TotalRunTime = 0
Global $left = False

Global $Cycle = TimerInit() + 40000
Global $Timer = 0
Global $MapleWarriorBuffTimer = 15000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mercedes UI
; UI constants

$R_3 = $UI_HEIGHT - 20
$R_2 = $UI_HEIGHT - 40
$R_1 = $UI_HEIGHT - 60


Local $idRadio1 = GUICtrlCreateRadio("Lightning flatmap", 10, $R_1, 120, 20)
GUICtrlSetTip(-1, "For _ shape flat map")
Local $idRadio2 = GUICtrlCreateRadio("PlatForm3", 10, $R_2, 120, 20)
GUICtrlSetTip(-1, "For -_- shape map")
Local $idRadio3 = GUICtrlCreateRadio("TwoParallel", 10, $R_3, 120, 20)
GUICtrlSetTip(-1, "For = shape map")
GUICtrlSetState($idRadio3, $GUI_CHECKED)

Global $Combo3 = (BitAND(GUICtrlRead($idRadio3), $GUI_CHECKED) = $GUI_CHECKED)
Global $Combo2 = (BitAND(GUICtrlRead($idRadio2), $GUI_CHECKED) = $GUI_CHECKED)

$startBuff = True


; main loop for mercedes
While 1
	CheckPause()

	$Combo3 = (BitAND(GUICtrlRead($idRadio3), $GUI_CHECKED) = $GUI_CHECKED)
	$Combo2 = (BitAND(GUICtrlRead($idRadio2), $GUI_CHECKED) = $GUI_CHECKED)

	; running training automator strategy/skill combo
	ToolTip("Running mercedes automator", 0, 0)
	
	$TotalRunTime = Round((TimerDiff($StartTime))/1000);
	
	If ($startBuff) Then
		$startBuff = False
		Regular3MinBuff()
	EndIf

	MasterBuff()

	If $Combo3 Then
		TwoParallel(3)
	ElseIf $Combo2 Then
		PlatForm3()
	Else
		LightingClear(6)
	EndIf
WEnd




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Merc Buff
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
	SpamKey("3")
	SpamKey("4")
	SpamKey("5")
	SpamKey("6")
	SpamKey("7")
	SpamKey("w")
	SpamKey("q")
	SpamKey("F1")
	SpamKey("F2")

EndFunc

Func Regular3MinBuff()
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Regular3MinBuff"
	EndIf
	SpamKey("a")
	Sleep(4000)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Merc individual skill

; Stunning Strike
Func StunningStrike()
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Stunning Strike"
	EndIf
	SpamKey("f")
	Sleep(500)
EndFunc

; Unicorn
Func Unicorn()
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Unicorn"
	EndIf
	SpamKey("h")
	Sleep(1050)
EndFunc

; Gust Dive
Func GustDive($dir)
	WinActivate($GMS)

	If($FeedBack) Then
		$feedBackString = "Gust Dive"
	EndIf
	DirectionDown($dir)
	SpamKey("e")
	DirectionUp($dir)

	Sleep(700)
EndFunc

; Rishing Rush + Ariel Barrage
Func RushUp()
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Rushup"
	EndIf
	SpamKey("v")
	Sleep(600)
	SpamKey("c")
	Sleep(150)
EndFunc

; Rishing Rush + Rolling Moonsault
Func RushRoll()
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Rishing Rush + Rolling Moonsault"
	EndIf

	SpamKey("v")
	Sleep(600)
	SpamKey("x")
	Sleep(300)
EndFunc


; Lightning Edge
Func LightningEdge($dir)
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Lightning Edge"
	EndIf
	DirectionDown($dir)
	DirectionDown($dir)
	SpamKey("s")
	Sleep(170)
	
	DirectionUp($dir)
EndFunc

; Wraith of Enlil edge
Func Wraith($afterdelay)
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Wraith of Enlil edge"
	EndIf
	SpamKey("g")
	Sleep($afterdelay)
EndFunc

; Leap Tornado
; longer delay, longer delay skill, lower height when fired
Func Tornado($delay1, $delay2)
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Leap Tornado"
	EndIf
	Sleep($delay1)
	SpamKey("t")
	Sleep($delay2)
EndFunc

; Spike Royale
Func Spike($delay)
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Spike Royale"
	EndIf
	SpamKey("y")
	Sleep($delay)
EndFunc

; Rolling Moonsault
; longer delay, longer delay skill, lower height when fired
Func RollMoonSault($delay)
	WinActivate($GMS)
	If($FeedBack) Then
		$feedBackString = "Rolling Moonsault"
	EndIf
	Sleep($delay)
	SpamKey("x")
	Sleep(250)
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Merc combos
; Merc 2-combo skill

Func LightningRushup($dir)
	LightningEdge($dir)
	Sleep(50)
	RushUp()
EndFunc

; flash/teleport up while perform some airborne skill
Func Flash()
	WinActivate($GMS)
	DirectionUp(not $left)
	DirectionUp($left)
	Send ("{UP DOWN}")
	SpamKey("z")
	Sleep(500)
EndFunc

; Merc 3-combo skill
Func LightningRushupTornado($dir, $tornadoDelay1, $tornadoDelay2)
	LightningRushup($dir)
	Tornado($tornadoDelay1, $tornadoDelay2)
EndFunc

Func RushupTornadoSpike($td1, $td2)
	Rushup()
	Tornado($td1, $td2)
	Spike(500)
EndFunc

Func RushupSpikeTornado($td1, $td2)
	Rushup()
	Spike(500)
	Tornado($td1, $td2)
EndFunc

Func LightningRushupSpike($dir)
	LightningRushup($dir)
	Spike(500)
EndFunc

Func WraithLightningRushup($dir)
	Wraith(0)
	LightningRushup($dir)
EndFunc

Func LightningRushupRoll($dir, $delayRoll)
	LightningRushup($dir)
	RollMoonSault($delayRoll)
EndFunc

; Merc 4-combo skill
Func LightningWraithRushupSpike()
	LightningEdge($left)
	Wraith(700)
	RushUp()
	Spike(500)
EndFunc


Func LightningWraithRushupRoll($delayRoll)
	LightningEdge($left)
	Wraith(700)
	RushUp()
	RollMoonSault($delayRoll)
EndFunc


; Merc 5-combo skill
Func LightningWraithRushupSpikeTornado($tornadoDelay)
	LightningEdge($left)
	Wraith(700)
	RushUp()
	Spike(500)
	Tornado($tornadoDelay, 250)
EndFunc

Func RushupSpikeReverseGustLightningWraith()

	; w8 for buff animation
	Sleep(1500)


	Rushup()
	Spike(500)
	Sleep(550)
	GustDive(not $left)
	LightningEdge(not $left)
	Wraith(300)

	$left = not $left
EndFunc

Func LightningRushupTornadoSpikeWraith($reverseSW)
	LightningRushupTornado($left, 0, 0)

	If($reverseSW) Then
		DirectionDown(not $left)
	Else
		DirectionDown($left)
	EndIf

	Spike(300)

	DirectionUp(not $left)
	DirectionUp($left)
	Wraith(700)

EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; training map specific combo usage
; movement and skill opitimal for "-_-" type map, such as FlyonMap, Bitty-bobble forest 1
Func PlatForm3()

	; w8 for buff animation
	Sleep(2000)
	CheckPause()
	WraithLightningRushup(not $left)
	Sleep(100)
	Spike(500)

	$left = not $left
EndFunc

; combo for dps against stationary boss
Func ComboBossing()
	StunningStrike()
	Wraith(300)
	StunningStrike()
	Unicorn()
	StunningStrike()
	Spike(500)
	Tornado(0, 300)

	DirectionUp($Left)

	GustDive($left)

	$Left = Not $Left
	DirectionDown($Left)
EndFunc


;; invincible whole time
;; good for flatmap mobbing
Func RushupDive($Times)
	$Count = 0


	; for adjusting times
	Sleep(1000)

	While $Count<$Times
		Rushup()
		Sleep(500)
		GustDive($left)
		$Count+=1
	WEnd

	$Left = Not $Left
EndFunc

;; similar to RushUpDive, but faster though not invincible
;; good for flatmap mobbing
Func LightingClear($Times)
	$Count = 0


	DirectionDown($Left)

	While $Count<$Times
		CheckPause()
		LightningEdge($left)
		Sleep(1)
		SpamKey("t")
		$Count+=1
	WEnd

	DirectionUp($Left)

	; for adjusting times
	Sleep(1000)

	$Left = Not $Left
EndFunc

;; good for clearing map in = shape
Func TwoParallel($n)

	Sleep(1000)
	$count = 0

	While $count<$n
		CheckPause()
		If ($count < $n-1) Then
			LightningRushupTornadoSpikeWraith(False)
		Else
			LightningRushupTornadoSpikeWraith(True)
		EndIf
		$count+=1
	WEnd

	$left = not $left
EndFunc
