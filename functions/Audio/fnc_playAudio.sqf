/*
 * Authors: Archer
 * Description: Plays a sound for a unit, either in 3D space or as UI sound.
 *
 * Arguments:
 * 0: _unit <OBJECT> Unit to play sound from (3D mode only)
 * 1: _sound <STRING> Sound classname to play
 * 2: _is3D <BOOLEAN> Whether to play sound in 3D space (default: true)
 * 3: _volume <SCALAR> Volume level 0-1 (default: 1)
 * 4: _distance <SCALAR> Max distance for 3D sound (default: 100)
 *
 * Return Value:
 * _soundDuration <SCALAR> Duration of the sound in seconds
 *
 * Example:
 * [_unit, getMissionPath "sounds\voiceline_1.ogg", true, 1, 100] call ar_fnc_playAudio;
 *
 * Public: Yes
 */


// Parse function arguments with default values
params [
	["_unit", objNull, [objNull]],
	["_sound", "", [""]],
	["_is3D", true, [true]],
	["_volume", 1, [1]],
	["_distance", 100, [100]]
];

// Initialize variables
private _soundID = nil;
private _soundDuration = 0;

// Exit if no unit was provided
if (isNull _unit) exitWith {
	diag_log "playAudio: No unit passed to function";
};

// Play sound either in 3D space or as UI sound
if(_is3D) then {
	_soundID = playSound3D [_sound, _unit, false, getPosASL _unit, _volume, 1, _distance];
} else {
	_soundID = playSoundUI [_sound, _volume];
};

// Get the duration of the sound from sound parameters
_soundDuration = (soundParams _soundID) select 2;

// Return the sound duration
_soundDuration;
