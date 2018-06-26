Scriptname PerkODSTVISReffectHIGH extends activemagiceffect

;======================================================================================;
;               PROPERTIES  /
;=============/

Bool Property bPlayerOnly = False auto const
{Set this if you only want this Imod to play if the player is the spell caster.}
float property fDelay = 0.83 auto const
{time to wait before switching to constant Imod}
ImageSpaceModifier property IntroFX auto const
{IsMod applied at the start of the spell effect}
ImageSpaceModifier property LoopFX auto const
{main isMod for spell}
ImageSpaceModifier property OutroFX auto const
{IsMod applied at the end of the spell effect}
Float Property fImodStrength = 1.0 auto const
{IsMod Strength from 0.0 to 1.0}


Bool bIsOkToPlay = true
bool bIsFinishing = false

;======================================================================================;
;	 EVENTS     /
;=============/


Event OnEffectStart(Actor Target, Actor Caster)

	if bPlayerOnly
		if Caster != game.GetPlayer()
			bIsOkToPlay = False
		endif
	endif
	
	if bIsOkToPlay
		;int instanceID = IntroSoundFX.play((target as objectReference))          ; play IntroSoundFX sound from my self
		IntroFX.remove()
		LoopFX.remove()									;Kill Imods from another cast, if running.
		OutroFX.remove()	
		
		introFX.apply(fImodStrength)                                  ; apply isMod at full strength
		utility.wait(fDelay)                            ; NOTE - neccessary? 
		if bIsFinishing == False
			;LoopFX.apply()
			introFX.PopTo(LoopFX,fImodStrength)                             ; remove initial FX
		endif
	endif


EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	bIsFinishing = True
	if bIsOkToPlay
		;int instanceID = OutroSoundFX.play((target as objectReference))         ; play OutroSoundFX sound from my self
		introFX.remove()
		;LoopFX.remove()
		LoopFX.PopTo(OutroFX,fImodStrength)
	endif
endEvent