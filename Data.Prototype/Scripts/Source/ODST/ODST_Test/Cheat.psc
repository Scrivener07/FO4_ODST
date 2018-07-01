Scriptname ODST_Test:Cheat extends Quest
import ODST:Papyrus

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
EndEvent


; Functions
;---------------------------------------------

Function AddItem(string plugin, int formID)
	Form item = GetExternal(plugin, formID)
	If (item)
		Player.AddItem(item, 1, Silent)
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
EndGroup
