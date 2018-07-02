Scriptname ODST:VISR:ControlScript extends Quest Conditional


; Events
;---------------------------------------------

Event OnInit()
	Actor Player = Game.GetPlayer()

	If (Player.GetItemCount(SlowTimeAid) == 0)
		Player.AddItem(SlowTimeAid, 1, false)
	EndIf

	If (Player.GetItemCount(SlowTimeConfigurator) == 0)
		Player.AddItem(SlowTimeConfigurator, 1, false)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Form Property SlowTimeAid Auto Const Mandatory
	Form Property SlowTimeConfigurator Auto Const Mandatory
EndGroup
