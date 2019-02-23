package Emblem
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Shared.AS3.BSScrollingList;
	import Shared.AS3.BSScrollingListEntry;
	import Shared.AS3.Debug;

	public dynamic class Editor extends MovieClip
	{
		private var Entries:Array;
		public var List_mc:MenuList;

		public static const EDITOR_OPENED:String = "EditorOpened";
		public static const EDITOR_CLOSED:String = "EditorClosed";
		public static const EDITOR_SAVED:String = "EditorSaved";


		// Editor
		//---------------------------------------------

		public function Editor()
		{
			Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(ctor)");
			Entries = new Array();
			addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			InventoryList_Properties();
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(OnAddedToStage)");
			visible = false;
		}


		// Scrolling List
		//---------------------------------------------

		private function InventoryList_Properties():void
		{
			try
			{
				List_mc["componentInspectorSetting"] = true;
				List_mc.listEntryClass = "MenuListEntry";
				List_mc.numListItems = 6;
				List_mc.restoreListIndex = false;
				List_mc.textOption = BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT;
				List_mc.verticalSpacing = 0;
				List_mc["componentInspectorSetting"] = false;
			}
			catch(error:Error)
			{
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Properties)", "ID:#"+error.errorID, "Name:"+error.name, "Message:"+error.message);
			}

			List_mc.addEventListener(BSScrollingList.LIST_ITEMS_CREATED, this.OnInventoryListItemsCreated);
			List_mc.addEventListener(BSScrollingList.SELECTION_CHANGE, this.OnInventorySelectionChange);
			// List_mc.filterer.addEventListener(ListFilterer.FILTER_CHANGE, this.OnFilterChange);
		}


		private function InventoryList_Populate():void
		{
			List_mc.visible = true;
			Entries = new Array();

			var entry1_data:Object = {name:"name 1", text:"text 1", componentCountA:[11, 21, 31], usedCount:5, invCount:15};
			var entry2_data:Object = {name:"name 2", text:"text 2", componentCountA:[12, 22, 32], usedCount:5, invCount:15};
			var entry3_data:Object = {name:"name 3", text:"text 3", componentCountA:[13, 23, 33], usedCount:5, invCount:15};

			// try
			// {
				var entry1:MenuListEntry = new MenuListEntry();
				entry1.textField.text = "hello world 1";
				entry1.visible = true;
				// entry1.SetEntryText(entry1_data, BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT);
				Entries.push(entry1);
				List_mc.CategoryNameList.push(entry1.name);

				var entry2:MenuListEntry = new MenuListEntry();
				entry2.textField.text = "hello world 2";
				entry2.visible = true;
				// entry2.SetEntryText(entry2_data, BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT);
				Entries.push(entry2);
				List_mc.CategoryNameList.push(entry2.name);

				var entry3:MenuListEntry = new MenuListEntry();
				entry3.textField.text = "hello world 3";
				entry3.visible = true;
				// entry3.SetEntryText(entry3_data, BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT);
				Entries.push(entry3);
				List_mc.CategoryNameList.push(entry3.name);

				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate::ENTRIES)", "Initialized the list entries.");
			// }
			// catch(error:Error)
			// {
			// 	Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate::ENTRIES)", "ID:#"+error.errorID, "Name:"+error.name, "Message:"+error.message);
			// }


			try
			{
				List_mc.FilterCount = Entries.length;

				List_mc.onComponentInit(new Event(""));
				List_mc["bInitialized"] = true;
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate::LIST)", "1");

				List_mc.numListItems = Entries.length;
				List_mc.InitList(Entries.length, 1);
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate::LIST)", "2");


				List_mc.entryList = Entries;
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate::LIST)", "List_mc.entryList ...");
				Debug.TraceObject(List_mc.entryList);

				// List_mc.selectedIndex = 0; // causes error #1010
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate::LIST)", "Initialized the scrolling list with "+List_mc.numListItems+" entries.");
			}
			catch(error:Error)
			{
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate::LIST)", "ID:#"+error.errorID, "Name:"+error.name, "Message:"+error.message);
			}

			// --------------------------------------------------------------
			// List_mc.SetNumListItems(n); // PROTECTED !

			try
			{
				List_mc.RefreshList();
				List_mc.GrabFocus();

				// List_mc.InvalidateData();
				// List_mc.UpdateList();
				// List_mc.moveSelectionDown();
				// List_mc.UpdateSelectedEntry();
			}
			catch(error:Error)
			{
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate::INIT)", "ID:#"+error.errorID, "Name:"+error.name, "Message:"+error.message);
			}



			if(List_mc.selectedIndex > -1)
			{
				var entryText:String = List_mc.entryList[List_mc.selectedIndex].textField.text;
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate)", "Entry:"+entryText);
			}
			else
			{
				Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(InventoryList_Populate)", "No selected index.");
			}
		}


		private function onFilterChange():*
		{

		}


		private function OnInventoryListItemsCreated(e:Event):*
		{
			Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(OnInventoryListItemsCreated)");
		}


		private function OnInventorySelectionChange(e:Event):*
		{
			var entryText:String = List_mc.entryList[List_mc.selectedIndex].textField.text;
			Debug.WriteLine("[ODST]", "[Emblem]", "[Editor]", "(OnInventorySelectionChange)", "Text:"+entryText, "selectedIndex:"+List_mc.selectedIndex);
		}


		// Methods
		//---------------------------------------------

		public function Open():void
		{
			visible = true;
			InventoryList_Populate();
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


	}
}
