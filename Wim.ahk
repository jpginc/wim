class WimClass
{
	goToNormalModeCombos := ["Esc", "Escape"]
	goToInsertModeCombos := ["i"]
	
	mode := "insert"
	
	__new()
	{
		this._inputBuffer := new InputBufferClass()
		return this
	}
	
	registerKey(key)
	{
		this._inputBuffer.registerKey(key)
		return this
	}
	
	addNormalModeShortcut(shortcut)
	{
		this.goToNormalModeCombos.insert(shortcut)
		return this
	}
	
	_inArray(arr, val)
	{
		loop, % arr.maxIndex()
		{
			if(arr[A_index] == val)
			{
				return true
			}
		}
		return false
	}
}

#Include macroTriggerJudge.ahk
#Include specialKeys.ahk
#Include macro.ahk