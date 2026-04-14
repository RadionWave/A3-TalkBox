params [
	["_display", displayNull, [displayNull]]
];

if(isNull _display)exitWith {
	diag_log "RscTalkBox: No display passed to onLoad function";
};

uiNamespace setVariable ["RscTalkBox", _display];