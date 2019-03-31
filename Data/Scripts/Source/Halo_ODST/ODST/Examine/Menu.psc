Scriptname ODST:Examine:Menu extends ODST:Examine:MenuType
{Injects AS3 code into the vanilla Examine menu.}
import ODST
import ODST:Emblems
import ODST:Log
import ODST:Papyrus

; TODO: The instance paths are screwed up from the refactor. Fix `GetMember`.

Actor Player

bool Loaded = false
string AssetValue = "" ; the loader's instance variable

string ModChangedEvent = "ODST_Examine_OnModChanged" const
string EditorOpenedEvent = "ODST_Examine_OnEditorOpened" const


; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	OnGameReload()
	RegisterForGameReload(self)
	WriteLine(ToString(), "OnQuestInit")
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
	WriteLine(ToString(), "OnQuestShutdown")
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(Name)
	If (!Player.HasPerk(ODST_Emblems_CustomPerk))
		Player.AddPerk(ODST_Emblems_CustomPerk)
	EndIf
	WriteLine(ToString(), "OnGameReload")
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine(ToString(), "OnMenuOpenCloseEvent(menuName:"+menuName+", opening:"+opening+")")
	If (opening)
		UI.Load(Name, Root, File, self, "OnLoadComplete")
		RegisterForExternalEvent(ModChangedEvent, "OnModChanged")
		RegisterForExternalEvent(EditorOpenedEvent, "OnEditorOpened")
	Else
		UnregisterForExternalEvent(ModChangedEvent)
		UnregisterForExternalEvent(EditorOpenedEvent)
		Loaded = false
	EndIf
EndEvent


; @F4SE
Event OnLoadComplete(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}
	WriteLine(ToString(), "OnLoadComplete", "(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")")
	If (!success)
		WriteUnexpectedValue(ToString(), "OnLoadComplete", "success", "The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.")
	EndIf
	AssetValue = assetInstance
	Loaded = success
EndEvent


; @Scaleform
Event OnModChanged(int selected)
	WriteLine(ToString(), "OnModChanged", "argument:"+selected)
	If (selected > Invalid)
		Emblems:Preset preset = Editor.GetPreset(selected)
		Update(Editor, preset)
	EndIf
EndEvent


; @Scaleform
Event OnEditorOpened()
	WriteLine(ToString(), "OnEditorOpened")
EndEvent


; Editor
;---------------------------------------------

bool Function Update(Emblems:Editor sender, Emblems:Preset preset)
	{Updates the preview user interface.}
	If (preset)
		string sLayerPrimary = sender.Symbol.ForegroundToFolder(preset.Foreground)
		string sTexturePathPrimary = sender.ToTexturePath(sender.PrimaryLayer, sLayerPrimary)
		int iColorPrimary = sender.Color.OptionToHex(preset.ForegroundColorPrimary)
		SetPrimary(sTexturePathPrimary, iColorPrimary)

		string sTexturePathSecondary = sender.ToTexturePath(sender.SecondaryLayer, sLayerPrimary)
		int iColorSecondary = sender.Color.OptionToHex(preset.ForegroundColorSecondary)
		SetSecondary(sTexturePathSecondary, iColorSecondary)

		string sLayerBackground = sender.Symbol.BackgroundToFolder(preset.Background)
		string sTexturePathBackground = sender.ToTexturePath(sender.BackgroundLayer, sLayerBackground)
		int iColorBackground = sender.Color.OptionToHex(preset.BackgroundColor)
		SetBackground(sTexturePathBackground, iColorBackground)

		; These settings allow me to pass data to MCM library objects.
		MCM.SetModSettingString(sender.Properties.PluginName, "sEmblem_PreviewPrimary:Settings", sTexturePathPrimary)
		MCM.SetModSettingInt(sender.Properties.PluginName, "iEmblem_PreviewPrimaryColor:Settings", iColorPrimary)

		MCM.SetModSettingString(sender.Properties.PluginName, "sEmblem_PreviewSecondary:Settings", sTexturePathSecondary)
		MCM.SetModSettingInt(sender.Properties.PluginName, "iEmblem_PreviewSecondaryColor:Settings", iColorSecondary)

		MCM.SetModSettingString(sender.Properties.PluginName, "sEmblem_PreviewBackground:Settings", sTexturePathBackground)
		MCM.SetModSettingInt(sender.Properties.PluginName, "iEmblem_PreviewBackgroundColor:Settings", iColorBackground)

		WriteLine(ToString(), "Updated the preset.")
	Else
		WriteUnexpectedValue(ToString(), "Update", "preset", "The value cannot be none.")
	EndIf
EndFunction


; Methods
;---------------------------------------------

bool Function Open()
	If (IsRegistered)
		return UI.OpenMenu(Name)
	Else
		WriteUnexpected(ToString(), "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function Close()
	If (IsRegistered)
		return UI.CloseMenu(Name)
	Else
		WriteUnexpected(ToString(), "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction

;---------------------------------------------

bool Function GetVisible()
	If (IsOpen)
		return UI.Get(Name, Asset+".Visible") as bool
	Else
		WriteUnexpected(ToString(), "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (IsOpen)
		return UI.Set(Name, Asset+".Visible", value)
	Else
		WriteUnexpected(ToString(), "SetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetPrimary(string filepath, int color)
	If (IsOpen)
		If (IsLoaded)
			If (filepath)
				var[] arguments = new var[2]
				arguments[0] = filepath
				arguments[1] = color
				UI.Invoke(Name, Asset+".Viewer.SetPrimary", arguments)
				WriteLine(ToString(), "SetPrimary", arguments)
				return true
			Else
				WriteUnexpectedValue(ToString(), "SetPrimary", "filepath", "The filepath cannot be none or empty.")
				return false
			EndIf
		Else
			WriteUnexpectedValue(ToString(), "SetPrimary", "IsLoaded", "The menu asset must be loaded.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(ToString(), "SetPrimary", "IsOpen", "The menu must be open.")
		return false
	EndIf
EndFunction


bool Function SetSecondary(string filepath, int color)
	If (IsOpen)
		If (filepath)
			var[] arguments = new var[2]
			arguments[0] = filepath
			arguments[1] = color
			UI.Invoke(Name, Asset+".Viewer.SetSecondary", arguments)
			WriteLine(ToString(), "SetSecondary", arguments)
			return true
		Else
			WriteUnexpectedValue(ToString(), "SetSecondary", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(ToString(), "SetSecondary", ToString()+" is not open.")
		return false
	EndIf
EndFunction


bool Function SetBackground(string filepath, int color)
	If (IsOpen)
		If (filepath)
			var[] arguments = new var[2]
			arguments[0] = filepath
			arguments[1] = color
			UI.Invoke(Name, Asset+".Viewer.SetBackground", arguments)
			WriteLine(ToString(), "SetBackground", arguments)
			return true
		Else
			WriteUnexpectedValue(ToString(), "SetBackground", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(ToString(), "SetBackground", ToString()+" is not open.")
		return false
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function GetMember(string member)
	If (member)
		return Instance+"."+member
	Else
		WriteUnexpectedValue(ToString(), "GetMember", "member", "The value cannot be none or empty.")
		return none
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+"[Name:"+Name+", File:"+File+", Root:"+Root+", Asset:"+Asset+"]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Perk Property ODST_Emblems_CustomPerk Auto Const Mandatory
EndGroup

Group Scripts
	ODST:Emblems:Editor Property Editor Auto Const Mandatory
EndGroup

Group Display
	string Property Name Hidden
		{The name of the menu to load within.}
		string Function Get()
			return "ExamineMenu"
		EndFunction
	EndProperty

	string Property Root Hidden
		{The root display object.}
		string Function Get()
			return "root1"
		EndFunction
	EndProperty

	string Property Instance Hidden
		{The menu's base instance variable.}
		string Function Get()
			return Root+".BaseInstance"
		EndFunction
	EndProperty

	bool Property IsRegistered Hidden
		bool Function Get()
			{Returns true if this menu is registered.}
			return UI.IsMenuRegistered(Name)
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			{Returns true if this menu is open.}
			return UI.IsMenuOpen(Name)
		EndFunction
	EndProperty
EndGroup

Group Asset
	string Property File Hidden
		{The asset file to load within the given menu. The root directory is "Data\Interface".}
		string Function Get()
			return "ExamineMenu_ODST.swf"
		EndFunction
	EndProperty

	string Property Asset Hidden
		{The menu asset's instance variable.}
		string Function Get()
			return AssetValue
		EndFunction
	EndProperty

	bool Property IsLoaded Hidden
		{Returns true if this asset has been loaded.}
		bool Function Get()
			return Loaded
		EndFunction
	EndProperty
EndGroup
