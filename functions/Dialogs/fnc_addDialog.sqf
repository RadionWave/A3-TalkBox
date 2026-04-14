/*
 * Author: RadionWave
 * Description: Adds a dialog entry to the RscTalkBox dialog.
 *
 * Arguments:
 * 0: _unit <OBJECT> Source unit of the dialog.
 * 1: _text <STRING> Text to display.
 * 2: _nameOverride <STRING> Custom name to display instead of the unit's name.
 * 3: _customImage <STRING> Path or identifier of the custom image.
 * 4: _unitCustomColor <STRING> Custom color for the unit name.
 * 5: _textCustomColor <STRING> Custom color for the text.
 *
 * Return value:
 * None
 *
 * Example:
 * [_unit, "Good evening", "Chief", getMissionPath "Chief_HeadShot.jpg"] call fnc_addDialog;
 *
 * Public: Yes
 */

// Declare function parameters with their default values
params [
	["_unit", objNull, [objNull]],                    // Unit (default: objNull)
	["_text", "", [""]],                              // Dialog text (default: empty)
	["_nameOverride", "", [""]],                      // Custom name (default: empty)
	["_customImage", "", [""]],                       // Custom image (default: empty)
	["_unitCustomColor", "", [""]],                   // Unit color (default: empty)
	["_textCustomColor", "", [""]]                    // Text color (default: empty)
	["_duration", 0, [0]]                             // Auto-close duration in seconds (default: 0 = no auto-close)
];

private _layer = ["RscTalkBoxLayer"] call BIS_fnc_rscLayer;

// Create the RscTalkBox dialog
_layer cutRsc ["RscTalkBox", "PLAIN", -1, true, true];

// Get the dialog from the UI namespace
private _display = uiNamespace getVariable ["RscTalkBox", displayNull];
// Get the image control (ID: 6000)
private _displayControl = _display displayCtrl 6000;

// Check if the dialog exists
if(isNull _display)exitWith {
	diag_log "addDialog: No display found in uiNamespace";
};

// Check if a unit is provided
if(isNull _unit)exitWith {
	diag_log "addDialog: No unit passed to function";
};

// Get image and text controls
private _imageControl = _display displayCtrl 6000;
private _textControl = _display displayCtrl 6001;

// Get the unit name
private _unitName = name _unit;

// Use custom name if provided
if(_nameOverride != "")then{
	_unitName = _nameOverride;
};

// Set unit color based on side if not specified
if(_unitCustomColor == "")then{
	private _unitSide = side _unit;
	switch (_unitSide) do {
		case west: {_unitCustomColor = "#004C99";};        // Blue (NATO)
		case east: {_unitCustomColor = "#800000";};        // Dark red (CSAT)
		case independent: {_unitCustomColor = "#008000";}; // Green (AAF)
		case civilian: {_unitCustomColor = "#660080";};    // Purple (Civilian)
		default {_unitCustomColor = "#B29900";};           // Gold (Default)
	};
};

// Display formatted text with colors and fonts
_textControl ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold'><t color='%1'>%2</t></t> : <t font='PuristaMedium'><t color='%3'>%4</t></t>", _unitCustomColor, _unitName, _textCustomColor, _text];
// Display custom image
_imageControl ctrlSetText _customImage;

if (_duration > 0) then {
	_duration spawn {
		sleep _this;
		_layer cutRsc ["Default", "PLAIN", -1, true, true];
	};
};
