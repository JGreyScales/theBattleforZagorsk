_respawnTickets = [west] call BIS_fnc_respawnTickets;

_playerCount = allPlayers select {side _x == west};
_alivePlayers = _playerCount count {alive _x};

if (_respawnTickets <= 1 && (0 == _alivePlayers)) then {
    ["EveryoneLost"] call BIS_fnc_endMissionServer;
}
