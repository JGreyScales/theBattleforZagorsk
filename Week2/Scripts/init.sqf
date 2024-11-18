if (isServer) then {
    [west, 12] call BIS_fnc_respawnTickets;
    [getMarkerPos "centerPos", 2500, 6, []] call BIS_fnc_destroyCity;
    [getMarkerPos "centerPos", 2500, 10, []] call BIS_fnc_destroyCity;
    [getMarkerPos "centerPos", 2500, 1147, []] call BIS_fnc_destroyCity;

    missionNamespace setVariable ["OBJ1", false];
    missionNamespace setVariable ["OBJ2", false];
    missionNamespace setVariable ["OBJ3", false];
    // Wait until all players are initialized and alive
    {
        waitUntil {!(isNull _x) && alive _x}; // Ensure player is loaded and alive
    } forEach allPlayers;
    
    execvm "enemySpawner.sqf"
} else {
    execvm "initPlayerLocal.sqf";
};

