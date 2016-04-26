class InputBufferClass
{
	static buffer := []
	
	registerKey(key)
	{
		this.buffer.Insert(key)
		return this
	}
}