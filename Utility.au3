#include "BasicUI.au3"

; basic key stroke simulator
Func SpamKey($key)
	If $FeedBack Then
		FeedBackTip()
	EndIf
	
	$counter = 0
	$times = Random(0, $KeySpamVariation, 1)
	While $counter<$KeySpamN + $times
		Send("{"&$key&"}")
        Sleep(Random(0, $KeySpamSleep, 1))  ; sleep for random time
		$counter+=1
	WEnd

EndFunc

Func FeedBackTip()
	ToolTip($FeedBackString, 0, 0)
EndFunc

Func PauseTip()	; report current configuration
	ToolTip("Paused."& @CRLF& "keyspamN: "&$KeySpamN& @CRLF&  "Keysleep: "&$KeySpamSleep& @CRLF&  "keyvariation: "&$KeySpamVariation& @CRLF&  "Pet Food Key: "&$PetFoodKey, 0, 0)
        
EndFunc

Func FeedPet()
	If($FeedBack) Then
		$FeedBackString = "Feed Pet"
	EndIf
	SpamKey($PetFoodKey)
	Sleep(100)
EndFunc

; hold down the direction key $dir True for left, False for right
Func DirectionDown($dir)
	If $dir Then
		Spamkey("LEFT DOWN")
		Sleep(1)
	Else
		SpamKey("RIGHT DOWN")
		Sleep(1)
	EndIf
EndFunc

Func DirectionUp($dir)
	If $dir Then
		SpamKey("LEFT UP")
		Sleep(1)
	Else
		SpamKey("RIGHT UP")
		Sleep(1)
	EndIf
EndFunc

; resverse the current direction the character is facing
Func Reverse()
	If $Left Then
		Turn("right")
	Else
		Turn("left")
	EndIf
EndFunc

; turn to the direction specifiedd by $dir, "left" or else right
Func Turn($dir)
	If $dir == "left" Then
		SpamKey("LEFT")
	Else
		SpamKey("RIGHT")
	EndIf
EndFunc