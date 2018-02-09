private ["_crate","_mypos","_dir"];
player playMove "amovpknlmstpslowwrfldnon_amovpercmstpsraswrfldnon";
waitUntil { animationState player != "amovpknlmstpslowwrfldnon_amovpercmstpsraswrfldnon"};

_crate = _this select 3;
_mypos = getposATL player;
_dir = getdir player;
_mypos = [(_mypos select 0)+3*sin(_dir),(_mypos select 1)+3*cos(_dir), (_mypos select 2)];
_crate setDir _dir;
_crate setposATL _mypos;