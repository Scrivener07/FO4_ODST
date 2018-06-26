Scriptname ODSTVISRControlScript extends Quest Conditional

; Settings
;float Property fSlowTimePercentage Auto
;float Property fAPCost Auto
;int Property iVisualEffect Auto		; 0 - Default, 1 - VATS

; Properties
Form Property SlowTimeAid Auto
Form Property SlowTimeConfigurator Auto

Function OnInit()
	Actor PlayerREF = Game.GetPlayer()

	If (PlayerREF.GetItemCount(SlowTimeAid) == 0)
		PlayerREF.AddItem(SlowTimeAid, 1, False)
	EndIf
	If (PlayerREF.GetItemCount(SlowTimeConfigurator) == 0)
		PlayerREF.AddItem(SlowTimeConfigurator, 1, False)
	EndIf
EndFunction