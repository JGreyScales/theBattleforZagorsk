if (isServer) then {
    [west, 30] call BIS_fnc_respawnTickets;
    missionNamespace setVariable ["playersLeft", false];

    // Wait until all players are initialized and alive
    {
        waitUntil {!(isNull _x) && alive _x}; // Ensure player is loaded and alive
    } forEach allPlayers;

    sleep 120;
    execvm "enemySpawner.sqf";
} else {
    execvm "initPlayerLocal.sqf";
};

