// This Event Handlers, enable the Rsc to be shown to the desired player in Multiplayer.

["AR_showDialogue", 
	{
		// THIS LINE IS FOR DEBUGGING ONLY
		// diag_log format["[TalkBox]: CBA_fnc_addEventHandler %1",_this];
		_this call AR_fnc_createTalkBox;
	}
] call CBA_fnc_addEventHandler;