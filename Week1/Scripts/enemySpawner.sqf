// Time interval between spawns (in seconds)
_spawnInterval = 240;



// Inline function for spawning infantry group
fnc_spawnInfantryGroup = {

_infantryUnit = [
    "CUP_O_RU_Soldier_SL_VDV_EMR",
    "CUP_O_RU_Medic_VDV_EMR",
    "CUP_O_RU_Soldier_AR_VDV_EMR",
    "CUP_O_RU_Soldier_GL_VDV_EMR",
    "CUP_O_RU_Soldier_Saiga_VDV_EMR",
    "CUP_O_RU_solider_TL_VDV_EMR",
    "CUP_O_RU_Soldier_AT_VDV_EMR",
    "CUP_O_RU_Soldier_VDV_EMR"
];

    _group = createGroup east;
    _spawnPos = selectRandom [getMarkerPos "marker_5", getMarkerPos "marker_6"];
    _markerAI = getMarkerPos "marker_3"; 


    {
        _unitClass = _infantryUnit select _forEachIndex;
        _unit = _group createUnit [_unitClass, _spawnPos, [], 0, "NONE"];
        _unit setSkill 0.5; 
    } forEach [0, 1, 2, 3, 4, 5, 6, 7]; // Index range for the 8 squad members

    _leader = leader _group;
    _leader setSkill 0.6;

    _waypoint = _group addWaypoint [_markerAI, 100];
    _waypoint setWaypointType "MOVE";
};

// Function to spawn vehicles and assign crews
fnc_spawnVehicles = {

    _vehicleClasses = [
        "CUP_O_BTR60_Green_RU",
        "CUP_O_MTLB_pk_WDL_RU", 
        "CUP_O_T72_RU"];

    
    _vehicleClass = selectRandom _vehicleClasses;
    
    
    _spawnPos = getMarkerPos "marker_4";
    _markerAI = getMarkerPos "marker_3";  

    _vehicle = _vehicleClass createVehicle _spawnPos;

    _vehicle setDir 270;
    
    _group = createVehicleCrew _vehicle;

    _waypoint = _group addWaypoint [_markerAI, 100]; 
    _waypoint setWaypointType "MOVE";
};

// summons a flyby over the target
fnc_summonFlyBy = {
    _flybyStart = getMarkerPos "marker_7"; 
    _flyByEnd = getMarkerPos "marker_8"; 
    [_flyByStart, _flybyEnd, 60, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;
    sleep 5;
    [_flyByStart, _flybyEnd, 100, "FULL", "O_Plane_CAS_02_dynamicLoadout_F", east] call BIS_fnc_ambientFlyby;

}

// Function to spawn enemies at regular intervals
while {true} do {
    // Determine random chance for which type of enemies to spawn
    _spawnType = selectRandom [1, 2, 3, 4, 5];

    switch (_spawnType) do {
        case 1: {
            call fnc_spawnInfantryGroup;
        };
        case 2: {

            call fnc_spawnVehicles;
        };
        case 3: {
            call fnc_spawnInfantryGroup;
            call fnc_spawnVehicles;
        };
        case 4: {
            call fnc_spawnInfantryGroup;
            call fnc_spawnInfantryGroup;
        };
        case 5: {
            _trigger = selectRandom [0, 1, 2];
            if (0 == _trigger){
                call fnc_spawnInfantryGroup;
                call fnc_spawnInfantryGroup;
                call fnc_spawnVehicles;
                sleep 30;
                call fnc_spawnInfantryGroup;
            } else if (1 == _trigger){
                call fnc_summonFlyBy;
            };
        };
    };

    // Wait for the specified interval before the next spawn
    sleep _spawnInterval;
};
