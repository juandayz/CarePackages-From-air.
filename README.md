# CarePackages-From-air.

PLEASE DONATE:https://github.com/juandayz/CarePackages-From-air./blob/master/DONATION.md


Two Events who choose randomplayers to drop some carepackeges from air.

Players Needs a crowbar to open the pakages.

The packages are not the normals crates.



+***INSTALL:***

1.A.Drop server_crates2.sqf and server_crates3.sqf into dayz_server.pbo\modules\

1.B.Drop crates folder into Mpmissions\yourinstance map\scripts\

2.Open your init.sqf to add the events.

```ruby
EpochUseEvents = true;
EpochEvents = [["any","any","any","any",30,"server_crates2"],["any","any","any","any",40,"server_crates3"]];
```

3.Open your custom fn_selfactions.sqf and find:

```
//Towing with tow truck
	/*
	if(_typeOfCursorTarget == "TOW_DZE") then {
		if (s_player_towing < 0) then {
			if(!(_cursorTarget getVariable ["DZEinTow", false])) then {
				s_player_towing = player addAction [localize "STR_EPOCH_ACTIONS_ATTACH" "\z\addons\dayz_code\actions\tow_AttachStraps.sqf",_cursorTarget, 0, false, true];				
			} else {
				s_player_towing = player addAction [localize "STR_EPOCH_ACTIONS_DETACH", "\z\addons\dayz_code\actions\tow_DetachStraps.sqf",_cursorTarget, 0, false, true];				
			};
		};
	} else {
		player removeAction s_player_towing;
		s_player_towing = -1;
	};
	*/
  ```
  Below paste:
  
  ```ruby
//player open crates
if ((_cursorTarget isKindOf "USOrdnanceBox")or(_cursorTarget isKindOf "Misc_cargo_cont_net1")&&(_cursorTarget getVariable ["ispackage",0] == 1) or (_cursorTarget isKindOf "MAP_Misc_cargo_cont_small2")&&(_cursorTarget getVariable ["isviralpackage",0] == 1)) then {
if (s_player_flipcrate < 0) then {
s_player_flipcrate = player addAction ["PushCrate", "scripts\crates\player_flipcrate.sqf",_cursorTarget,0, false,true];	
};
}else{
player removeAction s_player_flipcrate;
s_player_flipcrate = -1;
};
if ((_cursorTarget isKindOf "Misc_cargo_cont_net1")&&(_cursorTarget getVariable ["ispackage",0] == 1)) then {
if (s_player_opencrate < 0) then {
s_player_opencrate = player addAction ["Open Crate", "scripts\crates\player_openCrate.sqf",_cursorTarget,0, false,true];	
};
} else {
player removeAction s_player_opencrate;
s_player_opencrate = -1;
};		
//player open Viruscrates
if ((_cursorTarget isKindOf "MAP_Misc_cargo_cont_small2")&&(_cursorTarget getVariable ["isviralpackage",0] == 1)) then {
if (s_player_openViruscrate < 0) then {
s_player_openViruscrate = player addAction ["Open Crate", "scripts\crates\player_openVirusCrate.sqf",_cursorTarget,0, false,true];	
};
} else {
player removeAction s_player_openViruscrate;
s_player_openViruscrate = -1;
};		
```

Find:
```
	player removeAction s_player_fuelauto;
	s_player_fuelauto = -1;
	player removeAction s_player_fuelauto2;
	s_player_fuelauto2 = -1;
	player removeAction s_player_manageDoor;
	s_player_manageDoor = -1;
```
below add:
```ruby
player removeAction s_player_flipcrate;
s_player_flipcrate = -1;
player removeAction s_player_opencrate;
s_player_opencrate = -1;
player removeAction s_player_openViruscrate;
s_player_openViruscrate = -1;
```
4.Open your custom variables.sqf and add:
```ruby
s_player_flipcrate = -1;
s_player_opencrate = -1;
s_player_openViruscrate = -1;
```
with the rest of actions.

5.Infistar Users. Add:
```ruby
"_player_flipcrate","s_player_opencrate","s_player_openViruscrate"
```
With the rest of your allowed actions.
