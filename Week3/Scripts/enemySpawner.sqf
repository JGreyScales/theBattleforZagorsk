// Time interval between spawns (in seconds)
_spawnInterval = 180;



// Inline function for spawning infantry group
fnc_spawnInfantryGroup = {

_infantryUnit = [
    "CUP_O_RU_Soldier_SL_VDV_EMR",
    "CUP_O_RU_Soldier_VDV_EMR"
];

    _group = createGroup east;
    _spawnPos = getMarkerPos "marker_5";
    _markerAI = position leader PlayerGroup; 


    {
        _unitClass = _infantryUnit select _forEachIndex;
        _unit = _group createUnit [_unitClass, _spawnPos, [], 0, "NONE"];
        _unit setSkill 0.5; 
    } forEach [0, 1]; // Index range for the 8 squad members

    _leader = leader _group;
    _leader setSkill 0.6;

    _waypoint = _group addWaypoint [_markerAI, 100];
    _waypoint setWaypointType "MOVE";
};

// Function to spawn vehicles and assign crews
fnc_spawnVehicles = {

    _vehicleClasses = [
        "CUP_O_BTR60_Green_RU",
        "CUP_O_MTLB_pk_WDL_RU"];

    
    _vehicleClass = selectRandom _vehicleClasses;
    
    
    _spawnPos = getMarkerPos "marker_6";
    _markerAI = position leader PlayerGroup; 

    _vehicle = _vehicleClass createVehicle _spawnPos;

    _vehicle setDir 270;
    
    _group = createVehicleCrew _vehicle;

    _waypoint = _group addWaypoint [_markerAI, 100]; 
    _waypoint setWaypointType "MOVE";
};

// Function to spawn enemies at regular intervals
while {true} do {

    call fnc_spawnInfantryGroup;

    // Wait for the specified interval before the next spawn
    sleep _spawnInterval;
};



