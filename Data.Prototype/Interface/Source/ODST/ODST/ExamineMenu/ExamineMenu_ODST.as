package
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.*;
	import scaleform.gfx.TextFieldEx;
	import Shared.AS3.BSButtonHintData;
	import Shared.AS3.BSScrollingList;
	import AS3.*;
	import ODST.*;
	import F4SE.*;

	// Hijacks the ExamineMenu to add ODST features.
	public class ExamineMenu_ODST extends Display
	{
		public function get ExamineMenu():MovieClip { return MenuRoot.BaseInstance; }

		//---------------------------------------------
		private var timer:Timer; // hate it

		private var EditButton:BSButtonHintData;

		private const PerkID:uint = 167803429;

		// private const VisibleEvent:String = "ODST_Examine_OnHide"; // not implemented
		private const ModChangedEvent:String = "ODST_Examine_OnModChanged";
		private const EditButtonEvent:String = "ODST_Examine_OnEditButton";


		// Menu
		//---------------------------------------------

		public function ExamineMenu_ODST()
		{
			Debug.WriteLine("[ExamineMenu_ODST]", "(ctor)", "Constructor Code");
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
		}


		public override function OnAddedToStage(e:Event) : void
		{
			super.OnAddedToStage(e);
			Debug.WriteLine("[ExamineMenu_ODST]", "(OnAddedToStage):"+Utility.WalkMovie(this));

			ExamineMenu.ModListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnModChanged);
			ExamineMenu.ModSlotListObject.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnModSlotChanged);

			EditButton = new BSButtonHintData("$Edit", "R", "PSN_X", "Xenon_X", 1, this.OnEditButton);
			EditButton.ButtonVisible = false;
			ExamineMenu.ModsListHints.push(EditButton);
			ExamineMenu.ButtonHintBar_mc.SetButtonHintData(ExamineMenu.ModsListHints);

			timer = new Timer(100, 1);
			timer.addEventListener(TimerEvent.TIMER, OnTimer);
		}


		// Buttons
		//---------------------------------------------

		// Occurs when an the edit button is pressed.
		private function OnEditButton() : void
		{
			// TODO: The mouse click works but not the key press.
			var version:Version = Extensions.GetVersion(MenuRoot.f4se);
			MenuRoot.f4se.SendExternalEvent(EditButtonEvent);
			Debug.WriteLine("[ExamineMenu_ODST]", "(OnEditButton)", "F4SE: v"+version.toString());
		}


		// Examine Menu
		//---------------------------------------------

		public function OnModSlotChanged(e:Event) : *
		{
			var index:uint = ExamineMenu.ModSlotListObject.selectedIndex;
			if(index > -1 && ExamineMenu.ModSlotListObject.entryList)
			{
				Debug.WriteLine("[ExamineMenu_ODST]", "(OnModSlotChanged)");
				// TODO: This happens too often and when it doesnt need to.
				MenuRoot.f4se.SendExternalEvent(ModChangedEvent, -1);
			}
		}


		// Occurs when an OMOD is hovered in the examine menu.
		public function OnModChanged(e:Event) : *
		{
			var index:uint = ExamineMenu.ModListObject.selectedIndex;
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
								Debug.WriteLine("[ExamineMenu_ODST]", "(OnModChanged)", "e:"+String(e), "index:"+String(index), "Name:"+selected.text);
								EditButton.ButtonVisible = true;
								timer.start();
								MenuRoot.f4se.SendExternalEvent(ModChangedEvent, index);
							}
							else
							{
								Debug.WriteLine("[ExamineMenu_ODST]", "(OnModChanged)", "No emblem is selected.");
								EditButton.ButtonVisible = false;
								MenuRoot.f4se.SendExternalEvent(ModChangedEvent, -1);
							}
						}
						else
						{
							Debug.WriteLine("[ExamineMenu_ODST]", "(OnModChanged)", "selected.perkData", "The value is empty.");
							MenuRoot.f4se.SendExternalEvent(ModChangedEvent, -1);
						}
					}
					else
					{
						Debug.WriteLine("[ExamineMenu_ODST]", "(OnModChanged)", "selected.perkData", "The value is null.");
						MenuRoot.f4se.SendExternalEvent(ModChangedEvent, -1);
					}
				}
				else
				{
					Debug.WriteLine("[ExamineMenu_ODST]", "(OnModChanged)", "selected", "The value is null.");
					MenuRoot.f4se.SendExternalEvent(ModChangedEvent, -1);
				}
			}

		}


		// I hate this timer idea. Its very bad!
		private function OnTimer(e:TimerEvent):void
		{
			// TODO: Something null is being called.`
			timer.reset();
			Debug.WriteLine("[ExamineMenu_ODST]", "(OnTimer)", e);

			ExamineMenu.PerkPanel0_mc.Requires_tf.text = "";
			TextFieldEx.setTextAutoSize(ExamineMenu.PerkPanel0_mc.Requires_tf, "shrink");
		}


	}
}
