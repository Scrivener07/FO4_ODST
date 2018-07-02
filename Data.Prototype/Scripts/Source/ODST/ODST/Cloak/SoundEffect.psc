Scriptname ODST:Cloak:SoundEffect extends ActiveMagicEffect
; ActiveCamoStealthSoundScript

int instance

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	OBJArmorStealthActivate.Play(akCaster)
	instance = OBJArmorStealthActive.Play(akCaster)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	OBJArmorStealthDeactivate.Play(akCaster)
	Sound.StopInstance(instance)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Sound Property OBJArmorStealthActivate Auto Const Mandatory
	Sound Property OBJArmorStealthDeactivate Auto Const Mandatory
	Sound Property OBJArmorStealthActive Auto Const Mandatory
EndGroup
