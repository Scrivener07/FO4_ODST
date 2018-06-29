Scriptname ODST:Emblems extends ODST:Type
import ODST:Log
import ODST:Papyrus

Actor Player
MatSwap ODST_Decals_Menu_Start
;---------------------------------------------
MatSwap:RemapData[] Remapping
MatSwap:RemapData RemapBackground
MatSwap:RemapData RemapPrimary
MatSwap:RemapData RemapSecondary

string Folder = "ProjectHelljumper\\H3ODST\\1Decals\\Decals" const

;---------------------------------------------

string PauseMenu = "PauseMenu" const


; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	ODST_Decals_Menu_Start = GetExternal(Properties.PluginFile, Properties.ODST_Decals_Menu_Start) as MatSwap

	Remapping = new MatSwap:RemapData[0]

	RemapBackground = new MatSwap:RemapData
	RemapBackground.Source = Folder+"\\Background\\Blank.bgem"
	RemapBackground.Target = none
	Remapping.Add(RemapBackground)

	RemapPrimary = new MatSwap:RemapData
	RemapPrimary.Source = Folder+"\\Primary\\Blank.bgem"
	RemapPrimary.Target = none
	Remapping.Add(RemapPrimary)

	RemapSecondary = new MatSwap:RemapData
	RemapSecondary.Source = Folder+"\\Secondary\\Blank.bgem"
	RemapSecondary.Target = none
	Remapping.Add(RemapSecondary)

	RegisterForMenuOpenCloseEvent(PauseMenu)
	RegisterForExternalEvent("ODST_TestEvent", "OnODST")
	WriteLine(self, "OnQuestInit", "Started emblems script.")
EndEvent


; Events
;---------------------------------------------

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	WriteLine(self, "OnMenuOpenCloseEvent", "asMenuName="+asMenuName+", abOpening="+abOpening+"")
	If (!abOpening)
		UpdateSwap()
		ApplySwap()
	EndIf
EndEvent


Function OnODST()
	WriteLine(self, "OnODST", "We have the callback!")
EndFunction


; Methods
;---------------------------------------------

Function UpdateSwap()
	; TODO: The option index and colors are not matching in MCM!

	If (Settings.Decal == Settings.Cancel)
		RemapPrimary.Target = RemapPrimary.Source
		RemapSecondary.Target = RemapSecondary.Source
	Else
		RemapPrimary.Target = GetPathFor("Primary", Settings.ColorToString(Settings.PrimaryColor), Settings.Shape1ToString(Settings.Decal))
		RemapSecondary.Target = GetPathFor("Secondary", Settings.ColorToString(Settings.SecondaryColor), Settings.Shape1ToString(Settings.Decal))
	EndIf

	If (Settings.Background == Settings.Cancel)
		RemapBackground.Target = RemapBackground.Source
	Else
		RemapBackground.Target = GetPathFor("Background", Settings.ColorToString(Settings.BackgroundColor), Settings.Shape2ToString(Settings.Background))
	EndIf
EndFunction


Function ApplySwap()
	ODST_Decals_Menu_Start.SetRemapData(Remapping)
	Player.ApplyMaterialSwap(ODST_Decals_Menu_Start)
EndFunction


; Functions
;---------------------------------------------

string Function GetPathFor(string layer, string color, string decal)
	If (layer && color && decal)
		return Folder+"\\"+layer+"\\"+color+"\\"+decal+".bgem"
	Else
		WriteUnexpected(self, "GetPathFor", "Parameters cannot be none.")
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
	ODST:Settings Property Settings Auto Const Mandatory
EndGroup
