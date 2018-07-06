Scriptname ODST:Emblems:Material extends ODST:Type
import ODST:Log
import ODST:Papyrus
import ODST:Emblems

Actor Player
MatSwap Swap ; The "focused" material swap.
;---------------------------------------------
MatSwap:RemapData[] Remapping
MatSwap:RemapData RemapBackground
MatSwap:RemapData RemapPrimary
MatSwap:RemapData RemapSecondary
;---------------------------------------------
MatSwap ODST_Emblems_Custom000
MatSwap ODST_Emblems_Custom001
MatSwap ODST_Emblems_Custom002
MatSwap ODST_Emblems_Custom003
MatSwap ODST_Emblems_Custom004
MatSwap ODST_Emblems_Custom005


; Events
;---------------------------------------------

Event OnQuestInit()
	WriteLine(self, "OnQuestInit")
	Player = Game.GetPlayer()
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

	ODST_Emblems_Custom000 = GetExternal(Properties.PluginFile, Properties.ODST_Emblems_Custom000) as MatSwap
	ODST_Emblems_Custom001 = GetExternal(Properties.PluginFile, Properties.ODST_Emblems_Custom001) as MatSwap
	ODST_Emblems_Custom002 = GetExternal(Properties.PluginFile, Properties.ODST_Emblems_Custom002) as MatSwap
	ODST_Emblems_Custom003 = GetExternal(Properties.PluginFile, Properties.ODST_Emblems_Custom003) as MatSwap
	ODST_Emblems_Custom004 = GetExternal(Properties.PluginFile, Properties.ODST_Emblems_Custom004) as MatSwap
	ODST_Emblems_Custom005 = GetExternal(Properties.PluginFile, Properties.ODST_Emblems_Custom005) as MatSwap

	Option.RegisterForChangedEvent(self)
EndEvent


Event ODST:Emblems:Option.OnChanged(ODST:Emblems:Option sender, var[] arguments)
	If (arguments)
		Option:ChangedEventArgs e = sender.GetChangedEventArgs(arguments)
		WriteLine(self, "ODST:Emblems:Option.OnChanged", e)

		If (e.Foreground == sender.Blank)
			Primary = PrimaryDefault
			Secondary = SecondaryDefault
		Else
			Primary = ToMaterialPath("Primary", e.ForegroundColorPrimary, e.Foreground)
			Secondary = ToMaterialPath("Secondary", e.ForegroundColorSecondary, e.Foreground)
		EndIf

		If (e.Background == sender.Blank)
			Background = BackgroundDefault
		Else
			Background = ToMaterialPath("Background", e.BackgroundColor, e.Background)
		EndIf
	Else
		WriteUnexpectedValue(self, "ODST:Emblems:Option.OnChanged", "arguments", "The arguments are none or empty.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

Function SetSwap(MatSwap value)
	If (value)
		Swap = value
	Else
		WriteUnexpected(self, "SetSwap", "The parameter cannot be none.")
	EndIf
EndFunction

Function Apply()
	If (Swap)
		Swap.SetRemapData(Remapping)
		Player.ApplyMaterialSwap(Swap)
		WriteLine(self, "Apply")
	Else
		WriteUnexpected(self, "Apply", "The material cannot be none.")
	EndIf
EndFunction


; Functions
;---------------------------------------------

MatSwap Function GetSwapFor(ObjectMod value)
	If (value)
		If (value == mod_ODST_Emblems_Custom000)
			return ODST_Emblems_Custom000
		ElseIf (value == mod_ODST_Emblems_Custom001)
			return ODST_Emblems_Custom001
		ElseIf (value == mod_ODST_Emblems_Custom002)
			return ODST_Emblems_Custom002
		ElseIf (value == mod_ODST_Emblems_Custom003)
			return ODST_Emblems_Custom003
		ElseIf (value == mod_ODST_Emblems_Custom004)
			return ODST_Emblems_Custom004
		ElseIf (value == mod_ODST_Emblems_Custom005)
			return ODST_Emblems_Custom005
		Else
			WriteUnexpected(self, "GetSwapFor", "The value "+value+" is unhandled.")
			return none
		EndIf
	Else
		WriteUnexpected(self, "GetSwapFor", "The object mod is none.")
		return none
	EndIf
EndFunction


string Function ToMaterialPath(string layer, string color, string decal)
	If (layer)
		If (color)
			If (decal)
				return Folder+"\\"+layer+"\\"+color+"\\"+decal+".bgem"
			Else
				WriteUnexpected(self, "ToMaterialPath", "The 'decal' parameter cannot be none.")
				return none
			EndIf
		Else
			WriteUnexpected(self, "ToMaterialPath", "The 'color' parameter cannot be none.")
			return none
		EndIf
	Else
		WriteUnexpected(self, "ToMaterialPath", "The 'layer' parameter cannot be none.")
		return none
	EndIf
EndFunction


string Function ToTexturePath(string layer, string decal)
	If (layer)
		If (decal)
			If (decal == "Blank")
				return Folder+"\\"+decal+".dds"
			Else
				return Folder+"\\"+layer+"\\"+decal+".dds"
			EndIf
		Else
			WriteUnexpected(self, "ToTexturePath", "The 'decal' parameter cannot be none.")
			return none
		EndIf
	Else
		WriteUnexpected(self, "ToTexturePath", "The 'layer' parameter cannot be none.")
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
	ODST:Emblems:Option Property Option Auto Const Mandatory
EndGroup

Group ObjectMod
	ObjectMod Property mod_ODST_Emblems_Custom000 Auto Const Mandatory
	ObjectMod Property mod_ODST_Emblems_Custom001 Auto Const Mandatory
	ObjectMod Property mod_ODST_Emblems_Custom002 Auto Const Mandatory
	ObjectMod Property mod_ODST_Emblems_Custom003 Auto Const Mandatory
	ObjectMod Property mod_ODST_Emblems_Custom004 Auto Const Mandatory
	ObjectMod Property mod_ODST_Emblems_Custom005 Auto Const Mandatory
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
