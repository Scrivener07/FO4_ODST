Scriptname ODST:Settings extends ODST:Type
import ODST:Log

;---------------------------------------------

string OnMCMOpen = "OnMCMOpen" const
string OnMCMSettingChange = "OnMCMSettingChange" const


; Events
;---------------------------------------------

Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
	WriteMessage(self, "ODST Prototype", "The ODST prototype features have started.")
EndEvent


Event OnGameReload()
	RegisterForExternalEvent(OnMCMOpen, "OnOpen");
	RegisterForExternalEvent("OnMCMSettingChange|ODST", "OnSettingChange")
	WriteLine(self, "OnGameReload", "Re-registered for external events.")
EndEvent


; Callbacks
;---------------------------------------------

Function OnOpen()
	WriteLine(self, "OnOpen", "The settings menu was opened.")
EndFunction


Function OnSettingChange(string modName, string identifier)
	WriteLine(self, "OnSettingChange(modName="+modName+", identifier="+identifier+")", "A setting has changed.")
	Emblems.UpdateSwap()
	Emblems.ApplySwap()
EndFunction


; Functions
;---------------------------------------------

string Function Shape1ToString(int value)
	{Converts a color index into the colors name as a string.}
	If (value == Cancel)
		return none
	ElseIf (value == Grenade)
		return "Grenade"
	ElseIf (value == Spartan)
		return "Spartan"
	ElseIf (value == SpartanHelmet)
		return "SpartanHelmet"
	Else
		WriteUnexpected(self, "Shape1ToString", "The value of "+value+" was out of range.")
		return none
	EndIf
EndFunction


string Function Shape2ToString(int value)
	{Converts a color index into the colors name as a string.}
	If (value == Cancel)
		return none
	ElseIf (value == Circle)
		return "Circle"
	ElseIf (value == Display)
		return "Display"
	ElseIf (value == Shield)
		return "Shield"
	Else
		WriteUnexpected(self, "Shape2ToString", "The value of "+value+" was out of range.")
		return none
	EndIf
EndFunction


string Function ColorToString(int value)
	{Converts a color index into the colors name as a string.}
	If (value == Black)
		return "Black"
	ElseIf (value == Blue)
		return "Blue"
	ElseIf (value == Cyan)
		return "Cyan"
	ElseIf (value == Green)
		return "Green"
	ElseIf (value == Orange)
		return "Orange"
	ElseIf (value == Purple)
		return "Purple"
	ElseIf (value == Red)
		return "Red"
	ElseIf (value == White)
		return "White"
	ElseIf (value == Yellow)
		return "Yellow"
	Else
		WriteUnexpected(self, "ColorToString", "The value of "+value+" was out of range.")
		return none
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return "[ODST:Settings]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory

	string Property PluginName Hidden
		string Function Get()
			{The main project plugin file.}
			return "ODST"
		EndFunction
	EndProperty

	string Property PluginFile Hidden
		string Function Get()
			{The main project plugin file.}
			return PluginName+".esp"
		EndFunction
	EndProperty
EndGroup

Group Emblems
	ODST:Emblems Property Emblems Auto Const Mandatory
	int Property Decal Auto Hidden
	int Property PrimaryColor Auto Hidden
	int Property SecondaryColor Auto Hidden
	int Property Background Auto Hidden
	int Property BackgroundColor Auto Hidden
EndGroup

Group EmblemDecal
	int Property Cancel = 0 AutoReadOnly
	int Property Grenade = 1 AutoReadOnly
	int Property Spartan = 2 AutoReadOnly
	int Property SpartanHelmet = 3 AutoReadOnly
EndGroup

Group EmblemBackground
	int Property Circle = 1 AutoReadOnly
	int Property Display = 2 AutoReadOnly
	int Property Shield = 3 AutoReadOnly
EndGroup

Group EmblemColor
	int Property Black = 0 AutoReadOnly
	int Property Blue = 1 AutoReadOnly
	int Property Cyan = 2 AutoReadOnly
	int Property Green = 3 AutoReadOnly
	int Property Orange = 4 AutoReadOnly
	int Property Purple = 5 AutoReadOnly
	int Property Red = 6 AutoReadOnly
	int Property White = 7 AutoReadOnly
	int Property Yellow = 8 AutoReadOnly
EndGroup
