Scriptname ODST:Settings extends ODST:Type
import ODST:Log

string PauseMenu = "PauseMenu" const
;---------------------------------------------
string OnMCMOpen = "OnMCMOpen" const
string OnMCMClose = "OnMCMClose" const
string OnMCMSettingChange = "OnMCMSettingChange" const
;---------------------------------------------
string emblem_foreground = "iEmblem_Foreground:Main" const
string emblem_foreground_color_primary = "iEmblem_Foreground_Color_Primary:Main" const
string emblem_foreground_color_secondary = "iEmblem_Foreground_Color_Secondary:Main" const
string emblem_background = "iEmblem_Background:Main" const
string emblem_background_color = "iEmblem_Background_Color:Main" const


; Events
;---------------------------------------------

Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
	WriteLine(self, "OnQuestInit")
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(PauseMenu)
	RegisterForExternalEvent(OnMCMOpen, "OnMCMOpen")
	RegisterForExternalEvent(OnMCMClose, "OnMCMClose")
	RegisterForExternalEvent(OnMCMSettingChange+"|"+PluginName, "OnMCMSettingChange")
	RegisterForExternalEvent("ODST_TestEvent", "OnODST")
	WriteLine(self, "OnGameReload", "Re-registered for external events.")
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	WriteLine(self, "OnMenuOpenCloseEvent", "asMenuName="+asMenuName+", abOpening="+abOpening+"")
	If (!abOpening)
		Option.Apply()
	EndIf
EndEvent


; Callbacks
;---------------------------------------------

Function OnMCMOpen()
	WriteLine(self, "OnMCMOpen", "The mcm menu was opened.")
EndFunction


Function OnMCMClose()
	WriteLine(self, "OnMCMClose", "The mcm menu was closed.")
EndFunction


Function OnODST()
	WriteLine(self, "OnODST", "We have the callback!")
EndFunction


Function OnMCMSettingChange(string modName, string identifier)
	WriteLine(self, "OnMCMSettingChange(modName="+modName+", identifier="+identifier+")", "An mcm setting has changed.")
	If (modName == PluginName)
		Option.Foreground = MCM.GetModSettingInt(modName, emblem_foreground)
		Option.ForegroundColorPrimary = MCM.GetModSettingInt(modName, emblem_foreground_color_primary)
		Option.ForegroundColorSecondary = MCM.GetModSettingInt(modName, emblem_foreground_color_secondary)
		Option.Background = MCM.GetModSettingInt(modName, emblem_background)
		Option.BackgroundColor = MCM.GetModSettingInt(modName, emblem_background_color)
		Option.Apply()
	Else
		WriteUnexpected(self, "OnMCMSettingChange", "The "+modName+" modName was unhandled.")
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
	ODST:Emblems:Option Property Option Auto Const Mandatory

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
