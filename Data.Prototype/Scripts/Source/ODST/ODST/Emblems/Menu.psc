Scriptname ODST:Emblems:Menu extends ODST:Emblems:MenuType
{Provides capabilities to display an emblem preset within the user interface.}
import ODST
import ODST:Emblems
import ODST:Examine:Menu
import ODST:Log
import ODST:Papyrus

; Events
;---------------------------------------------

Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)

	ExamineMenu.RegisterForOpenCloseEvent(self)

	RegisterForExternalEvent("ODST_Examine_OnModChanged", "OnModChanged")
	RegisterForExternalEvent("ODST_Examine_OnEditButton", "OnEditButton")
	WriteLine(ToString(), "OnQuestInit")
EndEvent


Event OnGameReload()
	UI:MenuData data = new UI:MenuData
	data.MenuFlags = FlagDoNotPreventGameSave
	data.ExtendedFlags = FlagNone
	If (UI.RegisterCustomMenu(Menu, Asset, Root, data))
		WriteLine(ToString(), ToString()+" has registered as a custom menu.")
	Else
		WriteUnexpected(ToString(), "OnGameReload", "Failed to register as a custom menu.")
	EndIf

	If (!Game.GetPlayer().HasPerk(ODST_Emblems_CustomPerk))
		Game.GetPlayer().AddPerk(ODST_Emblems_CustomPerk)
	EndIf

	RegisterForKey(P) ; DebugOnly
EndEvent


Event OnKeyDown(int aiKeyCode) ; DebugOnly
	If (UI.IsMenuOpen("Console"))
		return
	EndIf
	ToggleMenu()
EndEvent


Event ODST:Examine:Menu.OpenCloseEvent(Examine:Menu sender, var[] arguments)
	If (arguments)
		OpenCloseEventArgs e = sender.GetOpenCloseEventArgs(arguments)
		If (e.Opening)
			Open()
		Else
			Close()
		EndIf
	Else
		WriteUnexpectedValue(self, "ODST:Examine:Menu.OpenCloseEvent", "arguments", "The value cannot be none.")
		Close()
	EndIf
EndEvent


Event OnModChanged(int selected)
	WriteLine(ToString(), "OnModChanged(argument:"+selected+")")
	If (selected > Invalid)
		Emblems:Preset preset = Editor.GetPreset(selected)
		Update(Editor, preset)
		SetVisible(true)
	Else
		SetVisible(false)
		; WriteUnexpectedValue(self, "OnModChanged", "selected", "The value of "+selected+" is not valid.")
	EndIf
EndEvent


Event OnEditButton()
	; Open()
	WriteLine(ToString(), "OnEditButton")
EndEvent



; Methods
;---------------------------------------------

; @Editor
bool Function Update(Emblems:Editor sender, Emblems:Preset preset)
	{Updates the preview user interface.}

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

	MCM.SetModSettingString(sender.Properties.PluginName, "sEmblem_PreviewPrimary:Settings", sTexturePathPrimary)
	MCM.SetModSettingInt(sender.Properties.PluginName, "iEmblem_PreviewPrimaryColor:Settings", iColorPrimary)
	MCM.SetModSettingString(sender.Properties.PluginName, "sEmblem_PreviewSecondary:Settings", sTexturePathSecondary)
	MCM.SetModSettingInt(sender.Properties.PluginName, "iEmblem_PreviewSecondaryColor:Settings", iColorSecondary)
	MCM.SetModSettingString(sender.Properties.PluginName, "sEmblem_PreviewBackground:Settings", sTexturePathBackground)
	MCM.SetModSettingInt(sender.Properties.PluginName, "iEmblem_PreviewBackgroundColor:Settings", iColorBackground)

	WriteLine(ToString(), "Update:"+ToString())
EndFunction


bool Function Open()
	If (IsRegistered)
		return UI.OpenMenu(Menu)
	Else
		WriteUnexpected(ToString(), "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function Close()
	If (IsRegistered)
		return UI.CloseMenu(Menu)
	Else
		WriteUnexpected(ToString(), "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function ToggleMenu()
	If (IsOpen)
		If(Close())
			WriteLine(ToString(), "ToggleMenu", "Closed.")
		Else
			WriteLine(ToString(), "ToggleMenu", "Could not close!")
		EndIf
	Else
		If(Open())
			WriteLine(ToString(), "ToggleMenu", "Opened.")
		Else
			WriteLine(ToString(), "ToggleMenu", "Could not open!")
		EndIf
	EndIf
EndFunction


bool Function GetVisible()
	If (IsOpen)
		return UI.Get(Menu, GetMember("Visible")) as bool
	Else
		WriteUnexpected(ToString(), "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (IsOpen)
		return UI.Set(Menu, GetMember("Visible"), value)
	Else
		WriteUnexpected(ToString(), "SetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetPrimary(string filepath, int color)
	If (IsOpen)
		If (filepath)
			var[] arguments = new var[2]
			arguments[0] = filepath
			arguments[1] = color
			UI.Invoke(Menu, GetMember("SetPrimary"), arguments)
			WriteLine(ToString(), "SetPrimary:"+arguments)
			return true
		Else
			WriteUnexpectedValue(ToString(), "SetPrimary", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(ToString(), "SetPrimary", ToString()+" is not open.")
		return false
	EndIf
EndFunction


bool Function SetSecondary(string filepath, int color)
	If (IsOpen)
		If (filepath)
			var[] arguments = new var[2]
			arguments[0] = filepath
			arguments[1] = color
			UI.Invoke(Menu, GetMember("SetSecondary"), arguments)
			WriteLine(ToString(), "SetSecondary:"+arguments)
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
			UI.Invoke(Menu, GetMember("SetBackground"), arguments)
			WriteLine(ToString(), "SetBackground:"+arguments)
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
	{Returns the full AS3 instance path for the given member name.}
	If (StringIsNoneOrEmpty(member))
		WriteUnexpectedValue(ToString(), "GetMember", "member", "Cannot operate on a none or empty display member.")
		return none
	ElseIf (StringIsNoneOrEmpty(root))
		WriteUnexpected(ToString(), "GetMember", "Cannot operate on a none or empty display root.")
		return none
	Else
		return Root+"."+member
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+"[Menu:"+Menu+", Asset:"+Asset+", Root:"+Root+"]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Perk Property ODST_Emblems_CustomPerk Auto Const Mandatory
EndGroup

Group Scripts
	ODST:Emblems:Editor Property Editor Auto Const Mandatory
	ODST:Examine:Menu Property ExamineMenu Auto Const Mandatory
EndGroup

Group Display
	string Property Menu Hidden
		{The name of the menu to load within.}
		string Function Get()
			return "ODST_EmblemMenu"
		EndFunction
	EndProperty

	string Property Root Hidden
		{The root display object.}
		string Function Get()
			return "root1"
		EndFunction
	EndProperty

	string Property Asset Hidden
		{The asset file to load within the given menu. The root directory is "Data\Interface".}
		string Function Get()
			return "EmblemMenu"
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			{Returns true if this menu is open.}
			return UI.IsMenuOpen(Menu)
		EndFunction
	EndProperty

	bool Property IsRegistered Hidden
		bool Function Get()
			{Returns true if this menu is registered.}
			return UI.IsMenuRegistered(Menu)
		EndFunction
	EndProperty
EndGroup

Group MenuFlags
	int Property FlagNone = 0x0 AutoReadOnly
	int Property FlagDoNotPreventGameSave = 0x800 AutoReadOnly
EndGroup

Group Keyboard
	int Property P = 80 AutoReadOnly
EndGroup
