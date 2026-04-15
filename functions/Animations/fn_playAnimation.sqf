/*
 * Authors: RadionWave
 * Function that plays a list of animations on a unit sequentially. The total duration of all animations is returned.
 *
 * Arguments:
 * 0: _unit (default: objNull) <OBJECT>
 * 1: _animationList (default: []) <ARRAY>
 *
 * Return Value:
 * Total duration of all animations in seconds <SCALAR>
 *
 * Example:
 * [_unit,_animationList] call AR_fnc_playAnimation
 *
 * Public: Yes
 */
params [
	["_unit", objNull, [objNull]],
	["_animationList", [], [[]]]
];

if (isNull _unit) exitWith {
	diag_log "playAnimation: No unit passed to function";
};

if (!(alive _unit)) exitWith {
	diag_log "playAnimation: Cannot play animation from a dead unit";
};

if (lifeState _unit == "INCAPACITATED") exitWith {
	diag_log "playAnimation: Cannot play animation from an incapacitated unit";
};

_unit disableAI "ANIM"; // Disable the unit's AI to allow animations to play without interruption
private _totalDuration = 0; // Initialize total duration variable
{
		private _currentAnimation = _x; // Get the current animation from the list
		private _animationDuration = [_currentAnimation] call AR_fnc_getAnimationDuration; // Get the duration of the current animation using the previously defined function
		_totalDuration = _totalDuration + _animationDuration; // Add the duration of the current animation to the total duration
}forEach _animationList;

{
	private _currentAnimation = _x;
	private _currentIndex = _forEachIndex; // Get the index of the current animation in the list
	private _animationDuration = [_currentAnimation] call AR_fnc_getAnimationDuration;
	
	if(_currentIndex == 0) then {
		_unit switchMove [_currentAnimation];
	}else{
		_unit playMove _currentAnimation;
	};

}forEach _animationList;


_totalDuration; // Return the total duration of all animations in seconds
