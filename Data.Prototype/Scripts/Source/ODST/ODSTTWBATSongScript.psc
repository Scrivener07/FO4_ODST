Scriptname ODSTTWBATSongScript extends activemagiceffect

;-- Properties --------------------------------------
Sound Property ODST_SONG_TWBAT Auto Const mandatory
Int  Property OBJArmorSongFX Auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	OBJArmorSongFX = ODST_SONG_TWBAT.Play(akCaster as ObjectReference)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Sound.SetInstanceVolume(OBJArmorSongFX, 1)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0.9)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0.8)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0.7)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0.6)
	Utility.Wait(0.2)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0.5)
	Utility.Wait(0.15)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0.4)
	Utility.Wait(0.15)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0.3)
	Utility.Wait(0.15)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0.2)
	Utility.Wait(0.1)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0.1)
	Utility.Wait(0.1)
	Sound.SetInstanceVolume(OBJArmorSongFX, 0)
	Utility.Wait(0.1)
	Sound.StopInstance(OBJArmorSongFX)
EndEvent