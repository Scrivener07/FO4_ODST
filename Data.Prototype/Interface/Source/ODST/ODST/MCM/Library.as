package
{
	import flash.display.MovieClip;
	import Shared.AS3.Debug;
	import Shared.MCM.ICodeObject;

	public class Library extends MovieClip implements ICodeObject
	{
		public var EmblemPreview:Preview;

		public function Library()
		{
			Debug.WriteLine("[ODST.MCM]", "[Library]", "(ctor)", "Constructor Code");
		}

		public function onLibLoaded(mcmCodeObject:*, f4seCodeObject:*):void
		{
			Debug.WriteLine("[ODST.MCM]", "[Library]", "(onLibLoaded)", "MCM scaleform callback has been received.");
			// Debug.TraceObject(f4seCodeObject);
			// Debug.TraceObject(mcmCodeObject);
			EmblemPreview.onLibLoaded(mcmCodeObject, f4seCodeObject);
		}

	}
}
