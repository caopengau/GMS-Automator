#include "BasicUI.au3"
#include "Utility.au3"

; main loop for kanna
While 1
    If($isPaused) Then
        Sleep(100) ; Paused, Sleep to reduce CPU usage
    Else
        ; running training automator strategy/skill combo
         TripleHauntTeleport()
    EndIf
WEnd

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; skill combo for kanna

; TripleHaunt and teleport
Func TripleHauntTeleport()
	TripleHaunt()
	EtherPulse()
	Sleep(500)  ; sleep time is dependant on attack speed, can be optimised
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; basic skill
; basic attack 3 times combo for kanna
Func TripleHaunt()
	If($UIFeedBack) Then    ; update and show feedback if User wants it
		$feedBackString = "Triple Haunt"
        ToolTip($feedBackString, 0, 0)
	EndIf
    WinActivate ( $GMS )    ; make sure we activate the windows and send to the right program

   
	SpamKey("f")
    Sleep(100)
	SpamKey("f")
    Sleep(100)
	SpamKey("f")
	Sleep(100)
EndFunc

; Ether Pulse
Func EtherPulse()
	If($UIFeedBack) Then
        $feedBackString = "Ether Pulse"	
        ToolTip($feedBackString, 0, 0)
	EndIf
	SpamKey("v")
	Sleep(300)
EndFunc