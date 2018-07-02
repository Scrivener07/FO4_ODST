Scriptname ODST:Cheat extends Quest
import ODST:Papyrus
import ODST:Log

Actor Player
bool Silent = true const


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


Event OnQuestInit()
	AddItem(Properties.PluginFile, Properties.Armor_H3_ODST)
	AddItem(Properties.PluginFile, Properties.Armor_H3_ODST_Helmet)
	Writeline(self, "OnQuestInit", "Cheated the ODST H3 items for the player.")
EndEvent


; Functions
;---------------------------------------------

Function AddItem(string plugin, int formID)
	Form item = GetExternal(plugin, formID)
	If (item)
		Player.AddItem(item, 1, Silent)
	Else
		WriteUnexpected(self, "AddItem", "Could not get the "+formID+" form ID from "+plugin)
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
EndGroup
