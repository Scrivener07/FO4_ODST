package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import AS3.*;
	import MCM.*;

	public class Preview extends MovieClip implements IMCMLibrary
	{
		public static const MenuName:String = "PauseMenu"; // use root menu?

		public var PrimaryTexture:TextureLoader;
		public static const PrimaryMountID:String = "ODST_EmblemPrimary";

		public var SecondaryTexture:TextureLoader;
		public static const SecondaryMountID:String = "ODST_EmblemSecondary";

		public var BackgroundTexture:TextureLoader;
		public static const BackgroundMountID:String = "ODST_EmblemBackground";


		public function Preview()
		{
			Debug.WriteLine("Preview", "ctor", "Constructor Code", "Hello");
		}

		public function onLibLoaded(mcmCodeObject:*, f4seCodeObject:*):void
		{
			Debug.WriteLine("Preview", "(onLibLoaded)", "MCM scaleform callback has been received.");

			PrimaryTexture.onF4SEObjCreated(f4seCodeObject);
			PrimaryTexture.ImageMountID = PrimaryMountID;
			PrimaryTexture.Load("ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Primary\\Spartan1.dds");

			SecondaryTexture.onF4SEObjCreated(f4seCodeObject);
			SecondaryTexture.ImageMountID = SecondaryMountID;
			SecondaryTexture.Load("ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Primary\\Spartan2.dds");

			BackgroundTexture.onF4SEObjCreated(f4seCodeObject);
			BackgroundTexture.ImageMountID = BackgroundMountID;
			BackgroundTexture.Load("ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Background\\Shield.dds");
		}


	}
}
