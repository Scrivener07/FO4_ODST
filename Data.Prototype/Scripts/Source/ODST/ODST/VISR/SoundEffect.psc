Scriptname ODST:VISR:SoundEffect extends ActiveMagicEffect
{Plays sounds for the effects begin & end.}
; ODSTVISRSoundScript

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ODSTVISRActivate.Play(akCaster)
EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ODSTVISRDeactivate.Play(akCaster)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Sound Property ODSTVISRActivate Auto Const Mandatory
	Sound Property ODSTVISRDeactivate Auto Const Mandatory
EndGroup
