/*
 * Authors: Archer
 * Description: Returns the animation duration of a current animation unit.
 *
 * Arguments:
 * 0: _animation <STRING> Name of the animation state in cfgMoves / States.
 *
 * Return Value:
 * _duration <SCALAR> Duration of the animation in seconds. Returns 0 if the speed is zero or if the animation is not found.
 *
 * Example:
 * ["AinvSrasWpstHnon"] call ar_fnc_getAnimationDuration
 *
 * Public: No
 */

params[
	["_animation", "", [""]]
]; // Parameter: animation name

private _animationDummy = createvehicle ["B_Soldier_F",[0,0,0],[],0,"none"]; // Create a dummy soldier
_animationDummy disableAI "ANIM"; // Disable automatic animation behavior
_animationDummy disableAI "target"; // Disable automatic targeting
_animationDummy disableAI "autotarget"; // Disable auto-targeting

_moves = gettext (configfile >> "cfgvehicles" >> typeof _animationDummy >> "moves"); // Retrieve the soldier moveset path
_cfgAnim = configfile >> _moves >> "States" >> _animation; // Access the animation state configuration

_speed = getnumber (_cfgAnim >> "speed"); // Read the animation speed from config
_duration = if (_speed != 0) then { abs (1 / _speed) } else { 0 }; // Calculate the duration in seconds, 0 if speed is zero
deleteVehicle _animationDummy; // Delete the dummy soldier

_duration; // Return the calculated duration
