Scriptname ODST:VISR:VisualEffect extends ActiveMagicEffect
; PerkODSTVISReffect

Bool IsOkToPlay = true
bool IsFinishing = false


; Events
;---------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)
	If (PlayerOnly)
		If (Caster != Game.GetPlayer())
			IsOkToPlay = false
		EndIf
	EndIf
	If (IsOkToPlay)
		IntroFX.Remove()
		LoopFX.Remove()
		OutroFX.Remove()
		IntroFX.Apply(Strength)

		Utility.Wait(Delay)
		If (IsFinishing == false)
			IntroFX.PopTo(LoopFX, Strength)
		EndIf
	EndIf
EndEvent


Event OnEffectFinish(Actor Target, Actor Caster)
	IsFinishing = true
	If (IsOkToPlay)
		IntroFX.Remove()
		LoopFX.PopTo(OutroFX, Strength)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	bool Property PlayerOnly = false Auto Const
	{Set this If you only want this Imod to play If the player is the spell caster.}

	float property Delay = 0.83 Auto Const
	{time to wait before switching to constant Imod}

	ImageSpaceModifier property IntroFX Auto Const
	{IsMod applied at the start of the spell effect}

	ImageSpaceModifier property LoopFX Auto Const
	{main isMod for spell}

	ImageSpaceModifier property OutroFX Auto Const
	{IsMod applied at the end of the spell effect}

	float Property Strength = 1.0 Auto Const
	{IsMod Strength from 0.0 to 1.0}
EndGroup
