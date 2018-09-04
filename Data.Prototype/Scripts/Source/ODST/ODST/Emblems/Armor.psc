Scriptname ODST:Emblems:Armor extends ObjectReference
{Applies a material remapping to a reference.}
import ODST
import ODST:Log
import ODST:Emblems:Editor

Actor User


; Events
;---------------------------------------------

Event OnEquipped(Actor akActor)
	WriteLine(self, "OnEquipped", "akActor::"+akActor)
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerUseWorkBench")

	User = akActor
	UseMaterial(Editor, akActor)
EndEvent


Event OnUnequipped(Actor akActor)
	WriteLine(self, "OnUnequipped", "akActor::"+akActor)
	User = none
EndEvent


Event Actor.OnPlayerUseWorkBench(Actor akSender, ObjectReference akWorkBench)
	WriteLine(self, "Actor.OnPlayerUseWorkBench")
	UseMaterial(Editor, User)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Emblems:Editor Property Editor Auto Const Mandatory
EndGroup
