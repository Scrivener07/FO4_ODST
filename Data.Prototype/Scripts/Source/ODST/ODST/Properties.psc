Scriptname ODST:Properties extends Quest
{Provides common property values for ODST script objects.}

; Properties
;---------------------------------------------

Group Properties
	string Property MasterName Hidden
		{The master plugin name.}
		string Function Get()
			return "ProjectHelljumper"
		EndFunction
	EndProperty

	string Property MasterFile Hidden
		{The master plugin file.}
		string Function Get()
			return PluginName+".esm"
		EndFunction
	EndProperty

	string Property PluginName Hidden
		{The plugin name.}
		string Function Get()
			return "ODST"
		EndFunction
	EndProperty

	string Property PluginFile Hidden
		{The plugin file.}
		string Function Get()
			return PluginName+".esp"
		EndFunction
	EndProperty
EndGroup

Group MSWP
	int Property ODST_Emblems_Custom000 Hidden
		{ODST_Emblems_Custom000 [MSWP]}
		int Function Get()
			return 0x00000FA9
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom001 Hidden
		{ODST_Emblems_Custom001 [MSWP]}
		int Function Get()
			return 0x00000FAA
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom002 Hidden
		{ODST_Emblems_Custom002 [MSWP]}
		int Function Get()
			return 0x00000FAB
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom003 Hidden
		{ODST_Emblems_Custom003 [MSWP]}
		int Function Get()
			return 0x00000FAC
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom004 Hidden
		{ODST_Emblems_Custom004 [MSWP]}
		int Function Get()
			return 0x00000FAD
		EndFunction
	EndProperty

	int Property ODST_Emblems_Custom005 Hidden
		{ODST_Emblems_Custom005 [MSWP]}
		int Function Get()
			return 0x00000FAE
		EndFunction
	EndProperty
EndGroup
