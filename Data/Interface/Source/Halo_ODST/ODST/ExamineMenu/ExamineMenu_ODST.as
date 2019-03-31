package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import Shared.AS3.BSButtonHintData;
	import Shared.AS3.BSScrollingList;
	import Shared.AS3.Debug;
	import Shared.AS3.Utility;
	import Shared.Display;
	import Emblem.*;

	// TODO: Send editor changes to papyrus via event if necessary.

	/**
	 *	Adds features to the examine menu at runtime.
	 */
	public class ExamineMenu_ODST extends Display
	{
		public function get ExamineMenu():MovieClip { return MenuRoot.BaseInstance; }
		private function get SupressUserEventInput():Boolean { return ExamineMenu["bEnteringText"]; }
		private function set SupressUserEventInput(value:Boolean):void { ExamineMenu["bEnteringText"] = value; }

		private var timer:Timer;
		private const PerkID:uint = 167803429; // ODST_Emblems_CustomPerk "Preview" [PERK:00007A25]

		private const ModChangedEvent:String = "ODST_Examine_OnModChanged";
		private const EditorOpenedEvent:String = "ODST_Examine_OnEditorOpened";

		private var EditButton:BSButtonHintData;
		private var SaveButton:BSButtonHintData;
		private var CloseButton:BSButtonHintData;

		public var Viewer:Emblem.Viewer;
		public var Editor:Emblem.Editor;

		private const DEFAULT_MODE:int = 0;
		private const SELECTED_MODE:int = 1;
		private const EDITOR_MODE:int = 2;


		// Menu
		//---------------------------------------------

		public function ExamineMenu_ODST()
		{
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(ctor)", "Constructor Code");
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
		}


		public override function OnAddedToStage(e:Event):void
		{
			super.OnAddedToStage(e);
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnAddedToStage)", Utility.GetInstance(this));

			timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER, this.OnSelectionTimer);

			ExamineMenu.ModListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnModChanged);

			EditButton = new BSButtonHintData("$Edit", "R", "PSN_X", "Xenon_X", 1, this.OnEditorOpenButton);
			EditButton.ButtonVisible = false;
			ExamineMenu.ModsListHints.push(EditButton);

			SaveButton = new BSButtonHintData("$Save", "E", "PSN_A", "Xenon_A", 1, this.OnEditorSaveButton);
			SaveButton.ButtonVisible = false;
			ExamineMenu.ModsListHints.push(SaveButton);

			CloseButton = new BSButtonHintData("$Close", "Tab", "PSN_B", "Xenon_B", 1, this.OnEditorCloseButton);
			CloseButton.ButtonVisible = false;
			ExamineMenu.ModsListHints.push(CloseButton);

			Viewer.onF4SEObjCreated(MenuRoot.f4se);
			Editor.addEventListener(Emblem.Editor.EDITOR_OPENED, this.OnEditorOpened);
			Editor.addEventListener(Emblem.Editor.EDITOR_SAVED, this.OnEditorSaved);
			Editor.addEventListener(Emblem.Editor.EDITOR_CLOSED, this.OnEditorClosed);
		}


		// Examine Menu
		//---------------------------------------------

		// Occurs when an OMOD is hovered in the examine menu.
		public function OnModChanged(e:Event):*
		{
			timer.reset();
			SetMode(SELECTED_MODE, false);

			var index:int = ExamineMenu.ModListObject.selectedIndex;
			if(index > -1 && ExamineMenu.ModListObject.entryList)
			{
				var selected = ExamineMenu.ModListObject.entryList[index];
				if(selected != null)
				{
					if(selected.perkData != null)
					{
						if(selected.perkData.length > 0)
						{
							if (selected.perkData[0].perkID == PerkID)
							{
								Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnModChanged)", "e:"+String(e), "index:"+String(index), "Name:"+selected.text);
								// ExamineMenu.ModSlotListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnModSlotChanged);
								timer.start();
								return
							}
							else
							{
								Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnModChanged)", "No emblem is selected.");
							}
						}
						else
						{
							Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnModChanged)", "selected.perkData", "The value is empty.");
						}
					}
					else
					{
						Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnModChanged)", "selected.perkData", "The value is null.");
					}
				}
				else
				{
					Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnModChanged)", "selected", "The value is null.");
				}
			}

			MenuRoot.f4se.SendExternalEvent(ModChangedEvent, -1);
		}


		// public function OnModSlotChanged(e:Event):*
		// {
		// 	ExamineMenu.ModSlotListObject.removeEventListener(BSScrollingList.SELECTION_CHANGE, this.OnModSlotChanged);
		// 	var index:int = ExamineMenu.ModSlotListObject.selectedIndex;
		// 	if(index > -1 && ExamineMenu.ModSlotListObject.entryList)
		// 	{
		// 		Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnModSlotChanged)");
		// 		MenuRoot.f4se.SendExternalEvent(ModChangedEvent, -1);
		// 	}
		// }


		private function OnSelectionTimer(e:TimerEvent):void
		{
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnSelectionTimer)", e);
			timer.reset();
			SetMode(SELECTED_MODE);
		}


		// Editor
		//---------------------------------------------

		public function OnEditorKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.R)
			{
				Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnEditorKeyDown)", "{R}", "e:"+e.toString());
				OnEditorOpenButton();
			}
			if(e.keyCode == Keyboard.TAB)
			{
				Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnEditorKeyDown)", "{TAB}", "e:"+e.toString());
				OnEditorCloseButton();
			}
			if(e.keyCode == Keyboard.E || e.keyCode == Keyboard.ENTER)
			{
				Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnEditorKeyDown)", "{E|ENTER}", "e:"+e.toString());
				OnEditorSaveButton();
			}
		}


		private function OnEditorOpenButton():void
		{
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnEditorOpenButton)");
			Editor.Open();
		}

		private function OnEditorOpened():void
		{
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnEditorOpened)");
			ExamineMenu.BGSCodeObj.PlaySound("UIMenuOK");
			SetMode(EDITOR_MODE);
			MenuRoot.f4se.SendExternalEvent(EditorOpenedEvent);
		}


		private function OnEditorCloseButton():void
		{
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnEditorCloseButton)");
			Editor.Close();
		}

		private function OnEditorClosed():void
		{
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnEditorClosed)");
			ExamineMenu.BGSCodeObj.PlaySound("UIMenuCancel");
			SetMode(SELECTED_MODE, false);
			SetMode(EDITOR_MODE, false);
		}


		private function OnEditorSaveButton():void
		{
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnEditorSaveButton)");
			Editor.Save();
		}

		private function OnEditorSaved():void
		{
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(OnEditorSaved)");
			ExamineMenu.BGSCodeObj.PlaySound("UIMenuOK");
			SetMode(SELECTED_MODE, false);
			SetMode(EDITOR_MODE, false);
		}


		// Modes
		//---------------------------------------------

		private function SetMode(mode:int, enable:Boolean = true):Boolean
		{
			Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(SetMode)", "mode:"+mode, "enable:"+enable);

			if(mode == DEFAULT_MODE)
			{
				return true;
			}
			else if(mode == SELECTED_MODE)
			{
				if(enable)
				{
					EditButton.ButtonVisible = true;
					stage.addEventListener(KeyboardEvent.KEY_DOWN, this.OnEditorKeyDown);
					Viewer.visible = true;
					ExamineMenu.PerkPanel0_mc.Requires_tf.text = "Emblem";
					var index:int = ExamineMenu.ModListObject.selectedIndex;
					MenuRoot.f4se.SendExternalEvent(ModChangedEvent, index);
				}
				else
				{
					EditButton.ButtonVisible = false;
					stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.OnEditorKeyDown);
					Viewer.visible = false;
				}
				return true;
			}
			else if(mode == EDITOR_MODE)
			{
				if(enable)
				{
					SupressUserEventInput = true;
					ExamineMenu.removeEventListener(KeyboardEvent.KEY_UP, ExamineMenu.onKeyUp);
					ExamineMenu.removeEventListener(MouseEvent.MOUSE_WHEEL, ExamineMenu.onMouseWheel);
					ExamineMenu.removeEventListener(BSScrollingList.ITEM_PRESS, ExamineMenu.onItemPressed);
				}
				else
				{
					SupressUserEventInput = false;
					ExamineMenu.addEventListener(KeyboardEvent.KEY_UP, ExamineMenu.onKeyUp);
					ExamineMenu.addEventListener(MouseEvent.MOUSE_WHEEL, ExamineMenu.onMouseWheel);
					ExamineMenu.addEventListener(BSScrollingList.ITEM_PRESS, ExamineMenu.onItemPressed);
				}

				if(enable)
				{
					ExamineMenu.ItemCardList_mc.visible = false;
					//-------------------------
					this.SaveButton.ButtonVisible = true; // turn on
					this.CloseButton.ButtonVisible = true; // turn on
					this.EditButton.ButtonVisible = false;
					//-------------------------
					ExamineMenu.Build.ButtonVisible = false;
					ExamineMenu.Build.ButtonDisabled = true;
					//-------------------------
					ExamineMenu.TagButton.ButtonVisible = false;
					ExamineMenu.BackButton.ButtonVisible = false;
					//-------------------------
					ExamineMenu.SetModsLabel("ODST Emblem Editor");
					ExamineMenu.AdjustBracket(ExamineMenu.ModBracketBase_mc);
					ExamineMenu.ModDescriptionBase_mc.visible = false;
					ExamineMenu.CurrentModsBase_mc.ModSlotList_mc.disableInput = true;
					//-------------------------
					ExamineMenu.ModSlotBracketBase_mc.visible = false;
					ExamineMenu.ModSlotBase_mc.visible = false;
					ExamineMenu.ModSlotBase_mc.ModSlotList_mc.disableInput = true;
					//-------------------------
					ExamineMenu.InventoryBracketBase_mc.visible = false;
					ExamineMenu.InventoryBase_mc.InventoryList_mc.visible = false;
					ExamineMenu.InventoryBase_mc.InventoryList_mc.disableInput = true;
				}
				else
				{
					ExamineMenu.ItemCardList_mc.visible = true;
					//-------------------------
					this.SaveButton.ButtonVisible = false;
					this.CloseButton.ButtonVisible = false;
					this.EditButton.ButtonVisible = true;
					//-------------------------
					ExamineMenu.Build.ButtonVisible = true;
					ExamineMenu.TagButton.ButtonVisible = true;
					ExamineMenu.BackButton.ButtonVisible = true;
					//-------------------------
					ExamineMenu.SetModsLabel("MODS");
					ExamineMenu.AdjustBracket(ExamineMenu.ModBracketBase_mc);
					ExamineMenu.ModDescriptionBase_mc.visible = true;
					ExamineMenu.CurrentModsBase_mc.ModSlotList_mc.disableInput = false;
					//-------------------------
					ExamineMenu.ModSlotBracketBase_mc.visible = true;
					ExamineMenu.ModSlotBase_mc.visible = true;
					ExamineMenu.ModSlotBase_mc.ModSlotList_mc.disableInput = false;
					//-------------------------
					ExamineMenu.InventoryBracketBase_mc.visible = true;
					ExamineMenu.InventoryBase_mc.InventoryList_mc.visible = true;
					ExamineMenu.InventoryBase_mc.InventoryList_mc.disableInput = false;
				}
				return true;
			}
			else
			{
				Debug.WriteLine("[ODST]", "[ExamineMenu_ODST]", "(SetMode)", "The mode value of "+mode+" is unhandled.");
				return false;
			}
		}


	}
}
