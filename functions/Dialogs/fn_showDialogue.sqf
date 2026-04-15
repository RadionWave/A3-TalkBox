/*
 * Author: RadionWave
 * Description: Show the dialog to the specified target(s) with the given parameters.
 *
 * Arguments:
 * 0: _targets <OBJECT/GROUP/ARRAY> Target player(s) that should see the dialog. Can be a single player object, a group, or an array of players/groups.
 * 1: _unit <OBJECT> Source unit of the dialog.
 * 2: _text <STRING> Text to display.
 * 3: _customName <STRING> Custom name to display instead of the unit's name.
 * 4: _customImage <STRING> Path or identifier of the custom image.
 * 5: _duration <SCALAR> Duration in seconds before the dialog auto-closes (0 for no auto-close).
 * 6: _unitCustomColor <STRING> Custom color for the unit name.
 * 7: _textCustomColor <STRING> Custom color for the text.
 *
 * Return value:
 * None
 *
 * Example:
 * [allPlayers, _unit, "Good evening", "Chief", getMissionPath "Chief_HeadShot.jpg"] call AR_fnc_showDialogue;
 *
 * Public: Yes
 */

params [
	["_targets", objNull, [objNull, grpNull, []]], 	  // Target player that needs to see this. (default: objNull)
	["_unit", objNull, [objNull]],                    // Unit (default: objNull)
	["_text", "", [""]],                              // Dialog text (default: empty)
	["_customImage", "", [""]],                      // Custom name (default: empty)
	["_customName", "", [""]],                       // Custom image (default: empty)
	["_duration", 0, [0]],                            // Auto-close duration in seconds (default: 0 = no auto-close)
	["_unitCustomColor", "", [""]],                   // Unit color (default: empty)
	["_textCustomColor", "", [""]]                    // Text color (default: empty)
];
// THIS LINE IS FOR DEBUGGING ONLY
// diag_log format["[TalkBox]: AR_ShowDialogue %1",[_targets,_unit,_text,_customName,_customImage,_duration,_unitCustomColor,_textCustomColor]];

if(_targets isEqualTo []) exitWith {
	diag_log "addDialog: No targets specified for dialog";
};

// Call an event on _targets.
["AR_showDialogue",[_unit, _text, _customName, _customImage, _duration, _unitCustomColor, _textCustomColor],_targets] call CBA_fnc_targetEvent;