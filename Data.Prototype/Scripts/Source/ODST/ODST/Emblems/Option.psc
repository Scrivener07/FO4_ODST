Scriptname ODST:Emblems:Option extends ODST:Type
import ODST:Log
import ODST:Papyrus

int OptionForeground
int OptionForegroundColorPrimary
int OptionForegroundColorSecondary
int OptionBackground
int OptionBackgroundColor


; Events
;---------------------------------------------

Event OnQuestInit()
	OptionForeground = Blank
	OptionForegroundColorPrimary = Blank
	OptionForegroundColorSecondary = Blank
	OptionBackground = Blank
	OptionBackgroundColor = Blank
EndEvent


; Methods
;---------------------------------------------

Function Apply()
	If (Foreground == Blank)
		OMOD.Primary = OMOD.PrimaryDefault
		OMOD.Secondary = OMOD.SecondaryDefault
	Else
		OMOD.Primary = OMOD.ToMaterialPath("Primary", ColorToString(ForegroundColorPrimary), ForegroundToString(Foreground))
		OMOD.Secondary = OMOD.ToMaterialPath("Secondary", ColorToString(ForegroundColorSecondary), ForegroundToString(Foreground))
	EndIf

	If (Background == Blank)
		OMOD.Background = OMOD.BackgroundDefault
	Else
		OMOD.Background = OMOD.ToMaterialPath("Background", ColorToString(BackgroundColor), BackgroundToString(Background))
	EndIf

	Preview.SetPrimary(OMOD.ToTexturePath("Primary", ForegroundToString(Foreground)), ColorToHex(ForegroundColorPrimary))
	Preview.SetSecondary(OMOD.ToTexturePath("Secondary", ForegroundToString(Foreground)), ColorToHex(ForegroundColorSecondary))
	Preview.SetBackground(OMOD.ToTexturePath("Background", BackgroundToString(Background)), ColorToHex(BackgroundColor))

	OMOD.Apply()
	WriteLine(self, "Apply", ToString())
EndFunction


; Functions
;---------------------------------------------

string Function ForegroundToString(int value)
	{Converts an option index into a foreground name.}
	If (value == Blank)
		return none
	ElseIf (value == Grenade)
		return "Grenade"
	ElseIf (value == Spartan)
		return "Spartan"
	ElseIf (value == SpartanHelmet)
		return "SpartanHelmet"
	Else
		WriteUnexpected(self, "ForegroundToString", "The value of "+value+" was out of range.")
		return none
	EndIf
EndFunction


string Function BackgroundToString(int value)
	{Converts an option index into a background name.}
	If (value == Blank)
		return none
	ElseIf (value == Circle)
		return "Circle"
	ElseIf (value == Display)
		return "Display"
	ElseIf (value == Shield)
		return "Shield"
	Else
		WriteUnexpected(self, "BackgroundToString", "The value of "+value+" was out of range.")
		return none
	EndIf
EndFunction


string Function ColorToString(int value)
	{Converts an option index into a colors name.}
	If (value == Black)
		return "Black"
	ElseIf (value == Blue)
		return "Blue"
	ElseIf (value == Cyan)
		return "Cyan"
	ElseIf (value == Green)
		return "Green"
	ElseIf (value == Orange)
		return "Orange"
	ElseIf (value == Purple)
		return "Purple"
	ElseIf (value == Red)
		return "Red"
	ElseIf (value == White)
		return "White"
	ElseIf (value == Yellow)
		return "Yellow"
	Else
		WriteUnexpected(self, "ColorToString", "The value of "+value+" was out of range.")
		return none
	EndIf
EndFunction

int Function ColorToHex(int value)
	{Converts an option index into a colors hex value.}
	If (value == Black)
		return 0x000000
	ElseIf (value == Blue)
		return 0x0000FF
	ElseIf (value == Cyan)
		return 0x00FFFF
	ElseIf (value == Green)
		return 0x008000
	ElseIf (value == Orange)
		return 0xFFA500
	ElseIf (value == Purple)
		return 0x800080
	ElseIf (value == Red)
		return 0xFF0000
	ElseIf (value == White)
		return 0xFFFFFF
	ElseIf (value == Yellow)
		return 0xFFFF00
	Else
		WriteUnexpected(self, "ColorToHex", "The value of "+value+" was out of range.")
		return 0xFFFFFF ; white
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	string sForeground = "Foreground:"+ForegroundToString(Foreground)+" ("+ColorToString(ForegroundColorPrimary)+"/"+ColorToString(ForegroundColorSecondary)+")"
	string sBackground = "Background:"+BackgroundToString(Background)+" ("+ColorToString(BackgroundColor)+")"
	return sForeground+", "+sBackground
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Emblems:OMOD Property OMOD Auto Const Mandatory
	ODST:Emblems:Preview Property Preview Auto Const Mandatory
EndGroup

Group Foreground
	int Property Blank = 0 AutoReadOnly ; blank
	int Property Grenade = 1 AutoReadOnly
	int Property Spartan = 2 AutoReadOnly
	int Property SpartanHelmet = 3 AutoReadOnly

	int Property Foreground Hidden
		Function Set(int value)
			OptionForeground = value
		EndFunction
		int Function Get()
			return OptionForeground
		EndFunction
	EndProperty

	int Property ForegroundColorPrimary Hidden
		Function Set(int value)
			OptionForegroundColorPrimary = value
		EndFunction
		int Function Get()
			return OptionForegroundColorPrimary
		EndFunction
	EndProperty

	int Property ForegroundColorSecondary Hidden
		Function Set(int value)
			OptionForegroundColorSecondary = value
		EndFunction
		int Function Get()
			return OptionForegroundColorSecondary
		EndFunction
	EndProperty
EndGroup

Group Background
	int Property Circle = 1 AutoReadOnly
	int Property Display = 2 AutoReadOnly
	int Property Shield = 3 AutoReadOnly

	int Property Background Hidden
		Function Set(int value)
			OptionBackground = value
		EndFunction
		int Function Get()
			return OptionBackground
		EndFunction
	EndProperty

	int Property BackgroundColor Hidden
		Function Set(int value)
			OptionBackgroundColor = value
		EndFunction
		int Function Get()
			return OptionBackgroundColor
		EndFunction
	EndProperty
EndGroup

Group Color
	int Property Black = 0 AutoReadOnly
	int Property Blue = 1 AutoReadOnly
	int Property Cyan = 2 AutoReadOnly
	int Property Green = 3 AutoReadOnly
	int Property Orange = 4 AutoReadOnly
	int Property Purple = 5 AutoReadOnly
	int Property Red = 6 AutoReadOnly
	int Property White = 7 AutoReadOnly
	int Property Yellow = 8 AutoReadOnly
EndGroup
