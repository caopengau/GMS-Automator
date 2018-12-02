;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Welcome to tutorial one
; Objective 1: create a GUI(windows) for our automator for controls to our program
; Objective 2: locate the target program our automator is interested in, 
;              it is "MapleStory.txt - Notepad" in our tutorial case.
; PS: To have effect on actual Maplestory or any other .exe, just compile the script
;     then run as administrator. Because some program will reject the 
;     (This might trigger firewall, just allow action)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>

; initial fixed settings
Opt("GUIOnEventMode", 1)        ; change to OnEvent mode for GUI
Opt("WinTitleMatchMode", 2)     ; 1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase


; the target windows the automator is built for
;Global $targetWindows = "MapleStory.txt - Notepad"  ; for easier debugging and testing
Global $targetWindows = "MapleStory"              ; for real and final automator

Main()

Func Main()

    ; create a windows for our program
    AddControlWindows()

    While  1

        ; get the current active window
        $currentWindow = WinGetTitle("[active]")

        ; is the current windows our target window?
        if($currentWindow <> $targetWindows) Then
            ; activate the target windows in 1 second
            ToolTip("Activate target in 1 second", 0, 0)
            Sleep(1000)
            WinActivate($targetWindows)
        Else
        
            ; run the automating functions
            ToolTip("Running automator", 0, 0)
        EndIf

        Sleep(1000)
    WEnd
EndFunc


 ; add a control windows to our automator
Func AddControlWindows()
    ; create the windows
    Global $automatorMainWindow = GUICreate("GMS Traing Automator", 200, 200, 0, 0)

    ; close button will shut the program, now we need to define function "Terminate"
    GUISetOnEvent($GUI_EVENT_CLOSE, "Terminate")

    ; create the pause button
    Global $PauseButton = GUICtrlCreateButton("Go(F9)", 50, 50, 100, 100)

    ; inital state is paused
    $isPaused = True

    ; so the button should be green to resume the program
    GUICtrlSetBkColor($PauseButton, $COLOR_GREEN)

    ; trigger "Pause" function when the button is clicked
    GUICtrlSetOnEvent($PauseButton, "Pause")

    ; show our windows
    GUISetState(@SW_SHOW, $automatorMainWindow)
EndFunc

; Pause/Go button is pressed
Func Pause()
    $isPaused = not $isPaused
    If($isPaused) Then
        ; at paused state, the button click will resume the program
        GUICtrlSetBkColor($PauseButton, $COLOR_GREEN)
        ; change the button text
        GUICtrlSetData($PauseButton, "Go(F9)")
    Else
        ; at running state the button click will pause the program
        GUICtrlSetBkColor($PauseButton, $COLOR_RED)
        ; change the button text
        GUICtrlSetData($PauseButton,  "Stop(F9)")
    EndIf

EndFunc

; program shutdown for the close button getting clicked
Func Terminate()
    Exit
EndFunc
