Scriptname ODST:Emblems:Editor extends ODST:Type
{Provides capabilities for the MCM emblem editor.}
import ODST
import ODST:Log
import ODST:Papyrus

Emblems:Preset[] Presets
string SettingName_Selected = "iEmblem_Selected" const


; Events
;---------------------------------------------

Event OnQuestInit()
	{The object has been initialized.}
	WriteLine(self, "OnQuestInit")

	Presets = new Emblems:Preset[0]
	Presets.Add(Preset001)
	Presets.Add(Preset002)
	Presets.Add(Preset003)
	Presets.Add(Preset004)
	Presets.Add(Preset005)

	Preset001.Initialize(0, "Emblem001", Properties.ODST_Emblems_Custom001)
	Preset002.Initialize(1, "Emblem002", Properties.ODST_Emblems_Custom002)
	Preset003.Initialize(2, "Emblem003", Properties.ODST_Emblems_Custom003)
	Preset004.Initialize(3, "Emblem004", Properties.ODST_Emblems_Custom004)
	Preset005.Initialize(4, "Emblem005", Properties.ODST_Emblems_Custom005)

	ConfigurationMenu.RegisterForMenuStateEvent(self)
	ConfigurationMenu.RegisterForOptionEvent(self)
	RegisterForGameReload(self)

	OnGameReload()
EndEvent


Event OnGameReload()
	WriteLine(self, "OnGameReload")

	If (Deserialize() > Invalid)
		Update()
		UseMaterial(self, Game.GetPlayer())
	EndIf
EndEvent


Event ODST:MCM:Menu.OnMenuState(MCM:Menu sender, var[] arguments)
	{An MCM menu state change event has been received.}
	If (arguments)
		MCM:Menu:MenuStateEventArgs e = sender.GetMenuStateEventArgs(arguments)
		WriteLine(self, "ODST:MCM:Menu.OnMenuState", e)
		If (e.MenuState == sender.MenuOpened)
			Deserialize()
			sender.RefreshMenu()
		EndIf
	Else
		WriteUnexpectedValue(self, "ODST:MCM:Menu.OnMenuState", "arguments", "The arguments are none or empty.")
	EndIf
EndEvent


Event ODST:MCM:Menu.OnOption(MCM:Menu sender, var[] arguments)
	{An MCM option change event has been received.}
	If (arguments)
		MCM:Menu:OptionEventArgs e = sender.GetOptionEventArgs(arguments)

		If (e.Identifier == sender.GetIdentifier(SettingName_Selected))
			int select = Deserialize()
			Preview.Update(self, Presets[select])
			Update()
			sender.RefreshMenu()
		Else
			Emblems:Preset preset = GetPreset(Selected)
			preset.SetValue(ConfigurationMenu, e)
			Preview.Update(self, preset)
			Update()
			sender.RefreshMenu()
		EndIf
	Else
		WriteUnexpectedValue(self, "ODST:MCM:Menu.OnOption", "arguments", "The arguments are none or empty.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

int Function Deserialize()
	{Deserialize mod settings for each preset. Returns the index of the selected preset.}
	Selected = ConfigurationMenu.GetModSettingFor(SettingName_Selected)
	int select = Invalid
	int index = 0
	While (index < Presets.Length)
		Emblems:Preset preset = Presets[index]
		preset.Condition = (Selected == preset.Option)
		preset.Deserialize(ConfigurationMenu)
		If (preset.Condition)
			select = index
		EndIf
		index += 1
	EndWhile

	WriteLine(self, "Deserialize:"+ToString())
	return select
EndFunction


Function Update()
	{Update the emblem material for each preset.}
	int index = 0
	While (index < Presets.Length)
		Emblems:Preset preset = Presets[index]
		preset.Condition = (Selected == preset.Option)
		preset.Remap(self)
		index += 1
	EndWhile
	WriteLine(self, "Update:"+ToString())
EndFunction


Emblems:Preset Function GetPreset(int option)
	{Returns the emblem preset for the given option.}
	int index = 0
	While (index < Presets.Length)
		Emblems:Preset preset = Presets[index]
		If (option == preset.Option)
			return preset
		EndIf
		index += 1
	EndWhile
	WriteUnexpectedValue(self, "GetPreset", "option", "The value "+option+" is unhandled.")
	return none
EndFunction


; Functions
;---------------------------------------------

string Function ToMaterialPath(string layerFolder, string colorFolder, string decalFolder)
	{Concats a material path from the given arguments.}
	If (layerFolder)
		If (colorFolder)
			If (decalFolder)
				return Folder+"\\"+layerFolder+"\\"+colorFolder+"\\"+decalFolder+".bgem"
			Else
				WriteUnexpectedValue(self, "ToMaterialPath", "decalFolder", "The parameter cannot be none.")
				return ""
			EndIf
		Else
			WriteUnexpectedValue(self, "ToMaterialPath", "colorFolder", "The parameter cannot be none.")
			return ""
		EndIf
	Else
		WriteUnexpectedValue(self, "ToMaterialPath", "layerFolder", "The parameter cannot be none.")
		return ""
	EndIf
EndFunction


string Function ToTexturePath(string layerFolder, string decalFolder)
	{Concats a texture path from the given arguments.}
	If (layerFolder)
		If (decalFolder)
			If (decalFolder == "Blank")
				return Folder+"\\"+decalFolder+".dds"
			Else
				return Folder+"\\"+layerFolder+"\\"+decalFolder+".dds"
			EndIf
		Else
			WriteUnexpectedValue(self, "ToTexturePath", "decalFolder", "The parameter cannot be none.")
			return ""
		EndIf
	Else
		WriteUnexpectedValue(self, "ToTexturePath", "layerFolder", "The parameter cannot be none.")
		return ""
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return "Selected:"+Selected
EndFunction


; Globals
;---------------------------------------------

bool Function UseMaterial(Emblems:Editor editor, Actor user) Global
	If (user)
		int BipedBody = 3 ;const
		ObjectMod[] omods = user.GetWornItemMods(BipedBody)
		If (omods)
			int index = 0
			While (index < omods.Length)
				ObjectMod omod = omods[index]
				If (omod.GetLooseMod() == editor.miscmod_mod_ODST_Emblems)
					If (omod)
						MatSwap material = GetMaterial(omod)
						If (material)
							user.SetMaterialSwap(Material)
							If (user.ApplyMaterialSwap(material))
								WriteLine("[ODST:Emblems:Editor]", "UseMaterial", "Material remapping was successful. "+material.GetRemapData())
								return true
							Else
								WriteUnexpected("[ODST:Emblems:Editor]", "UseMaterial", "No source/target pairs succeeded in swapping. "+material.GetRemapData())
								return false
							EndIf
						Else
							WriteUnexpectedValue("[ODST:Emblems:Editor]", "UseMaterial", "material", "The value cannot be none.")
							return false
						EndIf
					Else
						WriteUnexpectedValue("[ODST:Emblems:Editor]", "UseMaterial", "omod", "The value cannot be none.")
						return false
					EndIf
				EndIf
				index += 1
			EndWhile
			return false
		Else
			WriteUnexpectedValue("[ODST:Emblems:Editor]", "UseMaterial", "omods", "The array cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("[ODST:Emblems:Editor]", "UseMaterial", "user", "The argument Actor cannot be none.")
		return false
	EndIf
EndFunction


MatSwap Function GetMaterial(ObjectMod omod) Global
	{Gets the material that is applied by an object mod.}
	ObjectMod:PropertyModifier[] modifiers = omod.GetPropertyModifiers()
	If (modifiers)
		int index = 0
		While (index < modifiers.Length)
			MatSwap material = modifiers[index].Object as MatSwap
			If (material)
				WriteLine("[ODST:Emblems:Editor]", "GetMaterial", "omod:"+omod+", material:"+material)
				return material
			EndIf
			index += 1
		EndWhile
	EndIf
	return none
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
	{Provides common property values for ODST script objects.}

	MCM:Menu Property ConfigurationMenu Auto Const Mandatory
	{Provides methods for ODST to interact with the MCM library.}

	MiscObject Property miscmod_mod_ODST_Emblems Auto Const Mandatory
	{The default loose mod for emblem object mods.}
EndGroup

Group Emblems
	Emblems:Color Property Color Auto Const Mandatory
	{Provides information about emblem colors.}
	Emblems:Symbol Property Symbol Auto Const Mandatory
	{Provides information about emblem symbols.}
	Emblems:Preview Property Preview Auto Const Mandatory
	{Provides capabilities to display an emblem preset within the user interface.}
EndGroup

Group Presets
	int Property Selected = -1 Auto Hidden
	{@`config.json` The currently selected preset to edit. @`config.json`}

	Emblems:Preset Property Preset001 Auto Const Mandatory
	{The data object for preset 1}
	Emblems:Preset Property Preset002 Auto Const Mandatory
	{The data object for preset 2}
	Emblems:Preset Property Preset003 Auto Const Mandatory
	{The data object for preset 3}
	Emblems:Preset Property Preset004 Auto Const Mandatory
	{The data object for preset 4}
	Emblems:Preset Property Preset005 Auto Const Mandatory
	{The data object for preset 5}
EndGroup


Group Files
	string Property Folder = "ProjectHelljumper\\H3ODST\\1Decals\\Decals" AutoReadOnly
	{The default directory for decal materials.}

	string Property PrimaryLayer = "Primary" AutoReadOnly
	{An emblems layer is a folder name used to build a file path.}
	string Property SecondaryLayer = "Secondary" AutoReadOnly
	{An emblems layer is a folder name used to build a file path.}
	string Property BackgroundLayer = "Background" AutoReadOnly
	{An emblems layer is a folder name used to build a file path.}

	string Property PrimaryDefault Hidden
		{The default primary material file.}
		string Function Get()
			return Folder+"\\Primary\\Blank.bgem"
		EndFunction
	EndProperty

	string Property SecondaryDefault Hidden
		{The default secondary material file.}
		string Function Get()
			return Folder+"\\Secondary\\Blank.bgem"
		EndFunction
	EndProperty

	string Property BackgroundDefault Hidden
		{The default background material file.}
		string Function Get()
			return Folder+"\\Background\\Blank.bgem"
		EndFunction
	EndProperty
EndGroup
