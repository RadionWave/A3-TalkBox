/*
 * Authors: Archer
 * Description: Retourne la durée d'animation d'un état de mouvement pour un soldat.
 *
 * Arguments:
 * 0: _animation <STRING> Nom de l'état d'animation dans cfgMoves / States.
 *
 * Return Value:
 * _duration <SCALAR> Durée de l'animation en secondes. Retourne 0 si la vitesse est nulle ou si l'animation est introuvable.
 *
 * Example:
 * ["AinvSrasWpstHnon"] call ar_fnc_getAnimationDuration
 *
 * Public: No
 */

params[
	["_animation", "", [""]]
]; // Paramètre : nom de l'animation

private _animationDummy = createvehicle ["B_Soldier_F",[0,0,0],[],0,"none"]; // Crée un soldat factice
_animationDummy disableAI "ANIM"; // Désactive le comportement d'animation automatique
_animationDummy disableAI "target"; // Désactive la cible automatique
_animationDummy disableAI "autotarget"; // Désactive l'autociblage

_moves = gettext (configfile >> "cfgvehicles" >> typeof _animationDummy >> "moves"); // Récupère le chemin du moveset du soldat
_cfgAnim = configfile >> _moves >> "States" >> _animation; // Accède à la configuration de l'état d'animation

_speed = getnumber (_cfgAnim >> "speed"); // Lit la vitesse de l'animation depuis la config
_duration = if (_speed != 0) then { abs (1 / _speed) } else { 0 }; // Calcule la durée en secondes, 0 si vitesse nulle
deleteVehicle _animationDummy; // Supprime le soldat factice

_duration; // Retourne la durée calculée
