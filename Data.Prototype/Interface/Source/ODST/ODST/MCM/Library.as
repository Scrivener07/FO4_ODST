package
{
	import flash.display.MovieClip;
	import AS3.*;
	import MCM.*;

	public class Library extends MovieClip implements IMCMLibrary
	{
		public var EmblemPreview:Preview;

		public function Library()
		{
			Debug.WriteLine("Library", "(ctor)", "Constructor Code");
		}

		public function onLibLoaded(mcmCodeObject:*, f4seCodeObject:*):void
		{
			Debug.WriteLine("Library", "(onLibLoaded)", "MCM scaleform callback has been received.");
			Debug.TraceObject(f4seCodeObject);
			Debug.TraceObject(mcmCodeObject);
			EmblemPreview.onLibLoaded(mcmCodeObject, f4seCodeObject);
		}

	}
}
