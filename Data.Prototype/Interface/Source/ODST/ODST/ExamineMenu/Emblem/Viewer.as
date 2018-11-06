package Emblem
{
	import Components.TextureLoader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import Shared.AS3.Debug;
	import Shared.F4SE.ICodeObject;

	public class Viewer extends MovieClip implements ICodeObject
	{
		public static const MenuName:String = "ExamineMenu";

		public var Primary:TextureLoader;
		public static const PrimaryMountID:String = "ODST_EmblemPrimary";

		public var Secondary:TextureLoader;
		public static const SecondaryMountID:String = "ODST_EmblemSecondary";

		public var Background:TextureLoader;
		public static const BackgroundMountID:String = "ODST_EmblemBackground";


		// Viewer
		//---------------------------------------------

		public function Viewer()
		{
			Primary.MenuName = MenuName;
			Primary.ImageMountID = PrimaryMountID;
			Secondary.MenuName = MenuName;
			Secondary.ImageMountID = SecondaryMountID;
			Background.MenuName = MenuName;
			Background.ImageMountID = BackgroundMountID;
		}


		public function onF4SEObjCreated(codeObject:*):void
		{ // @F4SE, implements ICodeObject
			if(codeObject != null)
			{
				Primary.onF4SEObjCreated(codeObject);
				Secondary.onF4SEObjCreated(codeObject);
				Background.onF4SEObjCreated(codeObject);
				Debug.WriteLine("[Viewer]", "(onF4SEObjCreated)", "Received the F4SE code object.");
			}
			else
			{
				Debug.WriteLine("[Viewer]", "(onF4SEObjCreated)", "The f4se object was null.");
			}
		}


		// Methods
		//---------------------------------------------

		public function SetPrimary(filepath:String, color:int):void
		{
			Debug.WriteLine("[ODST]", "[Viewer]", "(SetPrimary)", "filepath:"+filepath, "color:"+color);
			Primary.Load(filepath);
			var tint = new ColorTransform();
			tint.color = color;
			Primary.transform.colorTransform = tint;
		}


		public function SetSecondary(filepath:String, color:int):void
		{
			Debug.WriteLine("[ODST]", "[Viewer]", "(SetSecondary)", "filepath:"+filepath, "color:"+color);
			Secondary.Load(filepath);
			var tint = new ColorTransform();
			tint.color = color;
			Secondary.transform.colorTransform = tint;
		}


		public function SetBackground(filepath:String, color:int):void
		{
			Debug.WriteLine("[ODST]", "[Viewer]", "(SetBackground)", "filepath:"+filepath, "color:"+color);
			Background.Load(filepath);
			var tint = new ColorTransform();
			tint.color = color;
			Background.transform.colorTransform = tint;
		}


	}
}
