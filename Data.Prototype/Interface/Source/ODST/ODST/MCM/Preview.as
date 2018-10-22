package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.*;
	import AS3.*;
	import MCM.*;
	import ODST.*;
	// TODO: Use a timer to poll for a mod setting update.
	/* Notes
		-I have not been successful in my attempts at mounting a texture to an MCM library object.
		I have tried to mount textures to the `PauseMenu` which I know will be open at the same
		time as MCM but no content loaded events are received.
		-My MCM library object will be re-constructed often while the menu is open but
		the `onLibLoaded` function is only called once after configs are loaded.
		-Any movieclips in the pause menu are auto-tinted to the games UI color.
		This makes the preview for emblem colors difficult.
		-The MCM menu has trouble refreshing values that have been modified in papyrus.
		-A positive thing is that I CAN populate emblem data from MCM mod settings. Yay!
		-I dont like the idea of polling for mod settting changes..
	*/
	public class Preview extends MovieClip implements IMCMLibrary
	{
		private var mcm:*;
		private var f4se:*;

		private var sEmblem_PreviewPrimary:String;
		private var sEmblem_PreviewSecondary:String;
		private var sEmblem_PreviewBackground:String;

		private var iEmblem_PreviewPrimaryColor:int;
		private var iEmblem_PreviewSecondaryColor:int;
		private var iEmblem_PreviewBackgroundColor:int;

		public static const MenuName:String = "PauseMenu"; // use root menu?

		public var PrimaryTexture:TextureLoader;
		public static const PrimaryMountID:String = "ODST_MCM_EmblemPrimary";

		public var SecondaryTexture:TextureLoader;
		public static const SecondaryMountID:String = "ODST_MCM_EmblemSecondary";

		public var BackgroundTexture:TextureLoader;
		public static const BackgroundMountID:String = "ODST_MCM_EmblemBackground";


		public function Preview()
		{
			Debug.WriteLine("[MCM]", "[Preview]", "(ctor)", "Constructor Code");

			PrimaryTexture.MenuName = MenuName;
			PrimaryTexture.ImageMountID = PrimaryMountID;

			SecondaryTexture.MenuName = MenuName;
			SecondaryTexture.ImageMountID = SecondaryMountID;

			BackgroundTexture.MenuName = MenuName;
			BackgroundTexture.ImageMountID = BackgroundMountID;

			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);

			// var timer:Timer = new Timer(3000); // rip
			// timer.addEventListener(TimerEvent.TIMER, OnTimer);
			// timer.start();


		}


		private function OnAddedToStage(e:Event) : void
		{
			Debug.WriteLine("Preview", "OnAddedToStage");
			Populate();
		}


		// private function OnTimer(e:TimerEvent):void
		// {
		// 	Debug.WriteLine("[MCM]", "[Preview]", "(OnTimer)", e);
		// 	Populate();
		// }


		public function onLibLoaded(mcmCodeObject:*, f4seCodeObject:*):void
		{
			Debug.WriteLine("[MCM]", "[Preview]", "(onLibLoaded)", "MCM scaleform callback has been received.");
			mcm = mcmCodeObject;
			f4se = f4seCodeObject;

			PrimaryTexture.onF4SEObjCreated(f4seCodeObject);
			SecondaryTexture.onF4SEObjCreated(f4seCodeObject);
			BackgroundTexture.onF4SEObjCreated(f4seCodeObject);

			Populate();
		}


		private function Populate():void
		{
			if(mcm != null)
			{
				sEmblem_PreviewPrimary = mcm.GetModSettingString("ODST", "sEmblem_PreviewPrimary:Settings");
				iEmblem_PreviewPrimaryColor = mcm.GetModSettingInt("ODST", "iEmblem_PreviewPrimaryColor:Settings");
				SetEmblem(PrimaryTexture, sEmblem_PreviewPrimary, iEmblem_PreviewPrimaryColor);
				PrimaryTexture.visible = true; // debugging for tint color

				sEmblem_PreviewSecondary = mcm.GetModSettingString("ODST", "sEmblem_PreviewSecondary:Settings");
				iEmblem_PreviewSecondaryColor = mcm.GetModSettingInt("ODST", "iEmblem_PreviewSecondaryColor:Settings");
				SetEmblem(SecondaryTexture, sEmblem_PreviewSecondary, iEmblem_PreviewSecondaryColor);
				SecondaryTexture.visible = true; // debugging for tint color

				sEmblem_PreviewBackground = mcm.GetModSettingString("ODST", "sEmblem_PreviewBackground:Settings");
				iEmblem_PreviewBackgroundColor = mcm.GetModSettingInt("ODST", "iEmblem_PreviewBackgroundColor:Settings");
				SetEmblem(BackgroundTexture, sEmblem_PreviewBackground, iEmblem_PreviewBackgroundColor);
				BackgroundTexture.visible = true; // debugging for tint color

				Debug.WriteLine("[MCM]", "[Preview]", "(Populate)", "Done populating the emblem data.");
			}
			else
			{
				Debug.WriteLine("[MCM]", "[Preview]", "(Populate)", "ERROR: The mcm object is null.");
			}
		}


		private function SetEmblem(textureLoader:TextureLoader, filepath:String, color:int):void
		{
			Debug.WriteLine("[MCM]", "[Preview]", "(SetEmblem)", filepath, String(color));
			textureLoader.Load(filepath);
			var tint = new ColorTransform();
			tint.color = color;
			textureLoader.transform.colorTransform = tint;
		}


	}
}
