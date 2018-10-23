package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.ColorTransform;
	import AS3.*;
	import F4SE.*;
	import ODST.*;

	// TODO: The image mounts dont clean up properly sometimes.

	public class EmblemMenu extends Display
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
			Debug.WriteLine("[EmblemMenu]", "(ctor)", "Constructor Code");

			PrimaryTexture.MenuName = MenuName;
			PrimaryTexture.ImageMountID = PrimaryMountID;

			SecondaryTexture.MenuName = MenuName;
			SecondaryTexture.ImageMountID = SecondaryMountID;

			BackgroundTexture.MenuName = MenuName;
			BackgroundTexture.ImageMountID = BackgroundMountID;

			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.OnRemovedFromStage);
		}


		public override function OnAddedToStage(e:Event) : void
		{
			super.OnAddedToStage(e);
			visible = false;
			Debug.WriteLine("[EmblemMenu]", "(OnAddedToStage)");
		}


		private function OnRemovedFromStage(e:Event) : void
		{
			Debug.WriteLine("[EmblemMenu]", "(OnRemovedFromStage)");
		}


		// Papyrus
		//---------------------------------------------

		public function SetPrimary(filepath:String, color:int)
		{
			Debug.WriteLine("[EmblemMenu]", "SetPrimary", "filepath:"+filepath, "color:"+color);
			// visible = true;

			PrimaryTexture.Load(filepath);
			var tint = new ColorTransform();
			tint.color = color;
			PrimaryTexture.transform.colorTransform = tint;
		}


		public function SetSecondary(filepath:String, color:int)
		{
			Debug.WriteLine("[EmblemMenu]", "SetSecondary", "filepath:"+filepath, "color:"+color);
			// visible = true;

			SecondaryTexture.Load(filepath);
			var tint = new ColorTransform();
			tint.color = color;
			SecondaryTexture.transform.colorTransform = tint;
		}


		public function SetBackground(filepath:String, color:int)
		{
			Debug.WriteLine("[EmblemMenu]", "SetBackground", "filepath:"+filepath, "color:"+color);
			// visible = true;

			BackgroundTexture.Load(filepath);
			var tint = new ColorTransform();
			tint.color = color;
			BackgroundTexture.transform.colorTransform = tint;
		}


	}
}
