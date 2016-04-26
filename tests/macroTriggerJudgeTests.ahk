
;basic macro tests
judge := new MacroTriggerJudge()
macro1 := new MacroClass("a")

if(judge.shouldMacroTrigger(macro1, []))
{
	debugger("macro shouldn't trigger when no keys have been pressed!")
}

if(! judge.shouldMacroTrigger(macro1, ["a"]))
{
	debugger("simple macro should trigger")
}

if(! judge.shouldMacroTrigger(macro1, ["b", "a"]))
{
	debugger("macro should trigger with a muti character buffer")
}

;muti key macro test

macro2 := new MacroClass("ab")

if(judge.shouldMacroTrigger(macro2, ["a"]))
{
	debugger("macro should only trigger on full match")
}

if(! judge.shouldMacroTrigger(macro2, ["a", "b"]))
{
	debugger("multi character macro should trigger")
}

;special key macro test
macro3 := new MacroClass("Esc")

if(judge.shouldMacroTrigger(macro3, ["E", "s", "c"]))
{
	debugger("special key shouldnt trigger from normal input")
}

if(! judge.shouldMacroTrigger(macro3, ["Esc"]))
{
	debugger("special key should trigger")
}


ExitApp
#c::ExitApp
#Include debugger.ahk
#include ../macroTriggerJudge.ahk
#include ../macro.ahk