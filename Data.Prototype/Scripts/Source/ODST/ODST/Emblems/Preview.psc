Scriptname ODST:Emblems:Preview extends ODST:Type
import ODST:Log
import ODST:Papyrus

DisplayData Display

Struct DisplayData
	string Menu
	{The name of the menu to load within.}

	string Root = "root1"
	{The root display object.}

	string Asset
	{The asset file to load within the given menu. The root directory is "Data\Interface".}
EndStruct


; Events
;---------------------------------------------

Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
	WriteLine(self, "OnQuestInit")
EndEvent


Event OnGameReload()
	Display = NewDisplay()
	UI:MenuData data = new UI:MenuData
	data.MenuFlags = FlagDoNotPreventGameSave
	data.ExtendedFlags = FlagNone
	If (UI.RegisterCustomMenu(Display.Menu, Display.Asset, Display.Root, data))
		WriteLine(self, ToString()+" has registered as a custom menu.")
	Else
		WriteUnexpected(self, "OnGameReload", ToString()+" failed to register as a custom menu.")
	EndIf

	TestMenu()
EndEvent


; Display
;---------------------------------------------

DisplayData Function NewDisplay()
	DisplayData this = new DisplayData
	this.Menu = "ODST_EmblemMenu"
	this.Asset = "Preview"
	this.Root = "root1"
	return this
EndFunction


Function TestMenu() DebugOnly
	RegisterForKey(P)
EndFunction


Event OnKeyDown(int aiKeyCode)
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

bool Function Open()
	If (UI.IsMenuRegistered(Menu))
		return UI.OpenMenu(Menu)
	Else
		WriteUnexpected(self, "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function Close()
	If (UI.IsMenuRegistered(Menu))
		return UI.CloseMenu(Menu)
	Else
		WriteUnexpected(self, "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function GetVisible()
	If (UI.IsMenuOpen(Menu))
		return UI.Get(Menu, GetMember("Visible")) as bool
	Else
		WriteUnexpected(self, "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool filepath)
	If (UI.IsMenuOpen(Menu))
		return UI.Set(Menu, GetMember("Visible"), filepath)
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
	{The string representation of this UI type.}
	return "[Menu:"+Menu+", Asset:"+Asset+", Root:"+Root+"]"
EndFunction


; Properties
;---------------------------------------------

Group Display
	string Property Menu Hidden
		string Function Get()
			return Display.Menu
		EndFunction
	EndProperty

	string Property Root Hidden
		string Function Get()
			return Display.Root
		EndFunction
	EndProperty

	string Property Asset Hidden
		string Function Get()
			return Display.Asset
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			{Returns true if this menu is open.}
			return UI.IsMenuOpen(Display.Menu)
		EndFunction
	EndProperty

	bool Property IsRegistered Hidden
		bool Function Get()
			{Returns true if this menu is registered.}
			return UI.IsMenuRegistered(Display.Menu)
		EndFunction
	EndProperty
EndGroup

Group MenuFlags
	int Property FlagNone = 0x0 AutoReadOnly
	int Property FlagPauseGame = 0x01 AutoReadOnly
	int Property FlagShowCursor = 0x04 AutoReadOnly
	int Property FlagEnableMenuControl = 0x08 AutoReadOnly
	int Property FlagDoNotPreventGameSave = 0x800 AutoReadOnly
EndGroup

Group ExtendedFlags
	; If you set extendedFlags & 2, it will disable your ShowCursor if the Gamepad is enabled
	int Property FlagInheritColors = 1 AutoReadOnly
	int Property FlagCheckForGamepad = 2 AutoReadOnly
EndGroup

Group Keyboard
	int Property P = 80 AutoReadOnly
EndGroup
