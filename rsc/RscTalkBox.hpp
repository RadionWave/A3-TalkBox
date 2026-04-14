class RscTitles{
	class RscTalkBox
	{
		idd = -1;
		movingEnable = 1;
		duration = 60;
		fadein = 0.5;
		fadeout = 0.5;
		onLoad = "_this call ar_fnc_onLoad;"
		unLoad = "_this call ar_fnc_onUnload;";
		class ControlsBackground
		{
			class Border
			{
				type = 0;
				idc = -1;
				x = safeZoneX + safeZoneW * 0.234375;
				y = safeZoneY + safeZoneH * 0.81111112;
				w = safeZoneW * 0.54114584;
				h = safeZoneH * 0.12870371;
				style = 64;
				text = "";
				colorBackground[] = {0,0,0,1};
				colorText[] = {0,0,0,1};
				font = "PuristaMedium";
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
				
			};
			class Background
			{
				type = 0;
				idc = -1;
				x = safeZoneX + safeZoneW * 0.234375;
				y = safeZoneY + safeZoneH * 0.81111112;
				w = safeZoneW * 0.54114584;
				h = safeZoneH * 0.12870371;
				style = 0;
				text = "";
				colorBackground[] = {0,0,0,0.75};
				colorText[] = {1,1,1,1};
				font = "PuristaMedium";
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
				
			};
			class Picture : RscPicture
			{
				type = 0;
				idc = 6000;
				x = safeZoneX + safeZoneW * 0.24375;
				y = safeZoneY + safeZoneH * 0.825;
				w = safeZoneW * 0.053125;
				h = safeZoneH * 0.1;
				style = 48;
				text = "a3\missions_f_orange\data\img\orange_compositions\s4+s5\s5_drawings_09_co.paa";
				colorBackground[] = {0,0,0,1};
				colorText[] = {1,1,1,1};
				font = "PuristaMedium";
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
				
			};
			class TextBox
			{
				type = 13;
				idc = 6001;
				x = safeZoneX + safeZoneW * 0.30416667;
				y = safeZoneY + safeZoneH * 0.82962963;
				w = safeZoneW * 0.4640625;
				h = safeZoneH * 0.0962963;
				style = 16;
				text = "";
				size = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
				colorBackground[] = {1,1,1,0};
				class Attributes
				{
					
				};
				
			};
			
		};
		class Controls
		{
			
		};
	};
};