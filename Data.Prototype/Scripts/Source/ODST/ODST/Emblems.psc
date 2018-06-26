Scriptname ODST:Emblems extends Quest
import ODST:Log
import ODST:Papyrus

Actor Player
Armor Armor_H3_ODST
ObjectMod mod_ODST_Decals_Menu_Start
MatSwap ODST_Decals_Menu_Start

;---------------------------------------------

MatSwap:RemapData[] Remapping
MatSwap:RemapData RemapBackground
MatSwap:RemapData RemapPrimary
MatSwap:RemapData RemapSecondary

;---------------------------------------------

string ProjectHelljumper = "ProjectHelljumper.esp" const
int ID_Armor_H3_ODST = 0x01006ADA const ; {Armor_H3_ODST "H3 ODST Armor" [ARMO:01006ADA]}
int ID_mod_ODST_Decals_Menu_Start = 0x01003691 const ; {mod_ODST_Decals_Menu_Start "Decal - Blank" [OMOD:01003691]}
int ID_ODST_Decals_Menu_Start = 0x01003690 const ; {ODST_Decals_Menu_Start [MSWP:01003690]}

int Invalid = -1 const
int Black = 0 const
int Blue = 1 const
int Cyan = 2 const
int Green = 3 const
int Orange = 4 const
int Purple = 5 const
int Red = 6 const
int White = 7 const
int Yellow = 8 const

Group MCM
	int Property Background Auto Hidden
	int Property BackgroundColor Auto Hidden
	int Property Primary Auto Hidden
	int Property PrimaryColor Auto Hidden
	int Property SecondaryColor Auto Hidden
EndGroup


; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	Armor_H3_ODST = GetExternal(ProjectHelljumper, ID_Armor_H3_ODST) as Armor
	mod_ODST_Decals_Menu_Start = GetExternal(ProjectHelljumper, ID_mod_ODST_Decals_Menu_Start) as ObjectMod
	ODST_Decals_Menu_Start = GetExternal(ProjectHelljumper, ID_ODST_Decals_Menu_Start) as MatSwap

	Remapping = new MatSwap:RemapData[0]

	RemapBackground = new MatSwap:RemapData
	RemapBackground.Source = "ProjectHelljumper\\H3ODST\\1Decals\\DECALS\\Background\\Blank.BGEM"
	RemapBackground.Target = none
	Remapping.Add(RemapBackground)

	RemapPrimary = new MatSwap:RemapData
	RemapPrimary.Source = "ProjectHelljumper\\H3ODST\\1Decals\\DECALS\\Primary\\Blank.BGEM"
	RemapPrimary.Target = none
	Remapping.Add(RemapPrimary)

	RemapSecondary = new MatSwap:RemapData
	RemapSecondary.Source = "ProjectHelljumper\\H3ODST\\1Decals\\DECALS\\Secondary\\Blank.BGEM"
	RemapSecondary.Target = none
	Remapping.Add(RemapSecondary)

	RegisterForMenuOpenCloseEvent("PauseMenu")
	WriteMessage(self, "ODST Prototype", "The ODST prototype features have started.")
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (!abOpening)
		Update()
		ApplySwap()
		WriteLine(self, "ODST Prototype", "Hot swap updated ODST emblem.")
	EndIf
EndEvent


; Functions
;---------------------------------------------

Function Update()
	If (Background == 0)
		RemapBackground.Target = RemapBackground.Source
	ElseIf(Background == 1)
		RemapBackground.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Background\\"+ColorToString(BackgroundColor)+"\\Circle.BGEM"
	ElseIf(Background == 2)
		RemapBackground.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Background\\"+ColorToString(BackgroundColor)+"\\Display.BGEM"
	ElseIf(Background == 3)
		RemapBackground.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Background\\"+ColorToString(BackgroundColor)+"\\Shield.BGEM"
	EndIf

	If (Primary == 0)
		RemapPrimary.Target = RemapPrimary.Source
		RemapSecondary.Target = RemapSecondary.Source
	ElseIf(Primary == 1)
		RemapPrimary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decal\\Primary\\"+ColorToString(PrimaryColor)+"\\Grenade.BGEM"
		RemapSecondary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decal\\Secondary\\"+ColorToString(SecondaryColor)+"\\Grenade.BGEM"
	ElseIf(Primary == 2)
		RemapPrimary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Primary\\"+ColorToString(PrimaryColor)+"\\Spartan.BGEM"
		RemapSecondary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Secondary\\"+ColorToString(SecondaryColor)+"\\Spartan.BGEM"
	ElseIf(Primary == 3)
		RemapPrimary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Primary\\"+ColorToString(PrimaryColor)+"\\SpartanHelmet.BGEM"
		RemapSecondary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Secondary\\"+ColorToString(SecondaryColor)+"\\SpartanHelmet.BGEM"
	EndIf
EndFunction


Function ApplySwap()
	ODST_Decals_Menu_Start.SetRemapData(Remapping)
	Player.ApplyMaterialSwap(ODST_Decals_Menu_Start)
EndFunction


string Function ColorToString(int value)
	If (value == Invalid)
		return "White"
	ElseIf (value == Black)
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
		return "White"
	EndIf
EndFunction


;---------------------------------------------
; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Background\Black\Circle.BGEM
; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Background\Black\Display.BGEM
; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Background\Black\Shield.BGEM
;---------------------------------------------
; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Primary\Black\Grenade.BGEM
; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Primary\Black\Spartan.BGEM
; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Primary\Black\SpartanHelmet.BGEM
;---------------------------------------------
; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Secondary\Black\Grenade.BGEM
; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Secondary\Black\Spartan.BGEM
; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Secondary\Black\SpartanHelmet.BGEM
;---------------------------------------------
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Secondary\Spartan2.dds
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Secondary\Spartan Helmet2.dds
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Secondary\Grenade2.dds
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Primary\Spartan1.dds
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Primary\Spartan Helmet1.dds
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Primary\Grenade1.dds
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Background\Shield.dds
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Background\Display.dds
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Background\Circle.dds
; .\Fallout 4\Data\Textures\ProjectHelljumper\H3ODST\1Decals\Decals\Blank.dds
;---------------------------------------------
