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
	RemapBackground.Source = Folder+"\\Background\\Blank.BGEM"
	RemapBackground.Target = none
	Remapping.Add(RemapBackground)

	RemapPrimary = new MatSwap:RemapData
	RemapPrimary.Source = Folder+"\\Primary\\Blank.BGEM"
	RemapPrimary.Target = none
	Remapping.Add(RemapPrimary)

	RemapSecondary = new MatSwap:RemapData
	RemapSecondary.Source = Folder+"\\Secondary\\Blank.BGEM"
	RemapSecondary.Target = none
	Remapping.Add(RemapSecondary)

	RegisterForMenuOpenCloseEvent(PauseMenu)
	RegisterForExternalEvent("ODST_TestEvent", "OnODST")
EndEvent


; Events
;---------------------------------------------

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (!abOpening)
		UpdateSwap()
		ApplySwap()
		WriteLine(self, "OnMenuOpenCloseEvent(asMenuName="+asMenuName+", abOpening="+abOpening+")", "Hot swapped ODST emblem.")
	EndIf
EndEvent

Function OnODST()
	WriteLine(self, "OnODST", "We have the callback!")
EndFunction

; Methods
;---------------------------------------------



Function UpdateSwap()
	; TODO: The option index and colors are not matching in MCM!
	If (Settings.Decal == 0)
		RemapPrimary.Target = RemapPrimary.Source
		RemapSecondary.Target = RemapSecondary.Source

	ElseIf(Settings.Decal == 1)
		RemapPrimary.Target = Folder+"\\Primary\\"+Settings.ColorToString(Settings.PrimaryColor)+"\\Grenade.BGEM"
		RemapSecondary.Target = Folder+"\\Secondary\\"+Settings.ColorToString(Settings.SecondaryColor)+"\\Grenade.BGEM"

	ElseIf(Settings.Decal == 2)
		RemapPrimary.Target = Folder+"\\Primary\\"+Settings.ColorToString(Settings.PrimaryColor)+"\\Spartan.BGEM"
		RemapSecondary.Target = Folder+"\\Secondary\\"+Settings.ColorToString(Settings.SecondaryColor)+"\\Spartan.BGEM"

	ElseIf(Settings.Decal == 3)
		RemapPrimary.Target = Folder+"\\Primary\\"+Settings.ColorToString(Settings.PrimaryColor)+"\\SpartanHelmet.BGEM"
		RemapSecondary.Target = Folder+"\\Secondary\\"+Settings.ColorToString(Settings.SecondaryColor)+"\\SpartanHelmet.BGEM"
	EndIf

	If (Settings.Background == Settings.Cancel)
		RemapBackground.Target = RemapBackground.Source

	ElseIf(Settings.Background == Settings.Circle)
		RemapBackground.Target = Folder+"\\Background\\"+Settings.ColorToString(Settings.BackgroundColor)+"\\Circle.BGEM"

	ElseIf(Settings.Background == Settings.Display)
		RemapBackground.Target = Folder+"\\Background\\"+Settings.ColorToString(Settings.BackgroundColor)+"\\Display.BGEM"

	ElseIf(Settings.Background == Settings.Shield)
		RemapBackground.Target = Folder+"\\Background\\"+Settings.ColorToString(Settings.BackgroundColor)+"\\Shield.BGEM"
	EndIf
EndFunction


Function ApplySwap()
	ODST_Decals_Menu_Start.SetRemapData(Remapping)
	Player.ApplyMaterialSwap(ODST_Decals_Menu_Start)
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
	ODST:Settings Property Settings Auto Const Mandatory
EndGroup
