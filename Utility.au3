#include "BasicUI.au3"

; basic key stroke simulator
Func SpamKey($key)

	$counter = 0
	$times = Random(0, $KeySpamVariation, 1)
	While $counter<$KeySpamN + $times
		Send("{"&$key&"}")
        Sleep(Random(0, $KeySpamSleep, 1))  ; sleep for random time
		$counter+=1
	WEnd

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