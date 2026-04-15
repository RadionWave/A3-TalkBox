/*
 * Author: RadionWave
 * Description: Handles the onLoad event for the RscTalkBox dialog.
 *
 * Arguments:
 * 0: _display <DISPLAY> The display object of the dialog.
 *
 * Return value:
 * None
 *
 * Example:
 * _this call ar_fnc_onLoad;
 *
 * Public: No
 */
params [
	["_display", displayNull, [displayNull]]
];

// Exit if no display was passed to the function
if(isNull _display)exitWith {
	diag_log "RscTalkBox: No display passed to onLoad function";
};

// Store the display in the UI namespace for later access
uiNamespace setVariable ["RscTalkBox", _display];
