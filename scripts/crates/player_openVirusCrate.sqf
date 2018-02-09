//by juandayz
private ["_hastool","_crate","_txt","_playerNear","_chance","_others","_buildables","_itemFoods","_itemMedicines","_itemWeapons","_ammo","_itemAmmo","_itemItems","_itemItems2"];
_hastool = false;
_crate = _this select 3;
player removeAction s_player_openViruscrate;
s_player_openViruscrate = -1;

if ("ItemCrowbar" in items player) then {_hastool = true;};

if !(_hastool) exitwith {"To open this package you need a Crowbar." call dayz_rollingMessages;};
_playerNear = {isPlayer _x} count (([player] call FNC_GetPos) nearEntities ["CAManBase",5]) > 1;
if (_playerNear) exitWith {localize "STR_EPOCH_PLAYER_84" call dayz_rollingMessages;};

_others = ["PartWheel","PartGlass","PartEngine","PartVRotor","CinderBlocks","50Rnd_127x107_DSHKM"]call BIS_fnc_selectRandom;
_buildables = ["CinderBlocks","MortarBucket","ItemDesertTent","ItemGenerator","equip_brick","equip_duct_tape","equip_rope","equip_hose","equip_lever","equip_nails","equip_metal_sheet","equip_1inch_metal_pipe","equip_2inch_metal_pipe","ItemWire","ItemTankTrap","ItemCorrugated","ItemPole"]call BIS_fnc_selectRandom;
_itemFoods= ["FoodBioMeat","FoodCandyAnders","FoodCandyChubby","FoodCandyMintception"]call BIS_fnc_selectRandom;
_itemMedicines= ["equip_woodensplint","ItemAntibiotic","equip_tin_powder","transfusionKit"]call BIS_fnc_selectRandom;
_itemItems= ["PipeBomb","ItemFuelBarrel","ItemJerryMixed","ItemGunRackKit","ItemOilBarrel"]call BIS_fnc_selectRandom;
_itemItems2= ["ItemGenerator","ItemSandbagExLarge5x","ItemLog","ItemBookBible"]call BIS_fnc_selectRandom;
_itemWeapons = ["RPK_DZ","M14_DZ","M24_DZ","M40A3_DZ","SVD_DZ","UZI_SD_EP1","MP5_DZ"]call BIS_fnc_selectRandom;
_ammo = getArray (configfile >> "cfgWeapons" >> _itemWeapons >> "magazines");
_itemAmmo = _ammo select 0;


["Working",0,[100,10,10,0]] call dayz_NutritionSystem;
[player,20,true,(getPosATL player)] spawn player_alertZombies;
player playActionNow "Medic";


if ([0.15] call fn_chance)  exitWith {
player switchMove "";
player playActionNow "putdown";
if (dayz_toolBreaking) then {
systemchat "Crowbar broken";
player removeweapon "ItemCrowbar";
player addweapon "ItemCrowbarBent";
};
	
r_player_blood = r_player_blood - 300;
player setHit["Hands",0.5];
"Holy shit!... Hurt my hand with the crowbar!" call dayz_rollingMessages;
};
[player,"chopwood",0,false] call dayz_zombieSpeak;
_crate setvariable ["isviralpackage",0,true];
sleep 1;
[_others,1,(round(random 4)*1)] call fn_dropItem;
[_buildables,1,(round(random 3)*2)] call fn_dropItem;
[_itemFoods,1,(round(random 4)*1)] call fn_dropItem;
[_itemMedicines,1,(round(random 4)*2)] call fn_dropItem;
[_itemItems2,1,1] call fn_dropItem;
[_itemItems,1,1] call fn_dropItem;
[_itemWeapons,2,1] call fn_dropItem;
[_itemAmmo,1,(round(random 3)*2)] call fn_dropItem;

if ([0.10] call fn_chance) then {

["ChainSawR",2,1] call fn_dropItem;
};
"In the package you can read: ARKOPHARMA Pharmaceutical property." call dayz_rollingMessages;

waitUntil {(player distance _crate) > 25};
deleteVehicle _crate;