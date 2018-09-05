package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.utils.*;
	import AS3.*;
	import MCM.*;

	public class Preview extends MovieClip implements IMCMLibrary
	{
		private var mcm:*;

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
			// var timer:Timer = new Timer(3000); // rip
			// timer.addEventListener(TimerEvent.TIMER, OnTimer);
			// timer.start();
		}


		// private function OnTimer(e:TimerEvent):void
		// {
		// 	Debug.WriteLine("[MCM]", "[Preview]", "OnTimer", e);
		// 	GetModSettings();
		// }


		public function onLibLoaded(mcmCodeObject:*, f4seCodeObject:*):void
		{
			Debug.WriteLine("[MCM]", "[Preview]", "(onLibLoaded)", "MCM scaleform callback has been received.");
			mcm = mcmCodeObject;

			try
			{
				PrimaryTexture.onF4SEObjCreated(f4seCodeObject);
				PrimaryTexture.ImageMountID = PrimaryMountID;
				// PrimaryTexture.Load("ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Primary\\Spartan1.dds");

				SecondaryTexture.onF4SEObjCreated(f4seCodeObject);
				SecondaryTexture.ImageMountID = SecondaryMountID;
				// SecondaryTexture.Load("ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Secondary\\Spartan2.dds");

				BackgroundTexture.onF4SEObjCreated(f4seCodeObject);
				BackgroundTexture.ImageMountID = BackgroundMountID;
				// BackgroundTexture.Load("ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Background\\Shield.dds");

			}
			catch (error:Error)
			{
				Debug.WriteLine("[MCM]", "[Preview]", "(onLibLoaded)", "ERROR:", error.toString());
			}

			GetModSettings(mcmCodeObject);
		}


		private function GetModSettings(mcmCodeObject:*):void
		{
			if(mcm != null)
			{
				try
				{
					sEmblem_PreviewPrimary = mcm.GetModSettingString("ODST", "sEmblem_PreviewPrimary:Settings");
					sEmblem_PreviewSecondary = mcm.GetModSettingString("ODST", "sEmblem_PreviewSecondary:Settings");
					sEmblem_PreviewBackground = mcm.GetModSettingString("ODST", "sEmblem_PreviewBackground:Settings");
					iEmblem_PreviewPrimaryColor = mcm.GetModSettingInt("ODST", "iEmblem_PreviewPrimaryColor:Settings");
					iEmblem_PreviewSecondaryColor = mcm.GetModSettingInt("ODST", "iEmblem_PreviewSecondaryColor:Settings");
					iEmblem_PreviewBackgroundColor = mcm.GetModSettingInt("ODST", "iEmblem_PreviewBackgroundColor:Settings");
					Debug.WriteLine("[MCM]", "[Preview]", "(GetModSettings) Path", sEmblem_PreviewPrimary, sEmblem_PreviewSecondary, sEmblem_PreviewBackground);
					Debug.WriteLine("[MCM]", "[Preview]", "(GetModSettings) Color", String(iEmblem_PreviewPrimaryColor), String(iEmblem_PreviewSecondaryColor), String(iEmblem_PreviewBackgroundColor));
				}
				catch (error:Error)
				{
					Debug.WriteLine("[MCM]", "[Preview]", "(GetModSettings::GetModSetting)", "ERROR:", error.toString());
				}
				try
				{
					PrimaryTexture.Load(sEmblem_PreviewPrimary);
					PrimaryTexture.Load(sEmblem_PreviewSecondary);
					PrimaryTexture.Load(sEmblem_PreviewBackground);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[MCM]", "[Preview]", "(GetModSettings::Load)", "ERROR:", error.toString());
				}
			}
			else
			{
				Debug.WriteLine("[MCM]", "[Preview]", "(GetModSettings)", "ERROR: The mcm object is null.");
			}
		}


	}
}
