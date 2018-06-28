package
{
	import flash.display.MovieClip;

	public class Library extends MovieClip
	{
		public var EmblemPreview:Preview;

		public function Library()
		{
			trace("Library.ctor", Preview.PrimaryMountID);
		}

		public function onLibLoaded(mcmCodeObject:*, f4seCodeObject:*):void
		{
			trace("Library.onLibLoaded");
			trace(f4seCodeObject.version);
		}

	}
}
