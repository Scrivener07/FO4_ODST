package Emblem
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.AS3.Debug;
	import Shared.PlatformChangeEvent;

	public class Editor extends MovieClip
	{
		// TODO: Set the current platform of the button bar. It is showing Xbox mappings.

		public var ButtonHintBar_mc:BSButtonHintBar;

		private var ButtonHints:Vector.<BSButtonHintData>;
		private var SaveButton:BSButtonHintData;
		private var CloseButton:BSButtonHintData;

		public static const EDITOR_OPENED:String = "EditorOpened";
		public static const EDITOR_CLOSED:String = "EditorClosed";
		public static const EDITOR_SAVED:String = "EditorSaved";


		// Editor
		//---------------------------------------------

		public function Editor()
		{
			Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(ctor)");
			ButtonHints = new Vector.<BSButtonHintData>();
			try
			{
				ButtonHintBar_mc["componentInspectorSetting"] = true;
				ButtonHintBar_mc.BackgroundAlpha = 1;
				ButtonHintBar_mc.BackgroundColor = 0;
				ButtonHintBar_mc.bracketCornerLength = 6;
				ButtonHintBar_mc.bracketLineWidth = 1.5;
				ButtonHintBar_mc.BracketStyle = "horizontal";
				ButtonHintBar_mc.bRedirectToButtonBarMenu = true;
				ButtonHintBar_mc.bShowBrackets = true;
				ButtonHintBar_mc.bUseShadedBackground = true;
				ButtonHintBar_mc.ShadedBackgroundMethod = "Shader";
				ButtonHintBar_mc.ShadedBackgroundType = "normal";
				ButtonHintBar_mc["componentInspectorSetting"] = false;
			}
			catch(error:Error)
			{
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(ButtonHintBar_Settings)", "error:"+error.toString());
			}

			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(OnAddedToStage)");
			visible = false;

			SaveButton = new BSButtonHintData("$Save", "E", "PSN_A", "Xenon_A", 1, this.OnSaveButton);
			SaveButton.ButtonVisible = true;
			ButtonHints.push(SaveButton);

			CloseButton = new BSButtonHintData("$Close", "TAB", "PSN_B", "Xenon_B", 1, this.OnCloseButton);
			CloseButton.ButtonVisible = true;
			ButtonHints.push(CloseButton);

			ButtonHintBar_mc.SetButtonHintData(ButtonHints);
			ButtonHintBar_mc.SetPlatform(PlatformChangeEvent.PLATFORM_PC_KB_MOUSE, false); // not working
			ButtonHintBar_mc.ShadedBackground_mc.visible = true; // ??
		}


		// Methods
		//---------------------------------------------

		public function Open():void
		{
			visible = true;
			this.dispatchEvent(new Event(EDITOR_OPENED));
		}


		public function Close():void
		{
			visible = false;
			this.dispatchEvent(new Event(EDITOR_CLOSED));
		}


		public function Save():void
		{
			visible = false;
			this.dispatchEvent(new Event(EDITOR_SAVED));
		}


		// Buttons
		//---------------------------------------------

		private function OnCloseButton():void
		{
			Close();
		}


		private function OnSaveButton():void
		{
			Save();
		}


	}
}
