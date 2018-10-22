Scriptname ODST:Examine:Menu extends ODST:Examine:MenuType
import ODST
import ODST:Log
import ODST:Papyrus

; Events
;---------------------------------------------

Event OnQuestInit()
	RegisterForMenuOpenCloseEvent(Name)
	RegisterForExternalEvent("ODST_Examine_OnModChanged", "OnModChanged")
	RegisterForExternalEvent("ODST_Examine_OnEditButton", "OnEditButton")
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine(ToString(), "OnMenuOpenCloseEvent(menuName:"+menuName+", opening:"+opening+")")
	If (opening)
		UI.Load(Name, Root, Asset, self, "OnLoadComplete")
	Else
		Preview.Close()
	EndIf
	OpenCloseEventArgs e = new OpenCloseEventArgs
	e.Opening = opening
	self.SendOpenCloseEvent(e)
EndEvent


Event OnLoadComplete(bool success, string menuName, string sourceVar, string destVar, string assetPath)
	{The UI loaded callback.}
	WriteLine(ToString(), "OnLoadComplete", "(success:"+success+", menuName:"+menuName+", sourceVar:"+sourceVar+", destVar:"+destVar+", assetPath:"+assetPath+")")
EndEvent


Event OnModChanged(int selected)
	WriteLine(ToString(), "OnModChanged(argument:"+selected+")")
	If (selected > Invalid)
		Emblems:Preset preset = Editor.GetPreset(selected)
		Preview.Update(Editor, preset)
	Else
		WriteUnexpectedValue(self, "OnModChanged", "selected", "The value of "+selected+" is not valid.")
	EndIf
EndEvent


Event OnEditButton()
	WriteLine(ToString(), "OnEditButton")
	Preview.Open()
EndEvent


; Functions
;---------------------------------------------

string Function GetMember(string member)
	If (member)
		return Instance+"."+member
	Else
		WriteUnexpectedValue(self, "GetMember", "member", "The value cannot be none or empty.")
		return none
	EndIf
EndFunction


; Open Event
;---------------------------------------------
CustomEvent OpenCloseEvent

Struct OpenCloseEventArgs
	bool Opening = false
EndStruct


Function SendOpenCloseEvent(OpenCloseEventArgs e)
	If (e)
		var[] arguments = new var[1]
		arguments[0] = e
		self.SendCustomEvent("OpenCloseEvent", arguments)
	Else
		WriteLine(ToString(), "SendOpenCloseEvent : e : Cannot be none.")
	EndIf
EndFunction


bool Function RegisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteLine(ToString(), "RegisterForOpenCloseEvent : script : Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteLine(ToString(), "UnregisterForOpenCloseEvent : script : Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


OpenCloseEventArgs Function GetOpenCloseEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as OpenCloseEventArgs
	Else
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Emblems:Editor Property Editor Auto Const Mandatory
	ODST:Emblems:Preview Property Preview Auto Const Mandatory

	string Property Name Hidden
		string Function Get()
			return "ExamineMenu"
		EndFunction
	EndProperty

	string Property Root Hidden
		string Function Get()
			return "root1"
		EndFunction
	EndProperty

	string Property Instance Hidden
		string Function Get()
			return Root+".BaseInstance"
		EndFunction
	EndProperty

	string Property Asset Hidden
		string Function Get()
			return "ExamineMenu_ODST.swf"
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			return UI.IsMenuOpen(Name)
		EndFunction
	EndProperty
EndGroup
