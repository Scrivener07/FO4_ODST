package Shared.MCM
{
	public interface IMCMLibrary
	{
		/* 1.28
		- added Scaleform receiving function
			- This function is called on the menu root document.
		*/
		function onLibLoaded(mcmCodeObject:*, f4seCodeObject:*):void;
	}
}
