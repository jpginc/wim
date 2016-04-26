class MacroTriggerJudge
{
	shouldMacroTrigger(macro, buffer)
	{
		bufferStartIndex := buffer.MaxIndex() - macro.triggerArray.MaxIndex()
		
		loop, % macro.triggerArray.MaxIndex()
		{
			if(buffer[bufferStartIndex + A_Index] != macro.triggerArray[A_Index])
			{
				return false
			}
		}
		
		return true
	}
	
}