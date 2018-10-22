package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.ColorTransform;
	import AS3.*;
	import F4SE.*;
	import ODST.*;

	public class EmblemMenu extends MovieClip implements F4SE.IExtensions
	{
		public static const MenuName:String = "ODST_EmblemMenu";

		public var PrimaryTexture:TextureLoader;
		public static const PrimaryMountID:String = "ODST_EmblemPrimary";

		public var SecondaryTexture:TextureLoader;
		public static const SecondaryMountID:String = "ODST_EmblemSecondary";

		public var BackgroundTexture:TextureLoader;
		public static const BackgroundMountID:String = "ODST_EmblemBackground";


		public function EmblemMenu()
		{
			Debug.WriteLine("[EmblemMenu]", "ctor", "Constructor Code");

			PrimaryTexture.MenuName = MenuName;
			PrimaryTexture.ImageMountID = PrimaryMountID;

			SecondaryTexture.MenuName = MenuName;
			SecondaryTexture.ImageMountID = SecondaryMountID;

			BackgroundTexture.MenuName = MenuName;
			BackgroundTexture.ImageMountID = BackgroundMountID;
		}


		// F4SE.IExtensions
		//---------------------------------------------

		public function onF4SEObjCreated(codeObject:*):void
		{ // @F4SE
			if(codeObject != null)
			{
				Debug.WriteLine("[EmblemMenu]", "(onF4SEObjCreated)", "Received F4SE code object.");
				PrimaryTexture.onF4SEObjCreated(codeObject);
				SecondaryTexture.onF4SEObjCreated(codeObject);
				BackgroundTexture.onF4SEObjCreated(codeObject);
			}
			else
			{
				Debug.WriteLine("[EmblemMenu]", "(onF4SEObjCreated)", "The f4se object is null.");
			}
		}


		// Papyrus
		//---------------------------------------------

		public function SetPrimary(filepath:String, color:int)
		{
			Debug.WriteLine("[EmblemMenu]", "SetPrimary", "filepath:"+filepath, "color:"+color);
			PrimaryTexture.Load(filepath);

			var tint = new ColorTransform();
			tint.color = color;
			PrimaryTexture.transform.colorTransform = tint;
		}


		public function SetSecondary(filepath:String, color:int)
		{
			Debug.WriteLine("[EmblemMenu]", "SetSecondary", "filepath:"+filepath, "color:"+color);
			SecondaryTexture.Load(filepath);

			var tint = new ColorTransform();
			tint.color = color;
			SecondaryTexture.transform.colorTransform = tint;
		}


		public function SetBackground(filepath:String, color:int)
		{
			Debug.WriteLine("[EmblemMenu]", "SetBackground", "filepath:"+filepath, "color:"+color);
			BackgroundTexture.Load(filepath);

			var tint = new ColorTransform();
			tint.color = color;
			BackgroundTexture.transform.colorTransform = tint;
		}


	}
}
