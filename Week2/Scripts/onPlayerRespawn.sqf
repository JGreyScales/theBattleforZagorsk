_respawnTickets = [west] call BIS_fnc_respawnTickets;

if (_respawnTickets <= 1) then {
    ["EveryoneLost"] call BIS_fnc_endMissionServer;
} else {
    [west, "HQ"] sideChat format ["Respawns left: %1", _respawnTickets];
};
