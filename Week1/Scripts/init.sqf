[west, 33] call BIS_fnc_respawnTickets;
execvm "initPlayerLocal.sqf";

sleep 12;
execvm "wintimer.sqf";
[west, "HQ"] sideChat "5 MINUTES BEFORE THE ATTACK";
sleep 300;
execvm "enemySpawner.sqf"