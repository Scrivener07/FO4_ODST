ScriptName ODST:Emblems:Color extends ODST:Type
{Provides information about emblem colors.}
import ODST:Papyrus
import ODST:Log

Struct Map
	int Option = -1
	string Folder = ""
	int Hexadecimal = -1
EndStruct


; Events
;---------------------------------------------

Event OnQuestInit()
	Default = new Color:Map
	Default.Option = OptionWhite
	Default.Folder = FolderWhite
	Default.Hexadecimal = HexWhite

	Black = new Color:Map
	Black.Option = OptionBlack
	Black.Folder = FolderBlack
	Black.Hexadecimal = HexBlack

	Silver = new Color:Map
	Silver.Option = OptionSilver
	Silver.Folder = FolderSilver
	Silver.Hexadecimal = HexSilver

	Steel = new Color:Map
	Steel.Option = OptionSteel
	Steel.Folder = FolderSteel
	Steel.Hexadecimal = HexSteel

	White = new Color:Map
	White.Option = OptionWhite
	White.Folder = FolderWhite
	White.Hexadecimal = HexWhite

	Mauve = new Color:Map
	Mauve.Option = OptionMauve
	Mauve.Folder = FolderMauve
	Mauve.Hexadecimal = HexMauve

	Red = new Color:Map
	Red.Option = OptionRed
	Red.Folder = FolderRed
	Red.Hexadecimal = HexRed

	Salmon = new Color:Map
	Salmon.Option = OptionSalmon
	Salmon.Folder = FolderSalmon
	Salmon.Hexadecimal = HexSalmon

	Coral = new Color:Map
	Coral.Option = OptionCoral
	Coral.Folder = FolderCoral
	Coral.Hexadecimal = HexCoral

	Orange = new Color:Map
	Orange.Option = OptionOrange
	Orange.Folder = FolderOrange
	Orange.Hexadecimal = HexOrange

	Peach = new Color:Map
	Peach.Option = OptionPeach
	Peach.Folder = FolderPeach
	Peach.Hexadecimal = HexPeach

	Gold = new Color:Map
	Gold.Option = OptionGold
	Gold.Folder = FolderGold
	Gold.Hexadecimal = HexGold

	Pale = new Color:Map
	Pale.Option = OptionPale
	Pale.Folder = FolderPale
	Pale.Hexadecimal = HexPale

	Yellow = new Color:Map
	Yellow.Option = OptionYellow
	Yellow.Folder = FolderYellow
	Yellow.Hexadecimal = HexYellow

	Green = new Color:Map
	Green.Option = OptionGreen
	Green.Folder = FolderGreen
	Green.Hexadecimal = HexGreen

	Olive = new Color:Map
	Olive.Option = OptionOlive
	Olive.Folder = FolderOlive
	Olive.Hexadecimal = HexOlive

	Sage = new Color:Map
	Sage.Option = OptionSage
	Sage.Folder = FolderSage
	Sage.Hexadecimal = HexSage

	Aqua = new Color:Map
	Aqua.Option = OptionAqua
	Aqua.Folder = FolderAqua
	Aqua.Hexadecimal = HexAqua

	Cyan = new Color:Map
	Cyan.Option = OptionCyan
	Cyan.Folder = FolderCyan
	Cyan.Hexadecimal = HexCyan

	Teal = new Color:Map
	Teal.Option = OptionTeal
	Teal.Folder = FolderTeal
	Teal.Hexadecimal = HexTeal

	Blue = new Color:Map
	Blue.Option = OptionBlue
	Blue.Folder = FolderBlue
	Blue.Hexadecimal = HexBlue

	Cobalt = new Color:Map
	Cobalt.Option = OptionCobalt
	Cobalt.Folder = FolderCobalt
	Cobalt.Hexadecimal = HexCobalt

	Sapphire = new Color:Map
	Sapphire.Option = OptionSapphire
	Sapphire.Folder = FolderSapphire
	Sapphire.Hexadecimal = HexSapphire

	Lavendar = new Color:Map
	Lavendar.Option = OptionLavendar
	Lavendar.Folder = FolderLavendar
	Lavendar.Hexadecimal = HexLavendar

	Orchid = new Color:Map
	Orchid.Option = OptionOrchid
	Orchid.Folder = FolderOrchid
	Orchid.Hexadecimal = HexOrchid

	Violet = new Color:Map
	Violet.Option = OptionViolet
	Violet.Folder = FolderViolet
	Violet.Hexadecimal = HexViolet

	Crimson = new Color:Map
	Crimson.Option = OptionCrimson
	Crimson.Folder = FolderCrimson
	Crimson.Hexadecimal = HexCrimson

	Pink = new Color:Map
	Pink.Option = OptionPink
	Pink.Folder = FolderPink
	Pink.Hexadecimal = HexPink

	Rubine = new Color:Map
	Rubine.Option = OptionRubine
	Rubine.Folder = FolderRubine
	Rubine.Hexadecimal = HexRubine

	Brown = new Color:Map
	Brown.Option = OptionBrown
	Brown.Folder = FolderBrown
	Brown.Hexadecimal = HexBrown

	Khaki = new Color:Map
	Khaki.Option = OptionKhaki
	Khaki.Folder = FolderKhaki
	Khaki.Hexadecimal = HexKhaki

	Tan = new Color:Map
	Tan.Option = OptionTan
	Tan.Folder = FolderTan
	Tan.Hexadecimal = HexTan
EndEvent


; Functions
;---------------------------------------------

string Function OptionToFolder(int option)
	{Converts an option index into a colors folder name.}
	If (option == Invalid)
		return ""
	ElseIf (option == OptionBlack)
		return FolderBlack
	ElseIf (option == OptionSilver)
		return FolderSilver
	ElseIf (option == OptionSteel)
		return FolderSteel
	ElseIf (option == OptionWhite)
		return FolderWhite
	ElseIf (option == OptionMauve)
		return FolderMauve
	ElseIf (option == OptionRed)
		return FolderRed
	ElseIf (option == OptionSalmon)
		return FolderSalmon
	ElseIf (option == OptionCoral)
		return FolderCoral
	ElseIf (option == OptionOrange)
		return FolderOrange
	ElseIf (option == OptionPeach)
		return FolderPeach
	ElseIf (option == OptionGold)
		return FolderGold
	ElseIf (option == OptionPale)
		return FolderPale
	ElseIf (option == OptionYellow)
		return FolderYellow
	ElseIf (option == OptionGreen)
		return FolderGreen
	ElseIf (option == OptionOlive)
		return FolderOlive
	ElseIf (option == OptionSage)
		return FolderSage
	ElseIf (option == OptionAqua)
		return FolderAqua
	ElseIf (option == OptionCyan)
		return FolderCyan
	ElseIf (option == OptionTeal)
		return FolderTeal
	ElseIf (option == OptionBlue)
		return FolderBlue
	ElseIf (option == OptionCobalt)
		return FolderCobalt
	ElseIf (option == OptionSapphire)
		return FolderSapphire
	ElseIf (option == OptionLavendar)
		return FolderLavendar
	ElseIf (option == OptionOrchid)
		return FolderOrchid
	ElseIf (option == OptionViolet)
		return FolderViolet
	ElseIf (option == OptionCrimson)
		return FolderCrimson
	ElseIf (option == OptionPink)
		return FolderPink
	ElseIf (option == OptionRubine)
		return FolderRubine
	ElseIf (option == OptionBrown)
		return FolderBrown
	ElseIf (option == OptionKhaki)
		return FolderKhaki
	ElseIf (option == OptionTan)
		return FolderTan
	Else
		WriteUnexpected(self, "OptionToFolder", "The option of "+option+" was out of range.")
		return ""
	EndIf
EndFunction

int Function OptionToHex(int option)
	{Converts an option index into a colors hex option.}
	If (option == Invalid)
		return Invalid
	ElseIf (option == OptionBlack)
		return HexBlack
	ElseIf (option == OptionSilver)
		return HexSilver
	ElseIf (option == OptionSteel)
		return HexSteel
	ElseIf (option == OptionWhite)
		return HexWhite
	ElseIf (option == OptionMauve)
		return HexMauve
	ElseIf (option == OptionRed)
		return HexRed
	ElseIf (option == OptionSalmon)
		return HexSalmon
	ElseIf (option == OptionCoral)
		return HexCoral
	ElseIf (option == OptionOrange)
		return HexOrange
	ElseIf (option == OptionPeach)
		return HexPeach
	ElseIf (option == OptionGold)
		return HexGold
	ElseIf (option == OptionPale)
		return HexPale
	ElseIf (option == OptionYellow)
		return HexYellow
	ElseIf (option == OptionGreen)
		return HexGreen
	ElseIf (option == OptionOlive)
		return HexOlive
	ElseIf (option == OptionSage)
		return HexSage
	ElseIf (option == OptionAqua)
		return HexAqua
	ElseIf (option == OptionCyan)
		return HexCyan
	ElseIf (option == OptionTeal)
		return HexTeal
	ElseIf (option == OptionBlue)
		return HexBlue
	ElseIf (option == OptionCobalt)
		return HexCobalt
	ElseIf (option == OptionSapphire)
		return HexSapphire
	ElseIf (option == OptionLavendar)
		return HexLavendar
	ElseIf (option == OptionOrchid)
		return HexOrchid
	ElseIf (option == OptionViolet)
		return HexViolet
	ElseIf (option == OptionCrimson)
		return HexCrimson
	ElseIf (option == OptionPink)
		return HexPink
	ElseIf (option == OptionRubine)
		return HexRubine
	ElseIf (option == OptionBrown)
		return HexBrown
	ElseIf (option == OptionKhaki)
		return HexKhaki
	ElseIf (option == OptionTan)
		return HexTan
	Else
		WriteUnexpected(self, "OptionToHex", "The option of "+option+" was out of range.")
		return Invalid
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Colors
	Color:Map Property Default Auto Hidden
	Color:Map Property Black Auto Hidden
	Color:Map Property Silver Auto Hidden
	Color:Map Property Steel Auto Hidden
	Color:Map Property White Auto Hidden
	Color:Map Property Mauve Auto Hidden
	Color:Map Property Red Auto Hidden
	Color:Map Property Salmon Auto Hidden
	Color:Map Property Coral Auto Hidden
	Color:Map Property Orange Auto Hidden
	Color:Map Property Peach Auto Hidden
	Color:Map Property Gold Auto Hidden
	Color:Map Property Pale Auto Hidden
	Color:Map Property Yellow Auto Hidden
	Color:Map Property Green Auto Hidden
	Color:Map Property Olive Auto Hidden
	Color:Map Property Sage Auto Hidden
	Color:Map Property Aqua Auto Hidden
	Color:Map Property Cyan Auto Hidden
	Color:Map Property Teal Auto Hidden
	Color:Map Property Blue Auto Hidden
	Color:Map Property Cobalt Auto Hidden
	Color:Map Property Sapphire Auto Hidden
	Color:Map Property Lavendar Auto Hidden
	Color:Map Property Orchid Auto Hidden
	Color:Map Property Violet Auto Hidden
	Color:Map Property Crimson Auto Hidden
	Color:Map Property Pink Auto Hidden
	Color:Map Property Rubine Auto Hidden
	Color:Map Property Brown Auto Hidden
	Color:Map Property Khaki Auto Hidden
	Color:Map Property Tan Auto Hidden
EndGroup

Group Option
	int Property OptionBlack = 0 AutoReadOnly
	int Property OptionSilver = 1 AutoReadOnly
	int Property OptionSteel = 2 AutoReadOnly
	int Property OptionWhite = 3 AutoReadOnly
	int Property OptionMauve = 4 AutoReadOnly
	int Property OptionRed = 5 AutoReadOnly
	int Property OptionSalmon = 6 AutoReadOnly
	int Property OptionCoral = 7 AutoReadOnly
	int Property OptionOrange = 8 AutoReadOnly
	int Property OptionPeach = 9 AutoReadOnly
	int Property OptionGold = 10 AutoReadOnly
	int Property OptionPale = 11 AutoReadOnly
	int Property OptionYellow = 12 AutoReadOnly
	int Property OptionGreen = 13 AutoReadOnly
	int Property OptionOlive = 14 AutoReadOnly
	int Property OptionSage = 15 AutoReadOnly
	int Property OptionAqua = 16 AutoReadOnly
	int Property OptionCyan = 17 AutoReadOnly
	int Property OptionTeal = 18 AutoReadOnly
	int Property OptionBlue = 19 AutoReadOnly
	int Property OptionCobalt = 20 AutoReadOnly
	int Property OptionSapphire = 21 AutoReadOnly
	int Property OptionLavendar = 22 AutoReadOnly
	int Property OptionOrchid = 23 AutoReadOnly
	int Property OptionViolet = 24 AutoReadOnly
	int Property OptionCrimson = 25 AutoReadOnly
	int Property OptionPink = 26 AutoReadOnly
	int Property OptionRubine = 27 AutoReadOnly
	int Property OptionBrown = 28 AutoReadOnly
	int Property OptionKhaki = 29 AutoReadOnly
	int Property OptionTan = 30 AutoReadOnly
EndGroup

Group Folder
	string Property FolderBlack = "1Black" AutoReadOnly
	string Property FolderSilver = "1Silver" AutoReadOnly
	string Property FolderSteel = "1Steel" AutoReadOnly
	string Property FolderWhite = "1White" AutoReadOnly
	string Property FolderMauve = "2Mauve" AutoReadOnly
	string Property FolderRed = "2Red" AutoReadOnly
	string Property FolderSalmon = "2Salmon" AutoReadOnly
	string Property FolderCoral = "3Coral" AutoReadOnly
	string Property FolderOrange = "3Orange" AutoReadOnly
	string Property FolderPeach = "3Peach" AutoReadOnly
	string Property FolderGold = "4Gold" AutoReadOnly
	string Property FolderPale = "4Pale" AutoReadOnly
	string Property FolderYellow = "4Yellow" AutoReadOnly
	string Property FolderGreen = "5Green" AutoReadOnly
	string Property FolderOlive = "5Olive" AutoReadOnly
	string Property FolderSage = "5Sage" AutoReadOnly
	string Property FolderAqua = "6Aqua" AutoReadOnly
	string Property FolderCyan = "6Cyan" AutoReadOnly
	string Property FolderTeal = "6Teal" AutoReadOnly
	string Property FolderBlue = "7Blue" AutoReadOnly
	string Property FolderCobalt = "7Cobalt" AutoReadOnly
	string Property FolderSapphire = "7Sapphire" AutoReadOnly
	string Property FolderLavendar = "8Lavendar" AutoReadOnly
	string Property FolderOrchid = "8Orchid" AutoReadOnly
	string Property FolderViolet = "8Violet" AutoReadOnly
	string Property FolderCrimson = "9Crimson" AutoReadOnly
	string Property FolderPink = "9Pink" AutoReadOnly
	string Property FolderRubine = "9Rubine" AutoReadOnly
	string Property FolderBrown = "Brown" AutoReadOnly
	string Property FolderKhaki = "Khaki" AutoReadOnly
	string Property FolderTan = "Tan" AutoReadOnly
EndGroup

Group Hexadecimal
	int Property HexBlack = 0x000000 AutoReadOnly
	int Property HexSilver = 0xB1B1B1 AutoReadOnly
	int Property HexSteel = 0x656565 AutoReadOnly
	int Property HexWhite = 0xFFFFFF AutoReadOnly
	int Property HexMauve = 0xDB6B6A AutoReadOnly
	int Property HexRed = 0x9C3433 AutoReadOnly
	int Property HexSalmon = 0xEF8383 AutoReadOnly
	int Property HexCoral = 0xF7AF5B AutoReadOnly
	int Property HexOrange = 0xDA8E07 AutoReadOnly
	int Property HexPeach = 0xFECBA0 AutoReadOnly
	int Property HexGold = 0xCDAE31 AutoReadOnly
	int Property HexPale = 0xFBD87E AutoReadOnly
	int Property HexYellow = 0xF1BE31 AutoReadOnly
	int Property HexGreen = 0x92A764 AutoReadOnly
	int Property HexOlive = 0xD9F0A8 AutoReadOnly
	int Property HexSage = 0x5D7720 AutoReadOnly
	int Property HexAqua = 0x4DBDC1 AutoReadOnly
	int Property HexCyan = 0x92ECEC AutoReadOnly
	int Property HexTeal = 0x367B80 AutoReadOnly
	int Property HexBlue = 0x385D94 AutoReadOnly
	int Property HexCobalt = 0x598AD9 AutoReadOnly
	int Property HexSapphire = 0x9AB7F3 AutoReadOnly
	int Property HexLavendar = 0xC5B5FC AutoReadOnly
	int Property HexOrchid = 0x9377E5 AutoReadOnly
	int Property HexViolet = 0x594292 AutoReadOnly
	int Property HexCrimson = 0x85064B AutoReadOnly
	int Property HexPink = 0xFD8DBB AutoReadOnly
	int Property HexRubine = 0xD24186 AutoReadOnly
	int Property HexBrown = 0x553B1A AutoReadOnly
	int Property HexKhaki = 0xE1BFA3 AutoReadOnly
	int Property HexTan = 0xAC8D70 AutoReadOnly
EndGroup
