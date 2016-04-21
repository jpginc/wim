;this is designed to work with winscript 
if(! globalController) 
{
	GlobalController = new wimControllerClass()
}
return
#c::ExitApp
class wimControllerClass 
{
	context := "screen_vim"
	
	setContext(newContext) 
	{
		this.context := newContext
		return
	}
	
	getContext()
	{
		return this.context
	}
}

screen_vim(controller) {
	controller.setContext("screen_vim")
	ToolTip, VIM, 0, 0, 20
	return
}
end_screen_vim(controlelr) {
	controlelr.setContext("")
	ToolTip, , 0, 0, 20
}
;place the hotkeys you wish to be active while running this script here
#if GlobalController.getContext() == "screen_vim" && ! shouldIgnoreHotkeys() 
;by default the escape key will cancel your shortcut
i::
esc::
{	
	end_screen_vim(globalController)
	return
}
+g::send ^{end}
g::
{
	return
}
/::sendAndEnd("^f", globalController)
`;::send {PGDN}
p::send {PGUP}
j::send {down}
k::send {up}
h::send {left}
l::send {right}
w::send ^{right}
b::send ^{left}
o::sendAndEnd("{end}{return}", globalController)
+o::sendAndEnd("{up}{end}{return}", globalController)

;place any hotkeys you want to be active all the time here
#if
!`::screen_vim(globalController)

;if we are not in vim mode and the 
#if ! shouldIgnoreJKKJ()
$j::
$k::
{
	if((A_PriorKey == "j" && A_ThisHotkey == "k") 
		|| (A_PriorKey == "k" && A_ThisHotkey == "j")
		&& A_TimeSincePriorHotkey != -1
		&& A_TimeSincePriorHotkey < 500)
	{
		Input ;cancel the other input 5 lines down
		screen_vim(globalController)
		return
	}
	;don't send the key for a bit, see if the combo is jk/jk to enter screen vim mode
	input, key, L1T0.5
	if(Errorlevel == "Timeout" || key)  ;if a key was pressed or the timeout reached send the key
	{
		send % key ? A_ThisHotkey key : A_ThisHotkey
	}
	return
}

sendAndEnd(toSend, controller) {
	send % toSend
	end_screen_vim(controller)
	return
}

shouldIgnoreJKKJ() 
{
	return shouldIgnoreHotkeys() || GlobalController.getContext() == "screen_vim"
}

shouldIgnoreHotkeys() 
{
	return WinActive("ahk_exe devenv.exe")
}

