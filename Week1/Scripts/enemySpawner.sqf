// Time interval between spawns (in seconds)
_spawnInterval = 240;  // Spawn enemies every 120 seconds



// Inline function for spawning infantry group
fnc_spawnInfantryGroup = {

    // Define the enemy composition (use unit classes for groups)
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

    // Create an empty group (squad)
    _group = createGroup east;
    _spawnPos = selectRandom [getMarkerPos "marker_5", getMarkerPos "marker_6"];
    _markerAI = getMarkerPos "marker_3";   // Marker for AI movement (AI move here)


    {
        _unitClass = _infantryUnit select _forEachIndex;  // Select the unit class by index
        _unit = _group createUnit [_unitClass, _spawnPos, [], 0, "NONE"];
        _unit setSkill 0.5;  // Set unit's skill level
    } forEach [0, 1, 2, 3, 4, 5, 6, 7]; // Index range for the 8 squad members

    // Set the group's behavior and assign the leader
    _leader = leader _group;
    _leader setSkill 0.6;

    // Move the leader to Marker3 (using waypoints)
    _waypoint = _group addWaypoint [_markerAI, 100];
    _waypoint setWaypointType "MOVE";
};

// Function to spawn vehicles and assign crews
fnc_spawnVehicles = {

    _vehicleClasses = [
        "CUP_O_BTR60_Green_RU",
        "CUP_O_MTLB_pk_WDL_RU", 
        "CUP_O_T72_RU"];

    
    // Randomly choose a vehicle class from the list (only one vehicle)
    _vehicleClass = selectRandom _vehicleClasses;
    
    // Spawn the vehicle at the given position
    _spawnPos = getMarkerPos "marker_4";
    _markerAI = getMarkerPos "marker_3";   // Marker for AI movement (AI move here)

    _vehicle = _vehicleClass createVehicle _spawnPos;
    
    // Set the vehicle's orientation to face south (180 degrees)
    _vehicle setDir 270;  // South direction
    
    // Automatically create a crew for the vehicle based on its side and faction
    _group = createVehicleCrew _vehicle;

    // Add the waypoint to the crew group (instead of individual crew members)
    _waypoint = _group addWaypoint [_markerAI, 100];  // Set the waypoint for the entire crew
    _waypoint setWaypointType "MOVE";  // Set the type of waypoint to "MOVE"
};

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
            _trigger = selectRandom [0, 1];
            if (0 == _trigger){
                call fnc_spawnInfantryGroup;
                call fnc_spawnInfantryGroup;
                call fnc_spawnVehicles;
                sleep 30;
                call fnc_spawnInfantryGroup;
            };
        };
    };

    // Wait for the specified interval before the next spawn
    sleep _spawnInterval;
};
