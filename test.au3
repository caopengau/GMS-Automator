#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Opt("GUIOnEventMode", 1)

Global $g_hGUI2, $g_idButton2 ; Predeclare these variables

Local $hGUI1 = GUICreate("Gui 1", 200, 200, 100, 100)
GUISetOnEvent($GUI_EVENT_CLOSE, "On_Close_Main") ; Run this function when the main GUI [X] is clicked
Local $idButton1 = GUICtrlCreateButton("Msgbox 1", 10, 10, 80, 30)
GUICtrlSetOnEvent(-1, "On_Button1")
Local $g_idButton2 = GUICtrlCreateButton("Show Gui 2", 10, 60, 80, 30)
GUICtrlSetOnEvent(-1, "On_Button2")
GUISetState()

While 1
    Sleep(10)
WEnd

Func gui2()
	Local $g_hGUI2 = GUICreate("Gui 2", 200, 200, 350, 350)
	GUISetOnEvent($GUI_EVENT_CLOSE, "On_Close_Secondary") ; Run this function when the secondary GUI [X] is clicked
	Local $idButton3 = GUICtrlCreateButton("MsgBox 2", 10, 10, 80, 30)
	GUICtrlSetOnEvent(-1, "On_Button3")
	GUISetState()
EndFunc   ;==>gui2

Func On_Close_Main()
	Exit
EndFunc   ;==>On_Close_Main

Func On_Close_Secondary()
	GUIDelete($g_hGUI2)
	GUICtrlSetState($g_idButton2, $GUI_ENABLE)
EndFunc   ;==>On_Close_Secondary

Func On_Button1()
	MsgBox($MB_OK, "MsgBox 1", "Test from Gui 1")
EndFunc   ;==>On_Button1

Func On_Button2()
	GUICtrlSetState($g_idButton2, $GUI_DISABLE)
	gui2()
EndFunc   ;==>On_Button2

Func On_Button3()
	MsgBox($MB_OK, "MsgBox 2", "Test from Gui 2")
EndFunc   ;==>On_Button3