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
	AddItem(ProjectHelljumper, Armor_H3_ODST)
	AddItem(ProjectHelljumper, Armor_H3_ODST_Helmet)
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

Group External
	string Property ProjectHelljumper = "ProjectHelljumper.esp" AutoReadOnly
	{Project Helljumper plugin name with file extension.}

	int Property Armor_H3_ODST = 0x01006ADA AutoReadOnly
	{Armor_H3_ODST "H3 ODST Armor" [ARMO:01006ADA]}

	int Property Armor_H3_ODST_Helmet = 0x01006ADB AutoReadOnly
	{Armor_H3_ODST_Helmet "H3 ODST Helmet" [ARMO:01006ADB]}
EndGroup
