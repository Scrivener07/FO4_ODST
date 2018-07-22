Scriptname ODST:Settings extends ODST:Type
import ODST:Log

string PauseMenu = "PauseMenu" const
;---------------------------------------------
string OnMCMOpen = "OnMCMOpen" const
string OnMCMClose = "OnMCMClose" const
string OnMCMSettingChange = "OnMCMSettingChange" const


; Events
;---------------------------------------------

Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
	WriteLine(self, "OnQuestInit")
EndEvent


Event OnGameReload()
	WriteLine(self, "OnGameReload", "Re-registering for external events.")
	RegisterForMenuOpenCloseEvent(PauseMenu)
	RegisterForExternalEvent(OnMCMOpen, "OnMCMOpen")
	RegisterForExternalEvent(OnMCMClose, "OnMCMClose")
	RegisterForExternalEvent(OnMCMSettingChange+"|"+Properties.PluginName, "OnMCMSettingChange")
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	WriteLine(self, "OnMenuOpenCloseEvent", "asMenuName="+asMenuName+", abOpening="+abOpening+"")
	If (abOpening)
		var[] arguments = new var[1]
		arguments[0] = MenuOpened
		SendCustomEvent("OnMenu", arguments)
	Else
		var[] arguments = new var[1]
		arguments[0] = MenuClosed
		SendCustomEvent("OnMenu", arguments)
	EndIf
EndEvent


; Callbacks
;---------------------------------------------

Function OnMCMOpen()
	WriteLine(self, "OnMCMOpen", "The mcm menu was opened.")
	var[] arguments = new var[1]
	arguments[0] = MenuShown
	SendCustomEvent("OnMenu", arguments)
EndFunction


Function OnMCMClose()
	WriteLine(self, "OnMCMClose", "The mcm menu was closed.")
	var[] arguments = new var[1]
	arguments[0] = MenuHidden
	SendCustomEvent("OnMenu", arguments)
EndFunction


Function OnMCMSettingChange(string modName, string identifier)
	WriteLine(self, "OnMCMSettingChange(modName="+modName+", identifier="+identifier+")", "An mcm setting has changed.")
	If (modName == Properties.PluginName)
		ChangedEventArgs e = new ChangedEventArgs
		e.ModName = modName
		e.Identifier = identifier
		var[] arguments = new var[1]
		arguments[0] = e
		SendCustomEvent("OnChanged", arguments)
	Else
		WriteUnexpected(self, "OnMCMSettingChange", "The "+modName+" modName was unhandled.")
	EndIf
EndFunction


; OnMenu
;---------------------------------------------

CustomEvent OnMenu

Struct MenuEventArgs
	int MenuState = -1
EndStruct

bool Function RegisterForMenuEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnMenu")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForMenuEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForMenuEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnMenu")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForMenuEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


MenuEventArgs Function GetMenuEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as MenuEventArgs
	Else
		WriteUnexpectedValue(self, "GetMenuEventArgs", "arguments", "The changed event arguments are empty or none.")
		return none
	EndIf
EndFunction


; OnChanged
;---------------------------------------------

CustomEvent OnChanged

Struct ChangedEventArgs
	string ModName
	string Identifier
EndStruct


bool Function RegisterForChangedEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnChanged")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForChangedEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForChangedEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnChanged")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForChangedEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


ChangedEventArgs Function GetChangedEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as ChangedEventArgs
	Else
		WriteUnexpectedValue(self, "GetChangedEventArgs", "arguments", "The changed event arguments are empty or none.")
		return none
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function ToString()
	{The string representation of this type.}
	return "[ODST:Settings]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
EndGroup

Group Menu
	int Property MenuOpened = 1 AutoReadOnly
	int Property MenuShown = 2 AutoReadOnly
	int Property MenuHidden = 3 AutoReadOnly
	int Property MenuClosed = 4 AutoReadOnly
EndGroup
