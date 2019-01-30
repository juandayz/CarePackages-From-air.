//by juandayz
private ["_crate","_txt","_playerNear","_hastool","_chance","_itemFoods","_itemMedicines","_itemWeapons","_ammo","_itemAmmo","_itemTools","_country"];
_hastool = false;
_crate = _this select 3;
player removeAction s_player_opencrate;
s_player_opencrate = -1;

if (("ItemCrowbar" in items player) or ("MeleeCrowbar" in weapons player)) then {_hastool = true;};

if !(_hastool) exitwith {"To open this package you need a Crowbar." call dayz_rollingMessages;};
_playerNear = {isPlayer _x} count (([player] call FNC_GetPos) nearEntities ["CAManBase",5]) > 1;
if (_playerNear) exitWith {localize "STR_EPOCH_PLAYER_84" call dayz_rollingMessages;};
	
_itemFoods= ["FoodCanRusUnlabeled","FoodCanUnlabeled","FoodMRE"]call BIS_fnc_selectRandom;
_itemMedicines= ["ItemWaterbottle","ItemAntibiotic","ItemAntibacterialWipe","ItemBloodBag"]call BIS_fnc_selectRandom;
_itemTools= ["ItemMatchbox","ItemEtool","ItemHatchet","ItemKnife"]call BIS_fnc_selectRandom;
_itemWeapons = ["G36C_DZ","M4A1_HWS_GL_camo","SCAR_L_CQC_CCO_SD","SCAR_L_STD_EGLM_RCO","M249_DZ","Mk48_CCO_DZ"]call BIS_fnc_selectRandom;
_ammo = getArray (configfile >> "cfgWeapons" >> _itemWeapons >> "magazines");
_itemAmmo = _ammo select 0;


["Working",0,[100,10,10,0]] call dayz_NutritionSystem;
[player,20,true,(getPosATL player)] spawn player_alertZombies;
player playActionNow "Medic";


if ([0.15] call fn_chance)  exitWith {
player switchMove "";
player playActionNow "putdown";
if (dayz_toolBreaking) then {
player removeweapon "ItemCrowbar";
player addweapon "ItemCrowbarBent";
systemchat "Crowbar broken";
};
	
r_player_blood = r_player_blood - 300;
player setHit["Hands",0.5];
"Holy shit!... Hurt my hand with the crowbar!" call dayz_rollingMessages;
};
[player,"chopwood",0,false] call dayz_zombieSpeak;
_crate setvariable ["ispackage",0,true];
sleep 1;

[_itemFoods,1,(round(random 4)*1)] call fn_dropItem;
[_itemMedicines,1,(round(random 4)*2)] call fn_dropItem;
[_itemWeapons,2,1] call fn_dropItem;
[_itemAmmo,1,(round(random 3)*2)] call fn_dropItem;

if ([0.10] call fn_chance) then {
["Skin_Assistant_DZ",1,1] call fn_dropItem;
[_itemTools,2,1] call fn_dropItem;
};

_country= ["Italy","Spain","France","England","Germany","Argentine","Brazil","Canada","Mexico","United States","Nigeria","Russia","Japan","Israel","Egypt","Australia","New Zeland"]call BIS_fnc_selectRandom;
Format ["In the package you can read: Humanitarian Aid from %1.", _country] call dayz_rollingMessages;

waitUntil {(player distance _crate) > 25};
deleteVehicle _crate;
