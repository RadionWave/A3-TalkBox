// Déclare les paramètres de la fonction avec leurs valeurs par défaut
params [
	["_unit", objNull, [objNull]],                    // Unité (par défaut: objNull)
	["_text", "", [""]],                              // Texte du dialogue (par défaut: vide)
	["_nameOverride", "", [""]],                      // Nom personnalisé (par défaut: vide)
	["_customImage", "", [""]],                       // Image personnalisée (par défaut: vide)
	["_unitCustomColor", "", [""]],                   // Couleur de l'unité (par défaut: vide)
	["_textCustomColor", "", [""]]                    // Couleur du texte (par défaut: vide)
];

// Crée la boîte de dialogue RscTalkBox
cutRsc ["RscTalkBox", "PLAIN", -1, true, true];

// Récupère la boîte de dialogue depuis l'espace UI
private _display = uiNamespace getVariable ["RscTalkBox", displayNull];
// Récupère le contrôle image (ID: 6000)
private _displayControl = _display displayCtrl 6000;

// Vérifie si la boîte de dialogue existe
if(isNull _display)exitWith {
	diag_log "addDialog: No display found in uiNamespace";
};

// Vérifie si une unité est fournie
if(isNull _unit)exitWith {
	diag_log "addDialog: No unit passed to function";
};

// Récupère les contrôles image et texte
private _imageControl = _display displayCtrl 6000;
private _textControl = _display displayCtrl 6001;

// Récupère le nom de l'unité
private _unitName = name _unit;

// Utilise le nom personnalisé s'il est fourni
if(_nameOverride != "")then{
	_unitName = _nameOverride;
};

// Définit la couleur de l'unité selon son side si non spécifiée
if(_unitCustomColor == "")then{
	private _unitSide = side _unit;
	switch (_unitSide) do {
		case west: {_unitCustomColor = "#004C99";};        // Bleu (OTAN)
		case east: {_unitCustomColor = "#800000";};        // Rouge foncé (CSAT)
		case independent: {_unitCustomColor = "#008000";}; // Vert (AAF)
		case civilian: {_unitCustomColor = "#660080";};    // Violet (Civil)
		default {_unitCustomColor = "#B29900";};           // Doré (Défaut)
	};
};

// Affiche le texte formaté avec couleurs et polices
_textControl ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold'><t color='%1'>%2</t></t> : <t font='PuristaMedium'><t color='%3'>%4</t></t>", _unitCustomColor, _unitName, _textCustomColor, _text];
// Affiche l'image personnalisée
_imageControl ctrlSetText _customImage;
