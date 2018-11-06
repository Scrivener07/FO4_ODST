Scriptname ODST:Cheat extends Quest
{Provides methods for cheating ODST inventory items.}
import ODST
import ODST:Log
import ODST:Papyrus

Actor Player


; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	ConfigurationMenu.RegisterForMenuStateEvent(self)
EndEvent


Event ODST:MCM:Menu.OnMenuState(MCM:Menu sender, var[] arguments)
	If (arguments)
		MCM:Menu:MenuStateEventArgs e = sender.GetMenuStateEventArgs(arguments)
		If (e.MenuState == sender.MenuOpened)
			WriteLine(self, "ODST:MCM:Menu.OnMenuState", "Opened")
			Condition_H3_ODST = true
			Condition_H3_ODST_Helmet = true
			Condition_H3_ODST_HelmetHaunted = true
			Condition_ODST = true
			Condition_ODST_Helmet = true
			Condition_ODST_Recon_Helmet = true
			sender.RefreshMenu()
		EndIf
	Else
		WriteUnexpectedValue(self, "ODST:MCM:Menu.OnMenuState", "arguments", "The arguments are none or empty.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

Function Armor_ODST()
	{@config.json}
	If (Condition_ODST)
		Condition_ODST = false
		Player.AddItem(Armor_ODST)
		ConfigurationMenu.RefreshMenu()
		WriteLine(self, "Armor_ODST")
	Else
		WriteUnexpectedValue(self, "Armor_ODST", "Condition_ODST", "The condition was not true.")
	EndIf
EndFunction


Function Armor_ODST_Helmet()
	{@config.json}
	If (Condition_ODST_Helmet)
		Condition_ODST_Helmet = false
		Player.AddItem(Armor_ODST_Helmet)
		ConfigurationMenu.RefreshMenu()
		WriteLine(self, "Armor_ODST_Helmet")
	Else
		WriteUnexpectedValue(self, "Armor_ODST_Helmet", "Condition_ODST_Helmet", "The condition was not true.")
	EndIf
EndFunction


Function Armor_ODST_Recon_Helmet()
	{@config.json}
	If (Condition_ODST_Recon_Helmet)
		Condition_ODST_Recon_Helmet = false
		Player.AddItem(Armor_ODST_Recon_Helmet)
		ConfigurationMenu.RefreshMenu()
		WriteLine(self, "Armor_ODST_Recon_Helmet")
	Else
		WriteUnexpectedValue(self, "Armor_ODST_Recon_Helmet", "Condition_ODST_Recon_Helmet", "The condition was not true.")
	EndIf
EndFunction

Function Armor_H3_ODST()
	{@config.json}
	If (Condition_H3_ODST)
		Condition_H3_ODST = false
		Player.AddItem(Armor_H3_ODST)
		ConfigurationMenu.RefreshMenu()
		WriteLine(self, "Armor_H3_ODST")
	Else
		WriteUnexpectedValue(self, "Armor_H3_ODST", "Condition_H3_ODST", "The condition was not true.")
	EndIf
EndFunction


Function Armor_H3_ODST_Helmet()
	{@config.json}
	If (Condition_H3_ODST_Helmet)
		Condition_H3_ODST_Helmet = false
		Player.AddItem(Armor_H3_ODST_Helmet)
		ConfigurationMenu.RefreshMenu()
		WriteLine(self, "Armor_H3_ODST_Helmet")
	Else
		WriteUnexpectedValue(self, "Armor_H3_ODST_Helmet", "Condition_H3_ODST_Helmet", "The condition was not true.")
	EndIf
EndFunction


Function Armor_H3_ODST_HelmetHaunted()
	{@config.json}
	If (Condition_H3_ODST_HelmetHaunted)
		Condition_H3_ODST_HelmetHaunted = false
		Player.AddItem(Armor_H3_ODST_HelmetHaunted)
		ConfigurationMenu.RefreshMenu()
		WriteLine(self, "Armor_H3_ODST_HelmetHaunted")
	Else
		WriteUnexpectedValue(self, "Armor_H3_ODST_HelmetHaunted", "Condition_H3_ODST_HelmetHaunted", "The condition was not true.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	MCM:Menu Property ConfigurationMenu Auto Const Mandatory
EndGroup

Group Items
	Armor Property Armor_ODST Auto Const Mandatory
	Armor Property Armor_ODST_Helmet Auto Const Mandatory
	Armor Property Armor_ODST_Recon_Helmet Auto Const Mandatory
	Armor Property Armor_H3_ODST Auto Const Mandatory
	Armor Property Armor_H3_ODST_Helmet Auto Const Mandatory
	Armor Property Armor_H3_ODST_HelmetHaunted Auto Const Mandatory
	Armor Property Armor_H3_ODST_Unique_Phantom Auto Const Mandatory
	Armor Property Armor_ODST_CE_Marine_Armour Auto Const Mandatory
	Armor Property Armor_ODST_CE_Marine_Armour_ChipsDubbo Auto Const Mandatory
	Armor Property Armor_ODST_CE_Marine_Helmet Auto Const Mandatory
EndGroup

Group Conditions
	bool Property Condition_ODST = true Auto Hidden
	bool Property Condition_ODST_Helmet = true Auto Hidden
	bool Property Condition_ODST_Recon_Helmet = true Auto Hidden
	bool Property Condition_H3_ODST = true Auto Hidden
	bool Property Condition_H3_ODST_Helmet = true Auto Hidden
	bool Property Condition_H3_ODST_HelmetHaunted = true Auto Hidden
	bool Property Condition_H3_ODST_Unique_Phantom = true Auto Hidden
	bool Property Condition_ODST_CE_Marine_Armour = true Auto Hidden
	bool Property Condition_ODST_CE_Marine_Armour_ChipsDubbo = true Auto Hidden
	bool Property Condition_ODST_CE_Marine_Helmet = true Auto Hidden
EndGroup
