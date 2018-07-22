Scriptname ODST:Emblems:Armor extends ObjectReference Default
import ODST:Log
import ODST:Papyrus

; https://www.creationkit.com/fallout4/index.php?title=Biped_Slots
int BodySlot = 3 const


; Events
;---------------------------------------------

Event OnEquipped(Actor akActor)
	WriteLine(self, "OnEquipped")
	If (akActor == Game.GetPlayer())
		; ObjectMod[] mods = akActor.GetWornItemMods(BodySlot)
		; If (mods)
		; 	int index = 0
		; 	While (index < mods.Length)
		; 		MatSwap swap = Material.GetSwapFor(mods[index])
		; 		If (swap)
		; 			Material.SetSwap(swap)
		; 			Material.Apply()
		; 			return
		; 		EndIf
		; 		index += 1
		; 	EndWhile
		; 	WriteLine(self, "OnEquipped", "No Materials were valid.")
		; Else
		; 	WriteLine(self, "OnEquipped", "No Materials were found.")
		; EndIf
	Else
		WriteLine(self, "OnEquipped", "Emblems are only supported on the player.")
	EndIf
EndEvent


; Functions
;---------------------------------------------

; Armor Function GetThis()
; 	return self.GetBaseObject() as Armor
; EndFunction


; Properties
;---------------------------------------------

; Group Properties
; 	ODST:Properties Property Properties Auto Const Mandatory
; 	ODST:Emblems:Material Property Material Auto Const Mandatory
; EndGroup
