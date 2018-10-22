package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Shared.AS3.BSButtonHintData;
	import Shared.AS3.BSScrollingList;
	import AS3.*;

	public class RemoteMenu extends MovieClip
	{
		// TODO: How can I identify that an ODST omod is focused in the menu?

		private var MenuRoot:MovieClip;
		public function get ExamineMenu():MovieClip { return MenuRoot.BaseInstance; }

		//---------------------------------------------

		private var EditButton:BSButtonHintData;

		private const ModChangedEvent:String = "ODST_Examine_OnModChanged";
		private const EditButtonEvent:String = "ODST_Examine_OnEditButton";

		// Menu
		//---------------------------------------------

		public function RemoteMenu()
		{
			Debug.WriteLine("RemoteMenu", "ctor", "Constructor Code");
			Debug.TraceObject(this);
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
		}


		private function OnAddedToStage(e:Event) : void
		{
			Debug.WriteLine("RemoteMenu", "OnAddedToStage:"+Utility.WalkMovie(this));
			MenuRoot = stage.getChildAt(0) as MovieClip;

			ExamineMenu.InventoryListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnInventorySelectionChange);
			ExamineMenu.ModSlotListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnModSlotSelectionChange);
			ExamineMenu.ModListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnModChanged);

			EditButton = new BSButtonHintData("$Edit", "R", "PSN_X", "Xenon_X", 1, this.OnEditButton);
			EditButton.ButtonVisible = true;
			ExamineMenu.ModsListHints.push(EditButton);
			ExamineMenu.ButtonHintBar_mc.SetButtonHintData(ExamineMenu.ModsListHints);

			Debug.TraceObject(ExamineMenu.BGSCodeObj);
		}


		// Buttons
		//---------------------------------------------

		// Occurs when an the edit button is pressed.
		private function OnEditButton() : void
		{
			Debug.WriteLine("RemoteMenu", "OnEditButton");
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
				Debug.WriteLine("RemoteMenu", "OnInventorySelectionChange", "e:"+String(e), "index:"+String(index), "Name:"+selected.text);
				Debug.TraceObject(selected);
			}
		}


		// Occurs when a mod slot is hovered in the examine menu.
		public function OnModSlotSelectionChange(e:Event) : *
		{
			var index:uint = ExamineMenu.ModSlotListObject.selectedIndex;
			if(index > -1 && ExamineMenu.ModSlotListObject.entryList)
			{
				var selected = ExamineMenu.ModSlotListObject.entryList[index];
				Debug.WriteLine("RemoteMenu", "OnModSlotSelectionChange", "e:"+String(e), "index:"+String(index), "Name:"+selected.text);
				Debug.TraceObject(selected);
			}

			EditButton.ButtonVisible = false; // TODO: When should I show or hide the button?
		}


		// Occurs when an OMOD is hovered in the examine menu.
		public function OnModChanged(e:Event) : *
		{
			var index:uint = ExamineMenu.ModListObject.selectedIndex;
			if(index > -1 && ExamineMenu.ModListObject.entryList)
			{
				var selected = ExamineMenu.ModListObject.entryList[index];
				Debug.WriteLine("RemoteMenu", "OnModChanged", "e:"+String(e), "index:"+String(index), "Name:"+selected.text);
				Debug.TraceObject(selected);

				MenuRoot.f4se.SendExternalEvent(ModChangedEvent, index);
			}
		}


	}
}
