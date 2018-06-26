ScriptName ODST:Log Const Native Hidden DebugOnly
import ODST:Papyrus

; Logging
;---------------------------------------------
; Writes messages as lines in a log file.

bool Function Write(string prefix, string text) Global DebugOnly
	string filename = "ODST" const
	text = prefix + " " + text
	If(Debug.TraceUser(filename, text))
		return true
	Else
		Debug.OpenUserLog(filename)
		return Debug.TraceUser(filename, text)
	EndIf
EndFunction


bool Function WriteNotification(string prefix, string text) Global DebugOnly
	Debug.Notification(text)
	return Write(prefix, text)
EndFunction


bool Function WriteMessage(string prefix, string title, string text = "") Global DebugOnly
	string value
	If !(StringIsNoneOrEmpty(text))
		value = title+"\n"+text
	EndIf
	Debug.MessageBox(value)
	return Write(prefix, title+" "+text)
EndFunction


; Debug
;---------------------------------------------
; Writes script messages as lines in a log file.

bool Function WriteLine(var script, string member, string text = "") Global DebugOnly
	If (StringIsNoneOrEmpty(text))
		return Write(script, member)
	Else
		return Write(script+"["+member+"]", text)
	EndIf
EndFunction


bool Function WriteUnexpected(var script, string member, string text = "") Global DebugOnly
	return Write(script+"["+member+"]", "The member '"+member+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteUnexpectedValue(var script, string member, string variable, string text = "") Global DebugOnly
	return Write(script+"["+member+"."+variable+"]", "The member '"+member+"' with variable '"+variable+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteNotImplemented(var script, string member, string text = "") Global DebugOnly
	{The exception that is thrown when a requested method or operation is not implemented.}
	; The exception is thrown when a particular method, get accessors, or set accessors is present as a member of a type but is not implemented.
	return Write(script, member+": The member '"+member+"' was not implemented. "+text)
EndFunction
