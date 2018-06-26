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

Group MCM
	int Property Background Auto Hidden
	int Property Primary Auto Hidden
	int Property Secondary Auto Hidden
EndGroup


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
		WriteMessage(self, "ODST Prototype", "Hot swap updated ODST emblem.")
	EndIf
EndEvent


; Functions
;---------------------------------------------

Function Update()
	; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Background\Black\Circle.BGEM
	; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Background\Black\Display.BGEM
	; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Background\Black\Shield.BGEM

	; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Primary\Black\Grenade.BGEM
	; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Primary\Black\Spartan.BGEM
	; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Primary\Black\SpartanHelmet.BGEM

	; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Secondary\Black\Grenade.BGEM
	; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Secondary\Black\Spartan.BGEM
	; .\Fallout 4\Data\Materials\ProjectHelljumper\H3ODST\1Decals\Decals\Secondary\Black\SpartanHelmet.BGEM

	String BackgroundColor = "Red" const
	String PrimaryColor = "White" const
	String SecondaryColor = "Blue" const

	If (Background == 0)
		RemapBackground.Target = RemapBackground.Source
	ElseIf(Background == 1)
		RemapBackground.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Background\\"+BackgroundColor+"\\Circle.BGEM"
	ElseIf(Background == 2)
		RemapBackground.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Background\\"+BackgroundColor+"\\Display.BGEM"
	ElseIf(Background == 3)
		RemapBackground.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Background\\"+BackgroundColor+"\\Shield.BGEM"
	EndIf

	If (Primary == 0)
		RemapPrimary.Target = RemapPrimary.Source
	ElseIf(Primary == 1)
		RemapPrimary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decal\\Primary\\"+PrimaryColor+"\\Grenade.BGEM"
	ElseIf(Primary == 2)
		RemapPrimary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Primary\\"+PrimaryColor+"\\Spartan.BGEM"
	ElseIf(Primary == 3)
		RemapPrimary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Primary\\"+PrimaryColor+"\\SpartanHelmet.BGEM"
	EndIf

	If (Secondary == 0)
		RemapSecondary.Target = RemapSecondary.Source
	ElseIf(Secondary == 1)
		RemapSecondary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decal\\Secondary\\"+SecondaryColor+"\\Grenade.BGEM"
	ElseIf(Secondary == 2)
		RemapSecondary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Secondary\\"+SecondaryColor+"\\Spartan.BGEM"
	ElseIf(Secondary == 3)
		RemapSecondary.Target = "ProjectHelljumper\\H3ODST\\1Decals\\Decals\\Secondary\\"+SecondaryColor+"\\SpartanHelmet.BGEM"
	EndIf
EndFunction


Function ApplySwap()
	ODST_Decals_Menu_Start.SetRemapData(Remapping)
	Player.ApplyMaterialSwap(ODST_Decals_Menu_Start)
EndFunction


Function Clear()
	RemapBackground.Target = RemapBackground.Source
	RemapPrimary.Target = RemapPrimary.Source
	RemapSecondary.Target = RemapSecondary.Source
	ApplySwap()
EndFunction
