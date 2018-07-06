Scriptname ODST:Emblems:Option extends ODST:Type
import ODST:Log
import ODST:Papyrus
;import ODST:Settings

int OptionForeground
int OptionForegroundColorPrimary
int OptionForegroundColorSecondary
int OptionBackground
int OptionBackgroundColor
;---------------------------------------------
string iEmblem_Selected = "iEmblem_Selected:Main" const
string emblem_foreground = "iEmblem_Foreground:Main" const
string emblem_foreground_color_primary = "iEmblem_Foreground_Color_Primary:Main" const
string emblem_foreground_color_secondary = "iEmblem_Foreground_Color_Secondary:Main" const
string emblem_background = "iEmblem_Background:Main" const
string emblem_background_color = "iEmblem_Background_Color:Main" const

; When menu opens, update from settings.ini
; When menu closes, store changes to settings.ini


; Events
;---------------------------------------------

Event OnQuestInit()
	OptionForeground = Blank
	OptionForegroundColorPrimary = Blank
	OptionForegroundColorSecondary = Blank
	OptionBackground = Blank
	OptionBackgroundColor = Blank
	Settings.RegisterForMenuEvent(self)
	Settings.RegisterForChangedEvent(self)
EndEvent


Event ODST:Settings.OnMenu(ODST:Settings sender, var[] arguments)
	If (arguments)
		int e = sender.GetMenuEventArgs(arguments)
		If (e == sender.MenuOpened)
			WriteLine(self, "ODST:Settings.OnMenu", "Opened")
			UpdateSettings()
		ElseIf (e == sender.MenuClosed)
			WriteLine(self, "ODST:Settings.OnMenu", "Closed")
			ApplyChanges()
		EndIf
	Else
		WriteUnexpectedValue(self, "ODST:Settings.OnMenu", "arguments", "The arguments are none or empty.")
	EndIf
EndEvent


Event ODST:Settings.OnChanged(ODST:Settings sender, var[] arguments)
	If (arguments)
		ODST:Settings:ChangedEventArgs e = sender.GetChangedEventArgs(arguments)
		WriteLine(self, "ODST:Settings.OnChanged", e)
		If (e.ModName == Properties.PluginName)
			self.Foreground = MCM.GetModSettingInt(e.ModName, emblem_foreground)
			self.ForegroundColorPrimary = MCM.GetModSettingInt(e.ModName, emblem_foreground_color_primary)
			self.ForegroundColorSecondary = MCM.GetModSettingInt(e.ModName, emblem_foreground_color_secondary)
			self.Background = MCM.GetModSettingInt(e.ModName, emblem_background)
			self.BackgroundColor = MCM.GetModSettingInt(e.ModName, emblem_background_color)

			MCM.RefreshMenu()

			self.ApplyChanges()

			WriteMessage(self, "ODST:Settings.OnChanged", "e.Identifier:"+e.Identifier)
		Else
			WriteUnexpected(self, "ODST:Settings.OnChanged", "The "+e.ModName+" mod name was unhandled.")
		EndIf
	Else
		WriteUnexpectedValue(self, "ODST:Settings.OnChanged", "arguments", "The arguments are none or empty.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

Function UpdateSettings()
	WriteLine(self, "UpdateSettings")
	self.Foreground = MCM.GetModSettingInt(Properties.PluginName, emblem_foreground)
	self.ForegroundColorPrimary = MCM.GetModSettingInt(Properties.PluginName, emblem_foreground_color_primary)
	self.ForegroundColorSecondary = MCM.GetModSettingInt(Properties.PluginName, emblem_foreground_color_secondary)
	self.Background = MCM.GetModSettingInt(Properties.PluginName, emblem_background)
	self.BackgroundColor = MCM.GetModSettingInt(Properties.PluginName, emblem_background_color)
EndFunction


Function ApplyChanges()
	{Updates the material file paths.}
	WriteLine(self, "ApplyChanges", "Updating the material file paths.")

	ChangedEventArgs e = new ChangedEventArgs
	e.Preset = 1
	e.Foreground = ForegroundToString(Foreground)
	e.ForegroundColorPrimary = ColorToString(ForegroundColorPrimary)
	e.ForegroundColorSecondary = ColorToString(ForegroundColorSecondary)
	e.Background = BackgroundToString(Background)
	e.BackgroundColor = ColorToString(BackgroundColor)
	SendChangedEvent(e)

	Preview.SetPrimary(Material.ToTexturePath("Primary", ForegroundToString(Foreground)), ColorToHex(ForegroundColorPrimary))
	Preview.SetSecondary(Material.ToTexturePath("Secondary", ForegroundToString(Foreground)), ColorToHex(ForegroundColorSecondary))
	Preview.SetBackground(Material.ToTexturePath("Background", BackgroundToString(Background)), ColorToHex(BackgroundColor))

	Material.Apply()
	WriteLine(self, "ApplyChanges", ToString())
EndFunction


; OnChanged
;---------------------------------------------

CustomEvent OnChanged

Struct ChangedEventArgs
	int Preset = -1
	string Foreground
	string ForegroundColorPrimary
	string ForegroundColorSecondary
	string Background
	string BackgroundColor
EndStruct


Function SendChangedEvent(ChangedEventArgs e)
	var[] arguments = new var[1]
	arguments[0] = e
	SendCustomEvent("OnChanged", arguments)
EndFunction


bool Function RegisterForChangedEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnChanged")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForChangedEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForChangedEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnChanged")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForChangedEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


ChangedEventArgs Function GetChangedEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as ChangedEventArgs
	Else
		WriteUnexpectedValue(self, "GetChangedEventArgs", "arguments", "The changed event arguments are empty or none.")
		return none
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function ForegroundToString(int value)
	{Converts an option index into a foreground file name.}
	If (value == Blank)
		return none
	ElseIf (value == Decal117)
		return "117"
	ElseIf (value == ActiveRooster)
		return "ActiveRooster"
	ElseIf (value == Arrowhead)
		return "Arrowhead"
	ElseIf (value == Assassin)
		return "Assassin"
	ElseIf (value == Bulletproof)
		return "Bulletproof"
	ElseIf (value == Cone)
		return "Cone"
	ElseIf (value == Covenant)
		return "Covenant"
	ElseIf (value == CupOfDeath)
		return "CupOfDeath"
	ElseIf (value == Grenade)
		return "Grenade"
	ElseIf (value == Guilty)
		return "Guilty"
	ElseIf (value == Headshot)
		return "Headshot"
	ElseIf (value == Infected)
		return "Infected"
	ElseIf (value == LASO)
		return "LASO"
	ElseIf (value == Mjolnir)
		return "Mjolnir"
	ElseIf (value == Noble)
		return "Noble"
	ElseIf (value == ONI)
		return "ONI"
	ElseIf (value == OnYourShield)
		return "OnYourShield"
	ElseIf (value == Planetary)
		return "Planetary"
	ElseIf (value == Seven)
		return "Seven"
	ElseIf (value == Sinner)
		return "Sinner"
	ElseIf (value == Spartan)
		return "Spartan"
	ElseIf (value == SpartanHelmet)
		return "SpartanHelmet"
	ElseIf (value == Splatter)
		return "Splatter"
	ElseIf (value == Superintendent)
		return "Superintendent"
	ElseIf (value == Unicorn)
		return "Unicorn"
	ElseIf (value == Valkyrie)
		return "Valkyrie"
	ElseIf (value == Wolf)
		return "Wolf"
	ElseIf (value == YingYang)
		return "YingYang"
	Else
		WriteUnexpected(self, "ForegroundToString", "The value of "+value+" was out of range.")
		return none
	EndIf
EndFunction


string Function BackgroundToString(int value)
	{Converts an option index into a background file name.}
	If (value == Blank)
		return none
	ElseIf (value == FourDiamonds)
		return "4Diamonds"
	ElseIf (value == Asterisk)
		return "Asterisk"
	ElseIf (value == BallOFire)
		return "BallOFire"
	ElseIf (value == BlankOne)
		return "BlankOne"
	ElseIf (value == Cancel)
		return "Cancel"
	ElseIf (value == Chevron)
		return "Chevron"
	ElseIf (value == Circle)
		return "Circle"
	ElseIf (value == Cog)
		return "Cog"
	ElseIf (value == CowboyHat)
		return "CowboyHat"
	ElseIf (value == CrissCross)
		return "CrissCross"
	ElseIf (value == Crown)
		return "Crown"
	ElseIf (value == Diamond)
		return "Diamond"
	ElseIf (value == Display)
		return "Display"
	ElseIf (value == Hexagon)
		return "Hexagon"
	ElseIf (value == HorizontalStripes)
		return "HorizontalStripes"
	ElseIf (value == Limited)
		return "Limited"
	ElseIf (value == Power)
		return "Power"
	ElseIf (value == Shield)
		return "Shield"
	ElseIf (value == Star)
		return "Star"
	ElseIf (value == Structure)
		return "Structure"
	Else
		WriteUnexpected(self, "BackgroundToString", "The value of "+value+" was out of range.")
		return none
	EndIf
EndFunction


string Function ColorToString(int value)
	{Converts an option index into a colors folder name.}
	If (value == Black)
		return "1Black"
	ElseIf (value == Silver)
		return "1Silver"
	ElseIf (value == Steel)
		return "1Steel"
	ElseIf (value == White)
		return "1White"
	ElseIf (value == Mauve)
		return "2Mauve"
	ElseIf (value == Red)
		return "2Red"
	ElseIf (value == Salmon)
		return "2Salmon"
	ElseIf (value == Coral)
		return "3Coral"
	ElseIf (value == Orange)
		return "3Orange"
	ElseIf (value == Peach)
		return "3Peach"
	ElseIf (value == Gold)
		return "4Gold"
	ElseIf (value == Pale)
		return "4Pale"
	ElseIf (value == Yellow)
		return "4Yellow"
	ElseIf (value == Green)
		return "5Green"
	ElseIf (value == Olive)
		return "5Olive"
	ElseIf (value == Sage)
		return "5Sage"
	ElseIf (value == Aqua)
		return "6Aqua"
	ElseIf (value == Cyan)
		return "6Cyan"
	ElseIf (value == Teal)
		return "6Teal"
	ElseIf (value == Blue)
		return "7Blue"
	ElseIf (value == Cobalt)
		return "7Cobalt"
	ElseIf (value == Sapphire)
		return "7Sapphire"
	ElseIf (value == Lavendar)
		return "8Lavendar"
	ElseIf (value == Orchid)
		return "8Orchid"
	ElseIf (value == Violet)
		return "8Violet"
	ElseIf (value == Crimson)
		return "9Crimson"
	ElseIf (value == Pink)
		return "9Pink"
	ElseIf (value == Rubine)
		return "9Rubine"
	ElseIf (value == Brown)
		return "Brown"
	ElseIf (value == Khaki)
		return "Khaki"
	ElseIf (value == Tan)
		return "Tan"
	Else
		WriteUnexpected(self, "ColorToString", "The value of "+value+" was out of range.")
		return none
	EndIf
EndFunction


int Function ColorToHex(int value)
	{Converts an option index into a colors hex value.}
	If (value == Black)
		return 0x000000
	ElseIf (value == Silver)
		return 0xB1B1B1
	ElseIf (value == Steel)
		return 0x656565
	ElseIf (value == White)
		return 0xFFFFFF
	ElseIf (value == Mauve)
		return 0xDB6B6A
	ElseIf (value == Red)
		return 0x9C3433
	ElseIf (value == Salmon)
		return 0xEF8383
	ElseIf (value == Coral)
		return 0xF7AF5B
	ElseIf (value == Orange)
		return 0xDA8E07
	ElseIf (value == Peach)
		return 0xFECBA0
	ElseIf (value == Gold)
		return 0xCDAE31
	ElseIf (value == Pale)
		return 0xFBD87E
	ElseIf (value == Yellow)
		return 0xF1BE31
	ElseIf (value == Green)
		return 0x92A764
	ElseIf (value == Olive)
		return 0xD9F0A8
	ElseIf (value == Sage)
		return 0x5D7720
	ElseIf (value == Aqua)
		return 0x4DBDC1
	ElseIf (value == Cyan)
		return 0x92ECEC
	ElseIf (value == Teal)
		return 0x367B80
	ElseIf (value == Blue)
		return 0x385D94
	ElseIf (value == Cobalt)
		return 0x598AD9
	ElseIf (value == Sapphire)
		return 0x9AB7F3
	ElseIf (value == Lavendar)
		return 0xC5B5FC
	ElseIf (value == Orchid)
		return 0x9377E5
	ElseIf (value == Violet)
		return 0x594292
	ElseIf (value == Crimson)
		return 0x85064B
	ElseIf (value == Pink)
		return 0xFD8DBB
	ElseIf (value == Rubine)
		return 0xD24186
	ElseIf (value == Brown)
		return 0x553B1A
	ElseIf (value == Khaki)
		return 0xE1BFA3
	ElseIf (value == Tan)
		return 0xAC8D70
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
	ODST:Properties Property Properties Auto Const Mandatory
 	ODST:Settings Property Settings Auto Const Mandatory
	ODST:Emblems:Material Property Material Auto Const Mandatory
	ODST:Emblems:Preview Property Preview Auto Const Mandatory
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

Group Colors
	int Property Black = 0 AutoReadOnly
	int Property Silver = 1 AutoReadOnly
	int Property Steel = 2 AutoReadOnly
	int Property White = 3 AutoReadOnly
	int Property Mauve = 4 AutoReadOnly
	int Property Red = 5 AutoReadOnly
	int Property Salmon = 6 AutoReadOnly
	int Property Coral = 7 AutoReadOnly
	int Property Orange = 8 AutoReadOnly
	int Property Peach = 9 AutoReadOnly
	int Property Gold = 10 AutoReadOnly
	int Property Pale = 11 AutoReadOnly
	int Property Yellow = 12 AutoReadOnly
	int Property Green = 13 AutoReadOnly
	int Property Olive = 14 AutoReadOnly
	int Property Sage = 15 AutoReadOnly
	int Property Aqua = 16 AutoReadOnly
	int Property Cyan = 17 AutoReadOnly
	int Property Teal = 18 AutoReadOnly
	int Property Blue = 19 AutoReadOnly
	int Property Cobalt = 20 AutoReadOnly
	int Property Sapphire = 21 AutoReadOnly
	int Property Lavendar = 22 AutoReadOnly
	int Property Orchid = 23 AutoReadOnly
	int Property Violet = 24 AutoReadOnly
	int Property Crimson = 25 AutoReadOnly
	int Property Pink = 26 AutoReadOnly
	int Property Rubine = 27 AutoReadOnly
	int Property Brown = 28 AutoReadOnly
	int Property Khaki = 29 AutoReadOnly
	int Property Tan = 30 AutoReadOnly
EndGroup
