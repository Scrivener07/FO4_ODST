ScriptName ODST:Emblems:Symbol extends ODST:Type
{Provides information about emblem symbols.}
import ODST:Papyrus
import ODST:Log

; Functions
;---------------------------------------------

string Function ForegroundToFolder(int option)
	{Converts an option index into a foreground file name.}
	If (option == Blank)
		return ""
	ElseIf (option == Decal117)
		return "117"
	ElseIf (option == ActiveRooster)
		return "ActiveRooster"
	ElseIf (option == Arrowhead)
		return "Arrowhead"
	ElseIf (option == Assassin)
		return "Assassin"
	ElseIf (option == Bulletproof)
		return "Bulletproof"
	ElseIf (option == Cone)
		return "Cone"
	ElseIf (option == Covenant)
		return "Covenant"
	ElseIf (option == CupOfDeath)
		return "CupOfDeath"
	ElseIf (option == Grenade)
		return "Grenade"
	ElseIf (option == Guilty)
		return "Guilty"
	ElseIf (option == Headshot)
		return "Headshot"
	ElseIf (option == Infected)
		return "Infected"
	ElseIf (option == LASO)
		return "LASO"
	ElseIf (option == Mjolnir)
		return "Mjolnir"
	ElseIf (option == Noble)
		return "Noble"
	ElseIf (option == ONI)
		return "ONI"
	ElseIf (option == OnYourShield)
		return "OnYourShield"
	ElseIf (option == Planetary)
		return "Planetary"
	ElseIf (option == Seven)
		return "Seven"
	ElseIf (option == Sinner)
		return "Sinner"
	ElseIf (option == Spartan)
		return "Spartan"
	ElseIf (option == SpartanHelmet)
		return "SpartanHelmet"
	ElseIf (option == Splatter)
		return "Splatter"
	ElseIf (option == Superintendent)
		return "Superintendent"
	ElseIf (option == Unicorn)
		return "Unicorn"
	ElseIf (option == Valkyrie)
		return "Valkyrie"
	ElseIf (option == Wolf)
		return "Wolf"
	ElseIf (option == YingYang)
		return "YingYang"
	Else
		WriteUnexpected(self, "ForegroundToFolder", "The option of "+option+" was out of range.")
		return ""
	EndIf
EndFunction


string Function BackgroundToFolder(int option)
	{Converts an option index into a background file name.}
	If (option == Blank)
		return ""
	ElseIf (option == FourDiamonds)
		return "4Diamonds"
	ElseIf (option == Asterisk)
		return "Asterisk"
	ElseIf (option == BallOFire)
		return "BallOFire"
	ElseIf (option == BlankOne)
		return "BlankOne"
	ElseIf (option == Cancel)
		return "Cancel"
	ElseIf (option == Chevron)
		return "Chevron"
	ElseIf (option == Circle)
		return "Circle"
	ElseIf (option == Cog)
		return "Cog"
	ElseIf (option == CowboyHat)
		return "CowboyHat"
	ElseIf (option == CrissCross)
		return "CrissCross"
	ElseIf (option == Crown)
		return "Crown"
	ElseIf (option == Diamond)
		return "Diamond"
	ElseIf (option == Display)
		return "Display"
	ElseIf (option == Hexagon)
		return "Hexagon"
	ElseIf (option == HorizontalStripes)
		return "HorizontalStripes"
	ElseIf (option == Limited)
		return "Limited"
	ElseIf (option == Power)
		return "Power"
	ElseIf (option == Shield)
		return "Shield"
	ElseIf (option == Star)
		return "Star"
	ElseIf (option == Structure)
		return "Structure"
	ElseIf (option == Vortex)
		return "Vortex"
	Else
		WriteUnexpected(self, "BackgroundToFolder", "The option of "+option+" was out of range.")
		return ""
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	int Property Blank = 0 AutoReadOnly
EndGroup

Group Foreground
	int Property Decal117 = 1 AutoReadOnly
	int Property ActiveRooster = 2 AutoReadOnly
	int Property Arrowhead = 3 AutoReadOnly
	int Property Assassin = 4 AutoReadOnly
	int Property Bulletproof = 5 AutoReadOnly
	int Property Cone = 6 AutoReadOnly
	int Property Covenant = 7 AutoReadOnly
	int Property CupOfDeath = 8 AutoReadOnly
	int Property Grenade = 9 AutoReadOnly
	int Property Guilty = 10 AutoReadOnly
	int Property Headshot = 11 AutoReadOnly
	int Property Infected = 12 AutoReadOnly
	int Property LASO = 13 AutoReadOnly
	int Property Mjolnir = 14 AutoReadOnly
	int Property Noble = 15 AutoReadOnly
	int Property ONI = 16 AutoReadOnly
	int Property OnYourShield = 17 AutoReadOnly
	int Property Planetary = 18 AutoReadOnly
	int Property Seven = 19 AutoReadOnly
	int Property Sinner = 20 AutoReadOnly
	int Property Spartan = 21 AutoReadOnly
	int Property SpartanHelmet = 22 AutoReadOnly
	int Property Splatter = 23 AutoReadOnly
	int Property Superintendent = 24 AutoReadOnly
	int Property Unicorn = 25 AutoReadOnly
	int Property Valkyrie = 26 AutoReadOnly
	int Property Wolf = 27 AutoReadOnly
	int Property YingYang = 28 AutoReadOnly
EndGroup

Group Background
	int Property FourDiamonds = 1 AutoReadOnly
	int Property Asterisk = 2 AutoReadOnly
	int Property BallOFire = 3 AutoReadOnly
	int Property BlankOne = 4 AutoReadOnly
	int Property Cancel = 5 AutoReadOnly
	int Property Chevron = 6 AutoReadOnly
	int Property Circle = 7 AutoReadOnly
	int Property Cog = 8 AutoReadOnly
	int Property CowboyHat = 9 AutoReadOnly
	int Property CrissCross = 10 AutoReadOnly
	int Property Crown = 11 AutoReadOnly
	int Property Diamond = 12 AutoReadOnly
	int Property Display = 13 AutoReadOnly
	int Property Hexagon = 14 AutoReadOnly
	int Property HorizontalStripes = 15 AutoReadOnly
	int Property Limited = 16 AutoReadOnly
	int Property Power = 17 AutoReadOnly
	int Property Shield = 18 AutoReadOnly
	int Property Star = 19 AutoReadOnly
	int Property Structure = 20 AutoReadOnly
	int Property Vortex = 21 AutoReadOnly
EndGroup
