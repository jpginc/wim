class SpecialKeysClass
{
	specialChars := "¢¤¥¦§©ª«®µ¶"
	escapeSpecialChar := "¢"
	escapeSpecialChar := "¤"
	
	splitTriggerString(string)
	{
		StringReplace, string, string, Escape, % this.escapeSpecialChar, All
		StringReplace, string, string, Esc, % this.escSpecialChar, All
		arr := []
		Loop, parse, string
		{
			if(A_loopfield == this.escapeSpecialChar)
			{
				arr.Insert("Escape")
			} else if(A_loopfield == this.escSpecialChar)
			{
				arr.Insert("Esc")
			} else
			{
				arr.Insert(A_loopfield)
			}
		}
		return arr
	}
}