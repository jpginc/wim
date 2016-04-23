class WimClass
{
	
	mode := "insert"
	
	registerKey(key)
	{
		if(key == "Esc" || key == "Escape")
		{
			this.mode := "normal"
		}
		if(key == "i")
		{
			this.mode := "insert"
		}
		return
	}
}