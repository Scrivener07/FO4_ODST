Scriptname ODST:Properties extends Quest

; Properties
;---------------------------------------------

Group Properties
	string Property PluginName Hidden
		string Function Get()
			{The main project plugin file.}
			return "ProjectHelljumper"
		EndFunction
	EndProperty
	string Property PluginFile Hidden
		string Function Get()
			{The main project plugin file.}
			return PluginName+".esp"
		EndFunction
	EndProperty
EndGroup

Group Forms
	int Property Armor_H3_ODST Hidden
		int Function Get()
			{Armor_H3_ODST "H3 ODST Armor" [ARMO:01006ADA]}
			return 0x00006ADA
		EndFunction
	EndProperty

	int Property Armor_H3_ODST_Helmet  Hidden
		int Function Get()
			{Armor_H3_ODST_Helmet "H3 ODST Helmet" [ARMO:01006ADB]}
			return 0x00006ADB
		EndFunction
	EndProperty

	int Property mod_ODST_Decals_Menu_Start Hidden
		int Function Get()
			{mod_ODST_Decals_Menu_Start "Decal - Blank" [OMOD:01003691]}
			return 0x00003691
		EndFunction
	EndProperty

	int Property ODST_Decals_Menu_Start Hidden
		int Function Get()
			{ODST_Decals_Menu_Start [MSWP:01003690]}
			return 0x00003690
		EndFunction
	EndProperty
EndGroup


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
