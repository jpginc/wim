class MacroClass
{
	__new(mode, keyCombo)
	{
		this.mode := mode
		this.keyCombo := keyCombo
		return this
	}
	
	setPostMacroMode(mode)
	{
		this.postMacroMode := mode
		return this
	}
	
	matchesMacro(keys)
	{
		return StrLen(keys) == StrLen(this.keyCombo) && instr(this.keyCombo, keys, true) == 1
	}
	
	partMatchesMacro(keys)
	{
		debugger(keys "`n" this.keyCombo)
		return instr(this.keyCombo, keys, true) == 1
	}
}