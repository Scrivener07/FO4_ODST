Scriptname ODST:Special:TWBATSong extends ActiveMagicEffect
{Reach - There Will Be Another Time}
; Plays when on less than 20 or 25% hp

int instance

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	instance = ODST_SONG_TWBAT.Play(akCaster)
EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Sound.SetInstanceVolume(instance, 1)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(instance, 0.9)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(instance, 0.8)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(instance, 0.7)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(instance, 0.6)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(instance, 0.5)
	Utility.Wait(0.15)
	Sound.SetInstanceVolume(instance, 0.4)
	Utility.Wait(0.15)
	Sound.SetInstanceVolume(instance, 0.3)
	Utility.Wait(0.15)
	Sound.SetInstanceVolume(instance, 0.2)
	Utility.Wait(0.1)
	Sound.SetInstanceVolume(instance, 0.1)
	Utility.Wait(0.1)
	Sound.SetInstanceVolume(instance, 0)
	Utility.Wait(0.1)
	Sound.StopInstance(instance)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Sound Property ODST_SONG_TWBAT Auto Const Mandatory
EndGroup
