Scriptname ODST:Type extends Quest Const Native Hidden
{The generic base type for ODST script objects.}

; OnGameReload
;---------------------------------------------

Event OnGameReload() Native
{Event occurs when the game has been reloaded.}


Event Actor.OnPlayerLoadGame(Actor akSender)
	{The remote player actor event for game reloading.}
	OnGameReload()
EndEvent


bool Function RegisterForGameReload(ScriptObject this)
	{Register this script oject for game reload events.}
	return this.RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction


Function UnregisterForGameReload(ScriptObject this)
	{Unregister this script oject for game reload events.}
	this.UnregisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction


; Functions
;---------------------------------------------

string Function ToString()
	{The string representation of this type.}
	return "[ODST:Type]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	int Property Invalid = -1 AutoReadOnly
	{A generic invalid integer value.}

	string Property EmptyState = "" AutoReadOnly
	{A script objects default state name is an empty string.}

	string Property StateName Hidden
		{This scripts current state name.}
		string Function Get()
			return self.GetState()
		EndFunction
	EndProperty
EndGroup
