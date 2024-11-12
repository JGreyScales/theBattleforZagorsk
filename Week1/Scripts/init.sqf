_playerCount = count allPlayers;
[west, 47 - (5 * _PlayerCount)] call BIS_fnc_respawnTickets;
execvm "initPlayerLocal.sqf";

sleep 12;
execvm "wintimer.sqf";
[west, "HQ"] sideChat "5 MINUTES BEFORE THE ATTACK";


_flybyStart = getMarkerPos "marker_7"; 
_flyByEnd = getMarkerPos "marker_8"; 
[_flyByStart, _flybyEnd, 60, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;
sleep 5;
[_flyByStart, _flybyEnd, 100, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;


sleep 300;

// flight returns home

_flybyStart = getMarkerPos "marker_7"; 
_flyByEnd = getMarkerPos "marker_8"; 
[_flybyEnd, _flyByStart , 60, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;
sleep 5;
[_flybyEnd , _flyByStart, 100, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;


execvm "enemySpawner.sqf"