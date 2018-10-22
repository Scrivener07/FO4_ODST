package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import scaleform.gfx.TextFieldEx;
	import Shared.AS3.BSButtonHintData;
	import Shared.AS3.BSScrollingList;
	import AS3.*;

	import flash.events.TimerEvent;
	import flash.utils.*;


	public class ODST extends MovieClip
	{
		// TODO: How can I identify that an ODST omod is focused in the menu?

		private var MenuRoot:MovieClip;
		public function get ExamineMenu():MovieClip { return MenuRoot.BaseInstance; }

		//---------------------------------------------

		private var EditButton:BSButtonHintData;

		private var timer:Timer;

		private const PerkID:uint = 167803429;
		private const ModChangedEvent:String = "ODST_Examine_OnModChanged";
		private const EditButtonEvent:String = "ODST_Examine_OnEditButton";

		// Menu
		//---------------------------------------------

		public function ODST()
		{
			Debug.WriteLine("[ODST]", "ctor", "Constructor Code");
			Debug.TraceObject(this);
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
		}


		private function OnAddedToStage(e:Event) : void
		{
			Debug.WriteLine("[ODST]", "OnAddedToStage:"+Utility.WalkMovie(this));
			MenuRoot = stage.getChildAt(0) as MovieClip;

			ExamineMenu.InventoryListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnInventorySelectionChange);
			ExamineMenu.ModSlotListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnModSlotSelectionChange);
			ExamineMenu.ModListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnModChanged);

			EditButton = new BSButtonHintData("$Edit", "R", "PSN_X", "Xenon_X", 1, this.OnEditButton);
			EditButton.ButtonVisible = false;
			ExamineMenu.ModsListHints.push(EditButton);
			ExamineMenu.ButtonHintBar_mc.SetButtonHintData(ExamineMenu.ModsListHints);

			timer = new Timer(100, 4);
			timer.addEventListener(TimerEvent.TIMER, OnTimer);

			// Debug.TraceObject(MenuRoot.f4se);
			// Debug.TraceObject(ExamineMenu.BGSCodeObj);
		}


		// Buttons
		//---------------------------------------------

		// Occurs when an the edit button is pressed.
		private function OnEditButton() : void
		{
			Debug.WriteLine("[ODST]", "OnEditButton");
			MenuRoot.f4se.SendExternalEvent(EditButtonEvent);
		}


		// Examine Menu
		//---------------------------------------------

		// Occurs when an inventory item is hovered in the examine menu.
		public function OnInventorySelectionChange(e:Event) : *
		{
			var index:uint = ExamineMenu.InventoryListObject.selectedIndex;
			if(index > -1 && ExamineMenu.InventoryListObject.entryList)
			{
				var selected = ExamineMenu.InventoryListObject.entryList[index];
				Debug.WriteLine("[ODST]", "OnInventorySelectionChange", "e:"+String(e), "index:"+String(index), "Name:"+selected.text);
				// Debug.TraceObject(selected);
			}
		}


		// Occurs when a mod slot is hovered in the examine menu.
		public function OnModSlotSelectionChange(e:Event) : *
		{
			var index:uint = ExamineMenu.ModSlotListObject.selectedIndex;
			if(index > -1 && ExamineMenu.ModSlotListObject.entryList)
			{
				var selected = ExamineMenu.ModSlotListObject.entryList[index];
				Debug.WriteLine("[ODST]", "OnModSlotSelectionChange", "e:"+String(e), "index:"+String(index), "Name:"+selected.text);
				// Debug.TraceObject(selected);
			}

		}


		// Occurs when an OMOD is hovered in the examine menu.
		public function OnModChanged(e:Event) : *
		{
			var index:uint = ExamineMenu.ModListObject.selectedIndex;
			if(index > -1 && ExamineMenu.ModListObject.entryList)
			{
				var selected = ExamineMenu.ModListObject.entryList[index];
				if (selected.perkData[0].perkID == PerkID)
				{
					Debug.WriteLine("[ODST]", "OnModChanged", "e:"+String(e), "index:"+String(index), "Name:"+selected.text);
					Debug.TraceObject(selected);

					MenuRoot.f4se.SendExternalEvent(ModChangedEvent, index);
					EditButton.ButtonVisible = true;

					timer.start();
				}
				else
				{
					EditButton.ButtonVisible = false;
				}
			}
		}


		private function OnTimer(e:TimerEvent):void
		{
			timer.reset();
			Debug.WriteLine("[ODST]", "OnTimer", e);

			ExamineMenu.PerkPanel0_mc.PerkName_tf.text = "Preview";
			TextFieldEx.setTextAutoSize(ExamineMenu.PerkPanel0_mc.PerkName_tf, "shrink");

			ExamineMenu.PerkPanel0_mc.Requires_tf.text = "";
			TextFieldEx.setTextAutoSize(ExamineMenu.PerkPanel0_mc.Requires_tf, "shrink");
		}


	}
}
