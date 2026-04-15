/*
 * Author: RadionWave
 * Description: Internal recursive function that plays a single dialogue segment and schedules the next one.
 *              Called by AR_fnc_playSequence — do not call directly.
 *
 * Arguments:
 * 0: _index <SCALAR> Current segment index in the sequence.
 * 1: _targets <OBJECT, GROUP, ARRAY> Target player(s) who will see the talkbox.
 * 2: _unit <OBJECT> The AI unit performing the dialogue.
 * 3: _customImage <STRING> Path to the portrait image displayed in the talkbox.
 * 4: _customName <STRING> Custom name to display instead of the unit's in-game name.
 * 5: _segments <ARRAY> Array of dialogue segments. Each segment is an array: [text <STRING>, audioFilePath <STRING>, animationSequence <ARRAY>].
 * 6: _nameColor <STRING> Hex color for the unit name.
 * 7: _textColor <STRING> Hex color for the dialogue text.
 * 8: _is3D <BOOLEAN> Whether to play audio in 3D space.
 * 9: _volume <SCALAR> Audio volume from 0 to 1.
 * 10: _distance <SCALAR> Maximum audible distance in meters for 3D audio.
 *
 * Return value:
 * None
 *
 * Example:
 * [0, _targets, _unit, _customImage, _customName, _segments, _nameColor, _textColor, _is3D, _volume, _distance] call ar_fnc_playNextSegment;
 *
 *
 * Public: No
 */

// Parse function parameters with default values and type checking
params [
	["_index", 0, [0]],                             // Current segment index
	["_targets", objNull, [objNull, grpNull, []]],   // Target player(s) to display the talkbox to
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

// Stop recursion if we have played all segments
if (_index >= count _segments) exitWith {};

// Get the current segment from the array
private _currentSegment = _segments select _index;

// Parse the segment's sub-parameters: dialogue text, audio file path, and animation list
_currentSegment params [
	["_dialogueText", "", [""]],                     // Text to display in the talkbox
	["_audioFilePath", "", [""]],                    // Path to the audio file to play
	["_animationSequence", [], [[]]]                 // Array of animation class names to play sequentially
];

// Play the animation sequence on the unit and get total duration
private _animationDuration = [_unit, _animationSequence] call AR_fnc_playAnimation;

// Play the audio from the unit and get the sound duration
private _audioDuration = [_unit, _audioFilePath, _is3D, _volume, _distance] call AR_fnc_playAudio;

// Calculate the delay before the next segment (wait for the longest action to finish)
private _delayBetweenSegments = _animationDuration max _audioDuration;

// Determine the talkbox auto-close duration:
// - Last segment: close after the delay (animation/audio finished)
// - Intermediate segments: no auto-close (the next segment's talkbox replaces it)
private _dialogueDuration = 0;

if (_index >= (count _segments) - 1) then {
	_dialogueDuration = _delayBetweenSegments;
} else {
	_dialogueDuration = 0;
};

// Display the talkbox with the current segment's text
[_targets, _unit, _dialogueText, _customImage, _customName, _dialogueDuration, _nameColor, _textColor] call AR_fnc_showDialogue;

// Schedule the next segment after the current one finishes
[{
	_this call ar_fnc_playNextSegment;
}, [_index + 1, _targets, _unit, _customImage, _customName, _segments, _nameColor, _textColor, _is3D, _volume, _distance], _delayBetweenSegments] call CBA_fnc_waitAndExecute;
