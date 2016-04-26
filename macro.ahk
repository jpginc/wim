/*
 * check the SpecialKeysClass for a list of supported special keys
 */
class MacroClass
{
	__new(triggerString)
	{
		this.triggerString := triggerString
		this.triggerArray := SpecialKeysClass().splitTriggerString(triggerString)
		return this
	}
	
}