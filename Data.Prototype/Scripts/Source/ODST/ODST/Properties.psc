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

Group ARMO
	int Property Armor_H3_ODST Hidden
		int Function Get()
			{Armor_H3_ODST "H3 ODST Armor" [ARMO:00006ADA]}
			return 0x00006ADA
		EndFunction
	EndProperty

	int Property Armor_H3_ODST_Helmet  Hidden
		int Function Get()
			{Armor_H3_ODST_Helmet "H3 ODST Helmet" [ARMO:00006ADB]}
			return 0x00006ADB
		EndFunction
	EndProperty

	int Property Armor_H3_ODST_HelmetHaunted  Hidden
		int Function Get()
			{Armor_H3_ODST_HelmetHaunted "Haunted Helmet" [ARMO:00006AFF]}
			return 0x00006AFF
		EndFunction
	EndProperty

	int Property Armor_ODST Hidden
		int Function Get()
			{Armor_ODST "ODST Armor" [ARMO:00000F9B]}
			return 0x00000F9B
		EndFunction
	EndProperty

	int Property Armor_ODST_Helmet Hidden
		int Function Get()
			{Armor_ODST_Helmet "ODST Helmet" [ARMO:00001735]}
			return 0x00001735
		EndFunction
	EndProperty

	int Property Armor_ODST_Recon_Helmet Hidden
		int Function Get()
			{Armor_ODST_Recon_Helmet "S-1/ONI Recon Helmet" [ARMO:0001729C]}
			return 0x0001729C
		EndFunction
	EndProperty
EndGroup

Group OMOD
	int Property mod_ODST_Emblems_Custom001 Hidden
		int Function Get()
			{mod_ODST_Emblems_Custom001 "Decal - Blank" [OMOD:00003691]}
			return 0x00003691
		EndFunction
	EndProperty
EndGroup

Group MSWP
	int Property ODST_Emblems_Custom000 Hidden
		int Function Get()
			{ODST_Emblems_Custom000 [MSWP:00004D6A]}
			return 0x00004D6A
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom001 Hidden
		int Function Get()
			{ODST_Emblems_Custom001 [MSWP:00003690]}
			return 0x00003690
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom002 Hidden
		int Function Get()
			{ODST_Emblems_Custom002 [MSWP:00004D6E]}
			return 0x00004D6E
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom003 Hidden
		int Function Get()
			{ODST_Emblems_Custom003 [MSWP:00004D71]}
			return 0x00004D71
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom004 Hidden
		int Function Get()
			{ODST_Emblems_Custom004 [MSWP:00004D74]}
			return 0x00004D74
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom005 Hidden
		int Function Get()
			{ODST_Emblems_Custom005 [MSWP:00004D77]}
			return 0x00004D77
		EndFunction
	EndProperty
EndGroup
