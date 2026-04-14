/*
 * Authors: Archer
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

if (isNull _unit) exitWith {0}; // If the unit is null, exit the function and return 0

_unit disableAI "ANIM"; // Disable the unit's AI to allow animations to play without interruption
private _totalDuration = 0; // Initialize total duration variable
{
		private _currentAnimation = _x; // Get the current animation from the list
		private _animationDuration = [_currentAnimation] call AR_fnc_getAnimationDuration; // Get the duration of the current animation using the previously defined function
		_totalDuration = _totalDuration + _animationDuration; // Add the duration of the current animation to the total duration
}forEach _animationList;



[_animationList,_unit] spawn { // Spawn a new thread to play the animations sequentially
	params["_animationList","_unit"];
	{
		private _currentAnimation = _x;
		private _animationDuration = [_currentAnimation] call AR_fnc_getAnimationDuration;
		_unit switchMove _currentAnimation;
		_unit playMoveNow _currentAnimation;
		sleep _animationDuration; // Wait for the duration of the current animation before playing the next one
	}forEach _animationList;
};

_totalDuration; // Return the total duration of all animations in seconds
