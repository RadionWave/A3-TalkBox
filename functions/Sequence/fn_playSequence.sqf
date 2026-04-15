/*
 * Author: RadionWave
 * Description: Plays a full dialogue sequence on a unit, including animations, audio, and talkbox display.
 *              Each segment is played sequentially with automatic timing between them.
 *
 * Arguments:
 * 0: _targets <OBJECT, GROUP, ARRAY> Target player(s) who will see the talkbox. Can be a single player, a group, or an array of players.
 * 1: _unit <OBJECT> The AI unit performing the dialogue.
 * 2: _customImage <STRING> Path to the portrait image displayed in the talkbox.
 * 3: _customName <STRING> Custom name to display instead of the unit's in-game name.
 * 4: _segments <ARRAY> Array of dialogue segments. Each segment is an array: [text <STRING>, audioFilePath <STRING>, animationSequence <ARRAY>].
 * 5: _nameColor <STRING> (Optional) Hex color for the unit name (default: "" = auto based on faction).
 * 6: _textColor <STRING> (Optional) Hex color for the dialogue text (default: "").
 * 7: _is3D <BOOLEAN> (Optional) Whether to play audio in 3D space (default: true).
 * 8: _volume <SCALAR> (Optional) Audio volume from 0 to 1 (default: 1).
 * 9: _distance <SCALAR> (Optional) Maximum audible distance in meters for 3D audio (default: 100).
 *
 * Return value:
 * None
 *
 * Example:
 * private _segments = [
 *     ["Hey you! Stop right here!", getMissionPath "sounds\talk_1.ogg", ["Acts_PercMstpSlowWrflDnon_handup2c"]],
 *     ["Sergeant, a new recruit is here!", getMissionPath "sounds\talk_2.ogg", ["Acts_listeningToRadio_In", "Acts_listeningToRadio_Loop"]],
 *     ["Alright, go right there.", getMissionPath "sounds\talk_3.ogg", ["Acts_Pointing_Back"]]
 * ];
 * [allPlayers, _unit, getMissionPath "images\head.jpg", "Sgt. Miller", _segments] call ar_fnc_playSequence;
 *
 *
 * Public: Yes
 */

// Parse function parameters with default values and type checking
params [
	["_targets", objNull, [objNull, grpNull, []]],  // Target player(s) to display the talkbox to
	["_unit", objNull, [objNull]],                   // AI unit performing the dialogue
	["_customImage", "", [""]],                      // Portrait image path
	["_customName", "", [""]],                       // Custom display name
	["_segments", [["", "", []]], [[]]],             // Dialogue segments: [[text, audio, animations], ...]
	["_nameColor", "", [""]],                        // Hex color for unit name
	["_textColor", "", [""]],                        // Hex color for dialogue text
	["_is3D", true, [true]],                         // Play audio in 3D space
	["_volume", 1, [1]],                             // Audio volume (0-1)
	["_distance", 100, [100]]                        // Max audible distance in meters
];

// Start playing the first segment (index 0) via the recursive internal function
[0, _targets, _unit, _customImage, _customName, _segments, _nameColor, _textColor, _is3D, _volume, _distance] call AR_fnc_playNextSegment;
