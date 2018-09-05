Scriptname ODST:Emblems:Preview extends ODST:Type
{Provides capabilities to display an emblem preset within the user interface.}
import ODST
import ODST:Log
import ODST:Papyrus
import ODST:Emblems

; Events
;---------------------------------------------

Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
	WriteLine(self, "OnQuestInit")
EndEvent


Event OnGameReload()
	UI:MenuData data = new UI:MenuData
	data.MenuFlags = FlagDoNotPreventGameSave
	data.ExtendedFlags = FlagNone
	If (UI.RegisterCustomMenu(Menu, Asset, Root, data))
		WriteLine(self, ToString()+" has registered as a custom menu.")
	Else
		WriteUnexpected(self, "OnGameReload", ToString()+" failed to register as a custom menu.")
	EndIf

	RegisterForKey(P) ; DebugOnly
EndEvent


Event OnKeyDown(int aiKeyCode) ; DebugOnly
	If (UI.IsMenuOpen("Console"))
		return
	EndIf

	If (IsOpen)
		If(Close())
			WriteLine(self, "OnKeyDown", ToString()+" closed.")
		Else
			WriteLine(self, "OnKeyDown", ToString()+" could not close!")
		EndIf
	Else
		If(Open())
			WriteLine(self, "OnKeyDown", ToString()+" opened.")
		Else
			WriteLine(self, "OnKeyDown", ToString()+" could not open!")
		EndIf
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Update(Emblems:Editor editor, Emblems:Preset preset)
	{Updates the preview user interface.}

	string sLayerPrimary = editor.Symbol.ForegroundToFolder(preset.Foreground)
	string sTexturePathPrimary = editor.ToTexturePath(editor.PrimaryLayer, sLayerPrimary)
	int iColorPrimary = editor.Color.OptionToHex(preset.ForegroundColorPrimary)
	SetPrimary(sTexturePathPrimary, iColorPrimary)

	string sTexturePathSecondary = editor.ToTexturePath(editor.SecondaryLayer, sLayerPrimary)
	int iColorSecondary = editor.Color.OptionToHex(preset.ForegroundColorSecondary)
	SetSecondary(sTexturePathSecondary, iColorSecondary)

	string sLayerBackground = editor.Symbol.BackgroundToFolder(preset.Background)
	string sTexturePathBackground = editor.ToTexturePath(editor.BackgroundLayer, sLayerBackground)
	int iColorBackground = editor.Color.OptionToHex(preset.BackgroundColor)
	SetBackground(sTexturePathBackground, iColorBackground)

	MCM.SetModSettingString(editor.Properties.PluginName, "sEmblem_PreviewPrimary:Settings", sTexturePathPrimary)
	MCM.SetModSettingInt(editor.Properties.PluginName, "iEmblem_PreviewPrimaryColor:Settings", iColorPrimary)
	MCM.SetModSettingString(editor.Properties.PluginName, "sEmblem_PreviewSecondary:Settings", sTexturePathSecondary)
	MCM.SetModSettingInt(editor.Properties.PluginName, "iEmblem_PreviewSecondaryColor:Settings", iColorSecondary)
	MCM.SetModSettingString(editor.Properties.PluginName, "sEmblem_PreviewBackground:Settings", sTexturePathBackground)
	MCM.SetModSettingInt(editor.Properties.PluginName, "iEmblem_PreviewBackgroundColor:Settings", iColorBackground)

	WriteLine(self, "Update:"+ToString())
EndFunction


bool Function Open()
	If (IsRegistered)
		return UI.OpenMenu(Menu)
	Else
		WriteUnexpected(self, "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function Close()
	If (IsRegistered)
		return UI.CloseMenu(Menu)
	Else
		WriteUnexpected(self, "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function GetVisible()
	If (IsOpen)
		return UI.Get(Menu, GetMember("Visible")) as bool
	Else
		WriteUnexpected(self, "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (IsOpen)
		return UI.Set(Menu, GetMember("Visible"), value)
	Else
		WriteUnexpected(self, "SetVisible", "The menu is not open.")
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
			WriteLine(self, "SetPrimary:"+arguments)
			return true
		Else
			WriteUnexpectedValue(self, "SetPrimary", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "SetPrimary", ToString()+" is not open.")
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
			WriteLine(self, "SetSecondary:"+arguments)
			return true
		Else
			WriteUnexpectedValue(self, "SetSecondary", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "SetSecondary", ToString()+" is not open.")
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
			WriteLine(self, "SetBackground:"+arguments)
			return true
		Else
			WriteUnexpectedValue(self, "SetBackground", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "SetBackground", ToString()+" is not open.")
		return false
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function GetMember(string member)
	{Returns the full AS3 instance path for the given member name.}
	If (StringIsNoneOrEmpty(member))
		WriteUnexpectedValue(self, "GetMember", "member", "Cannot operate on a none or empty display member.")
		return none
	ElseIf (StringIsNoneOrEmpty(root))
		WriteUnexpected(self, "GetMember", "Cannot operate on a none or empty display root.")
		return none
	Else
		return Root+"."+member
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return "[Menu:"+Menu+", Asset:"+Asset+", Root:"+Root+"]"
EndFunction


; Properties
;---------------------------------------------

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
