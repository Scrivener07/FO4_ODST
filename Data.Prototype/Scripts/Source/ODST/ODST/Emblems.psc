Scriptname ODST:Emblems extends Quest
import ODST:Log
import ODST:Papyrus

Actor Player
Armor Armor_H3_ODST
ObjectMod mod_ODST_Decals_Menu_Start

;---------------------------------------------

MatSwap ODST_Decals_Menu_Start
string Background = "ProjectHelljumper\\H3ODST\\1Decals\\DECALS\\Background\\Blank.BGEM" const
string Primary =    "ProjectHelljumper\\H3ODST\\1Decals\\DECALS\\Primary\\Blank.BGEM" const
string Secondary =  "ProjectHelljumper\\H3ODST\\1Decals\\DECALS\\Secondary\\Blank.BGEM" const

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


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	Armor_H3_ODST = GetExternal(ProjectHelljumper, ID_Armor_H3_ODST) as Armor
	mod_ODST_Decals_Menu_Start = GetExternal(ProjectHelljumper, ID_mod_ODST_Decals_Menu_Start) as ObjectMod
	ODST_Decals_Menu_Start = GetExternal(ProjectHelljumper, ID_ODST_Decals_Menu_Start) as MatSwap
EndEvent


Event OnQuestInit()
	Remapping = new MatSwap:RemapData[0]

	RemapBackground = new MatSwap:RemapData
	RemapBackground.Source = Background
	RemapBackground.Target = Background
	Remapping.Add(RemapBackground)

	RemapPrimary = new MatSwap:RemapData
	RemapPrimary.Source = Primary
	RemapPrimary.Target = Primary
	Remapping.Add(RemapPrimary)

	RemapSecondary = new MatSwap:RemapData
	RemapSecondary.Source = Secondary
	RemapSecondary.Target = Secondary
	Remapping.Add(RemapSecondary)
EndEvent


; Functions
;---------------------------------------------

Function ApplySwap()
	ODST_Decals_Menu_Start.SetRemapData(Remapping)
	Player.ApplyMaterialSwap(ODST_Decals_Menu_Start)
EndFunction
