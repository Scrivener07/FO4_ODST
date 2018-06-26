Scriptname ODSTVISRSoundScript extends activemagiceffect

;-- Properties --------------------------------------
Sound Property ODSTVISRActivate Auto Const mandatory
Sound Property ODSTVISRDeactivate Auto Const mandatory

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ODSTVISRActivate.Play(akCaster as ObjectReference)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ODSTVISRDeactivate.Play(akCaster as ObjectReference)
EndEvent