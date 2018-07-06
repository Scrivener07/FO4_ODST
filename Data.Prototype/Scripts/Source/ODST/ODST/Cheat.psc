Scriptname ODST:Cheat extends Quest
import ODST:Papyrus
import ODST:Log

Actor Player


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; Methods
;---------------------------------------------

Function Armor_H3_ODST()
	AddItem(Properties.PluginFile, Properties.Armor_H3_ODST)
EndFunction


Function Armor_H3_ODST_Helmet()
	AddItem(Properties.PluginFile, Properties.Armor_H3_ODST_Helmet)
EndFunction


Function Armor_H3_ODST_HelmetHaunted()
	AddItem(Properties.PluginFile, Properties.Armor_H3_ODST_HelmetHaunted)
EndFunction


Function Armor_ODST()
	AddItem(Properties.PluginFile, Properties.Armor_ODST)
EndFunction


Function Armor_ODST_Helmet()
	AddItem(Properties.PluginFile, Properties.Armor_ODST_Helmet)
EndFunction


Function Armor_ODST_Recon_Helmet()
	AddItem(Properties.PluginFile, Properties.Armor_ODST_Recon_Helmet)
EndFunction


; Functions
;---------------------------------------------

Form Function AddItem(string plugin, int formID)
	Form item = GetExternal(plugin, formID)
	If (item)
		Player.AddItem(item, 1)
		return item
	Else
		WriteUnexpected(self, "AddItem", "Could not get the "+formID+" form ID from "+plugin)
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
EndGroup
