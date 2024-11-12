[west, "HQ"] sideChat "5 MINUTES BEFORE THE ATTACK";
[west, "HQ"] sideChat "Mission will fail if all players die! Hold out for 40 minutes.";
if (isServer) then {
    [west, 7] call BIS_fnc_respawnTickets;

    // Wait until all players are initialized and alive
    {
        waitUntil {!(isNull _x) && alive _x}; // Ensure player is loaded and alive
    } forEach allPlayers;

    sleep 12;
    execvm "wintimer.sqf";

    _flybyStart = getMarkerPos "marker_7"; 
    _flyByEnd = getMarkerPos "marker_8"; 
    [_flyByStart, _flybyEnd, 60, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;
    sleep 5;
    [_flyByStart, _flybyEnd, 100, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;


    sleep 300;

    // flight returns home
    [_flybyEnd, _flyByStart , 60, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;
    sleep 5;
    [_flybyEnd , _flyByStart, 100, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;


    execvm "enemySpawner.sqf"
} else {
    execvm "initPlayerLocal.sqf";
};

