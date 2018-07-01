Scriptname ODST:Emblems:OMOD extends ODST:Type
import ODST:Log
import ODST:Papyrus

Actor Player
MatSwap ODST_Decals_Menu_Start
;---------------------------------------------
MatSwap:RemapData[] Remapping
MatSwap:RemapData RemapBackground
MatSwap:RemapData RemapPrimary
MatSwap:RemapData RemapSecondary


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
EndGroup

Group Files
	string Property Folder = "ProjectHelljumper\\H3ODST\\1Decals\\Decals" AutoReadOnly

	string Property Primary Hidden
		string Function Get()
			return RemapPrimary.Target
		EndFunction
		Function Set(string value)
			RemapPrimary.Target = value
			WriteLine(self, "Primary.Set", value)
		EndFunction
	EndProperty

	string Property PrimaryDefault Hidden
		string Function Get()
			return Folder+"\\Primary\\Blank.bgem"
		EndFunction
	EndProperty

	string Property Secondary Hidden
		string Function Get()
			return RemapSecondary.Target
		EndFunction
		Function Set(string value)
			RemapSecondary.Target = value
			WriteLine(self, "Secondary.Set", value)
		EndFunction
	EndProperty

	string Property SecondaryDefault Hidden
		string Function Get()
			return Folder+"\\Secondary\\Blank.bgem"
		EndFunction
	EndProperty

	string Property Background Hidden
		string Function Get()
			return RemapBackground.Target
		EndFunction
		Function Set(string value)
			RemapBackground.Target = value
			WriteLine(self, "Background.Set", value)
		EndFunction
	EndProperty

	string Property BackgroundDefault Hidden
		string Function Get()
			return Folder+"\\Background\\Blank.bgem"
		EndFunction
	EndProperty
EndGroup


; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	ODST_Decals_Menu_Start = GetExternal(Properties.PluginFile, Properties.ODST_Decals_Menu_Start) as MatSwap

	Remapping = new MatSwap:RemapData[0]

	RemapPrimary = new MatSwap:RemapData
	RemapPrimary.Source = PrimaryDefault
	RemapPrimary.Target = PrimaryDefault
	Remapping.Add(RemapPrimary)

	RemapSecondary = new MatSwap:RemapData
	RemapSecondary.Source = SecondaryDefault
	RemapSecondary.Target = SecondaryDefault
	Remapping.Add(RemapSecondary)

	RemapBackground = new MatSwap:RemapData
	RemapBackground.Source = BackgroundDefault
	RemapBackground.Target = BackgroundDefault
	Remapping.Add(RemapBackground)

	WriteLine(self, "OnQuestInit", "Started emblems script.")
EndEvent


; Methods
;---------------------------------------------

Function Apply()
	ODST_Decals_Menu_Start.SetRemapData(Remapping)
	Player.ApplyMaterialSwap(ODST_Decals_Menu_Start)
	WriteLine(self, "Apply", ODST_Decals_Menu_Start.GetName()+", "+ODST_Decals_Menu_Start.GetDescription())
EndFunction


string Function ToMaterialPath(string layer, string color, string decal)
	If (layer && color && decal)
		return Folder+"\\"+layer+"\\"+color+"\\"+decal+".bgem"
	Else
		WriteUnexpected(self, "ToMaterialPath", "Parameters cannot be none or empty.")
		return none
	EndIf
EndFunction


string Function ToTexturePath(string layer, string decal)
	If (layer && decal)
		If (layer == "Primary")
			return Folder+"\\"+layer+"\\"+decal+"1.dds"
		ElseIf (layer == "Secondary")
			return Folder+"\\"+layer+"\\"+decal+"2.dds"
		ElseIf (layer == "Background")
			return Folder+"\\"+layer+"\\"+decal+".dds"
		Else
			WriteUnexpected(self, "ToTexturePath", "The "+layer+" layer was unhandled.")
			return none
		EndIf
	Else
		WriteUnexpected(self, "ToTexturePath", "Parameters cannot be none or empty.")
		return none
	EndIf
EndFunction
