Scriptname ODST:Cloak:VisualEffect extends ActiveMagicEffect
{Plays the selected Imod on begin effect}
; ActiveCamouflageImodPlayerOnly

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If (akTarget == Game.GetPlayer())
		IMOD.Apply()
	endif
EndEvent


; Properties
;---------------------------------------------

Group Properties
	ImageSpaceModifier Property IMOD Auto Const Mandatory
EndGroup
