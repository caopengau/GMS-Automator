
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