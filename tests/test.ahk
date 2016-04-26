wim := new WimClass()

if(! wim)
{
	debugger("Error wim class not defined")
}

if(wim.mode != "insert")
{
	debugger("wim should start off in insert mode`nMode is: " wim.mode)
}

wim.mode := "insert"
wim.registerKey("Esc")

if(wim.mode != "normal")
{
	debugger("Esc should put wim into normal mode")
}

wim.mode := "insert"
wim.registerKey("Esc")

if(wim.mode != "normal")
{
	debugger("Escape should put wim into normal mode")
}

wim.mode := "normal"
wim.registerKey("i")

if(wim.mode != "insert")
{
	debugger("i should change wim from normal mode to insert mode")
}

wim.mode := "insert"
wim.addNormalModeShortcut("j")
wim.registerKey("j")

if(wim.mode != "normal")
{
	debugger("regestring a normal shortcut isn't working")
}

wim := new WimClass()
wim.addNormalModeShortcut("jk")
	.registerKey("j")
	.registerKey("k")
	
if(wim.mode != "normal")
{
	debugger("registering a multi key shortcut doesnt work")
}

ExitApp
#Include debugger.ahk
#Include ../Wim.ahk