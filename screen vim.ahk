globalWim := new WimClass()
#include defaultMacros.ahk

globalWim.addMany(globalDefaultMacros)
#if


return
#c::ExitApp

class WimClass
{
	mode := "insert"
	insertModeHistory := ""
	macroKeyBuffer := []
	
	static _allKeys := "1234567890qwertyuiopasdfghjklzxcvbnm"
	static _specialKeys := ["Esc", "Escape"]
	static _allMacros := []
	
	__New()
	{
		this._startKeyLogger()
		return this
	}
	
	addHotkey(macroClass)
	{
		this._allMacros.Insert(macroClass)
		debugger("adding macro " this._allMacros.MaxIndex())
		return this
	}
	
	addMany(macroClasses)
	{
		debugger("in add many... " macroClasses.MaxIndex())
		Loop, % macroClasses.maxIndex()
		{
			this.addHotkey(macroClasses[A_Index])
		}
		return this
	}
	
	_startKeyLogger()
	{
		global globalWim
		#if globalWim.mode != "off"
		
		#UseHook, On
		callback := Func("WimClassCallback").Bind(this, "registerKeyPress")
		Hotkey, If, globalWim.mode != "off"

		Loop, parse, % this._allKeys
		{
			Hotkey, %A_LoopField%, % callback
		}
		loop, % this._specialKeys.MaxIndex()
		{
			tooltip % this._specialKeys[A_index]
			Hotkey, % this._specialKeys[A_index], % callback
		}
		
		Hotkey, If
		#UseHook Off
		return this
	}
	
	registerKeyPress(key)
	{
		this.macroKeyBuffer.Insert(key)
		if(this.mode == "insert")
		{
			this._handleKeyInsert(key)
		} else if(this.mode == "normal")
		{
			this.handleKeyNormal(key)
		} else if(this.mode == "visual")
		{
			this.handleKeyVisual(key)
		}
		return 
	}
	
	_handleKeyInsert(key)
	{
		
		this.insertModeHistory .= key
		
		this._sendUnNeededBufferedKeys()
		if(macro := this._getMatchingMacro())
		{
			this._executeMacro(macro)
		}

		return this
	}
	
	_executeMacro(macro)
	{
		this.macroKeyBuffer := []
		if(macro.postMacroMode)
		{
			debugger("mode is " macro.postMacroMode)
			this.mode := macro.postMacroMode
		}
		return this
	}
	
	_getMatchingMacro()
	{
		Loop, % this._allMacros.MaxIndex()
		{
			if(this._allMacros[A_Index].mode == this.mode)
			{
				if(this._allMacros[A_index].matchesMacro(key))
				{
					return this._allMacros[A_Index]
				}
			}
		}
		return false
	}
	
	_sendUnNeededBufferedKeys()
	{
		debugger("sending un needed stuff")
		while(this.macroKeyBuffer.MaxIndex())
		{
			str := this.makeStringFromArray(this.macroKeyBuffer)
			debugger("buffer is " str)
			if(! this._macrosMatchingKey(str).MaxIndex())
			{
				this._send(this.macroKeyBuffer.RemoveAt(1))
			} else
			{
				break
			}
		}
		return this
	}
	
	makeStringFromArray(arr)
	{
		str := ""
		Loop, % arr.maxIndex()
		{
			str .= arr[A_Index]
		}
		return str
	}
	
	_macrosMatchingKey(key)
	{
		debugger("matching key agains" key)
		matchingMacros := []
		Loop, % this._allMacros.MaxIndex()
		{
			if(this._allMacros[A_Index].mode == this.mode)
			{
				debugger("the mode matches")
				if(this._allMacros[A_index].partMatchesMacro(key))
				{
					matchingMacros.Insert(this._allMacros[A_Index])
				}
			}
		}
		debugger("the max index is " matchingMacros.MaxIndex())
		return matchingMacros
	}
	
	_send(key)
	{
		debugger("sending key is " key)
		if(StrLen(key) != 1)
		{
			key := "{" key "}"
		}
		send, % key
		
		return this
	}
}

WimClassCallback(controller, functionName)
{
	controller[functionName](A_ThisHotkey)
	return
}

debugger(message)
{
	ToolTip, % message
	sleep 300
	return
}


;~ screen_vim(controller) {
	;~ controller.setContext("screen_vim")
	;~ ToolTip, VIM, 0, 0, 20
	;~ return
;~ }
;~ end_screen_vim(controlelr) {
	;~ controlelr.setContext("")
	;~ ToolTip, , 0, 0, 20
;~ }
;~ ;place the hotkeys you wish to be active while running this script here
;~ #if GlobalController.getContext() == "screen_vim" && ! shouldIgnoreHotkeys() 
;~ ;by default the escape key will cancel your shortcut
;~ i::
;~ esc::
;~ {	
	;~ end_screen_vim(globalController)
	;~ return
;~ }
;~ +g::send ^{end}
;~ g::
;~ {
	;~ return
;~ }
;~
;~ o::sendAndEnd("{end}{return}", globalController)
;~ +o::sendAndEnd("{up}{end}{return}", globalController)

;~ ;place any hotkeys you want to be active all the time here
;~ #if
;~ !`::screen_vim(globalController)

;~ ;if we are not in vim mode and the 
;~ #if ! shouldIgnoreJKKJ()
;~ $j::
;~ $k::
;~ {
	;~ if((A_PriorKey == "j" && A_ThisHotkey == "k") 
		;~ || (A_PriorKey == "k" && A_ThisHotkey == "j")
		;~ && A_TimeSincePriorHotkey != -1
		;~ && A_TimeSincePriorHotkey < 500)
	;~ {
		;~ Input ;cancel the other input 5 lines down
		;~ screen_vim(globalController)
		;~ return
	;~ }
	;~ ;don't send the key for a bit, see if the combo is jk/jk to enter screen vim mode
	;~ input, key, L1T0.5
	;~ if(Errorlevel == "Timeout" || key)  ;if a key was pressed or the timeout reached send the key
	;~ {
		;~ send % key ? A_ThisHotkey key : A_ThisHotkey
	;~ }
	;~ return
;~ }

;~ sendAndEnd(toSend, controller) {
	;~ send % toSend
	;~ end_screen_vim(controller)
	;~ return
;~ }

;~ shouldIgnoreJKKJ() 
;~ {
	;~ return shouldIgnoreHotkeys() || GlobalController.getContext() == "screen_vim"
;~ }

;~ shouldIgnoreHotkeys() 
;~ {
	;~ return WinActive("ahk_exe devenv.exe")
;~ }

