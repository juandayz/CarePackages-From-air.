//by juandayz updated 01/06/2018

private ["_rand_player","_debug_marker","_loot","_loot_lists","_loot2","_loot3","_loot4","_hint","_positionp","_position","_waypointsrange","_aiskin","_plane_class","_boxtype","_loot_lists","_loot","_positionp","_this","_center_1","_unitGroup","_pilot","_carrier","_xpos","_ypos",
"_cor_y","_cor_x","_waypos1","_waypos2","_waypos3","_waypos4","_wp1","_wp2","_wp3","_wp4","_waypointend","_positiondrop","_box","_chute","_smoke","_positionarray"];


if ((count playableUnits) < 1) exitWith {};

_rand_player    = playableUnits call BIS_fnc_selectRandom;
_positionp = [_rand_player] call FNC_GetPos;

_waypointsrange = 50;//range to move
_aiskin = "Survivor2_DZ";
_plane_class = "AN2_DZ";
_boxtype = "Misc_cargo_cont_net1";


// Send message to users
_hint = parseText format["<t align='center' color='#31db3c' shadow='2' size='1.55'>NEW EVENT</t><br/><t align='center' color='#ffffff'>!SUPPLY CRATES!Civil Defense Drops some supply crates.</t>"];
RemoteMessage = ['hint', _hint];
publicVariable "RemoteMessage";


if (isNil "EPOCH_EVENT_RUNNING") then {
EPOCH_EVENT_RUNNING = false;
};
 
// Check for another event running
if (EPOCH_EVENT_RUNNING) exitWith {
diag_log("Event already running");
};

EPOCH_EVENT_RUNNING = true;

_this = createCenter west;
_center_1 = _this;
_unitGroup = createGroup _center_1;
//

//spawnai
_pilot = objNull;
_pilot = _unitGroup createUnit [_aiskin, [(_positionp select 0) + 90, (_positionp select 1) + 100], [], 1, "NONE"];
_pilot addEventHandler ["handleDamage", {false}];
[_pilot] joinSilent _unitGroup;

sleep 1;

_carrier =  createVehicle [_plane_class, [(_positionp select 0) + 50, (_positionp select 1) + 50],[], 0, "FLY"];
_carrier         setVehicleVarName "heli";
_carrier 		setFuel 1;
_carrier 		engineOn true;
_carrier 		setVehicleAmmo 1;
_carrier 		flyInHeight 150;
_carrier 		setVehicleLock "LOCKED";
_carrier 		addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
_carrier addEventHandler ["handleDamage", {false}];

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_carrier];
_pilot 	assignAsDriver _carrier;
_pilot 	moveInDriver _carrier;



_xpos = _positionp select 0;
_ypos = _positionp select 1;
_cor_y = -20;
_cor_x = 20;


// These are 4 waypoints in a NorthSEW around the center
_waypos1 = [_xpos, _ypos+20, 0];
_waypos2 = [_xpos+20, _ypos, 0];
_waypos3 = [_xpos, _ypos-20, 0];
_waypos4 = [_xpos-20, _ypos, 0];

_wp1 = _unitGroup addWaypoint [[((_positionp select 0) + _cor_y),((_positionp select 1) + _cor_x),50],0];
_wp1   setWaypointType "MOVE";


_wp2 = _unitGroup addWaypoint [_waypos2, _waypointsrange];
_wp2 setWaypointType "MOVE";
_wp3 = _unitGroup addWaypoint [_waypos3, _waypointsrange];
_wp3 setWaypointType "MOVE";
_wp4 = _unitGroup addWaypoint [_waypos4, _waypointsrange];
_wp4 setWaypointType "MOVE";
_waypointend = _unitGroup addWaypoint [[_xpos,_ypos, 0], _waypointsrange];
_waypointend setWaypointType "CYCLE";





_positiondrop = [(_positionp select 0) + 50, (_positionp select 1) + 50,25];
_box = _boxtype createVehicle _positiondrop;
_box setvariable ["ispackage",1,true];
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_box]; 



_chute = createVehicle ["ParachuteMediumEast", getPos _box, [], 0, "FLY"];
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_chute]; 
_box attachTo [_chute, [0,0,3]];

if (sunOrMoon == 1) then {
_smoke = "SmokeShellYellow" createVehicle (getPos _box);
}else{
_smoke = "RoadFlare" createVehicle (getPos _box);
PVDZ_obj_RoadFlare = [_smoke,0];
publicVariable "PVDZ_obj_RoadFlare";
};


dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_smoke]; 
_smoke attachTo [_box, [0,0,0]];
_box addEventHandler ["handleDamage", {false}];


EPOCH_EVENT_RUNNING = false;

sleep 60;

deleteVehicle _carrier;
deleteVehicle _pilot;