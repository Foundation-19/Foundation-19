#define INITIALIZATION_INSSATOMS      0	//New should not call Initialize
#define INITIALIZATION_INSSATOMS_LATE 1	//New should not call Initialize; after the first pass is complete (handled differently)
#define INITIALIZATION_INNEW_MAPLOAD  2	//New should call Initialize(TRUE)
#define INITIALIZATION_INNEW_REGULAR  3	//New should call Initialize(FALSE)

#define INITIALIZE_HINT_NORMAL   0  //Nothing happens
#define INITIALIZE_HINT_LATELOAD 1  //Call LateInitialize
#define INITIALIZE_HINT_QDEL     2  //Call qdel on the atom

//! ## DB defines
/**
 * DB major schema version
 *
 * Update this whenever the db schema changes
 *
 * make sure you add an update to the schema_version stable in the db changelog
 */
#define DB_MAJOR_VERSION 1

/**
 * DB minor schema version
 *
 * Update this whenever the db schema changes
 *
 * make sure you add an update to the schema_version stable in the db changelog
 */
#define DB_MINOR_VERSION 0

//type and all subtypes should always call Initialize in New()
#define INITIALIZE_IMMEDIATE(X) ##X/New(loc, ...){\
	..();\
	if(!(atom_flags & ATOM_FLAG_INITIALIZED)) {\
		args[1] = TRUE;\
		SSatoms.InitAtom(src, args);\
	}\
}

#define INIT_SKIP_QDELETED if (. == INITIALIZE_HINT_QDEL) {\
return;\
}

#define INIT_DISALLOW_TYPE(path) if (type == path) {\
. = INITIALIZE_HINT_QDEL;\
crash_with("disallowed type [type] created");\
return;\
}


// Subsystem init_order, from highest priority to lowest priority
// Subsystems shutdown in the reverse of the order they initialize in
// The numbers just define the ordering, they are meaningless otherwise.

#define SS_INIT_EARLY            100
#define SS_INIT_INPUT            99
#define SS_INIT_GARBAGE          95
#define SS_INIT_DBCORE           90
#define SS_INIT_CHEMISTRY        18
#define SS_INIT_MATERIALS        17
#define SS_INIT_PLANTS           16
#define SS_INIT_ANTAGS           15
#define SS_INIT_CULTURE          14
#define SS_INIT_MISC             13
#define SS_INIT_SKYBOX           12
#define SS_INIT_STATION          11
#define SS_INIT_MAPPING          10
#define SS_INIT_JOBS             9
#define SS_INIT_CHAR_SETUP       8
#define SS_INIT_CIRCUIT          7
#define SS_INIT_GRAPH            6
#define SS_INIT_OPEN_SPACE       5
#define SS_INIT_ATOMS            4
#define SS_INIT_MACHINES         3
#define SS_INIT_ICON_UPDATE      2
#define SS_INIT_OVERLAY          1
#define SS_INIT_DEFAULT          0
#define SS_INIT_AIR             -1
#define SS_INIT_ASSETS			-2
#define SS_INIT_MISC_LATE       -3
#define SS_INIT_MISC_CODEX      -4
#define SS_INIT_ALARM           -5
#define SS_INIT_SHUTTLE         -6
#define SS_INIT_GOALS           -7
#define SS_INIT_LIGHTING        -8
#define SS_INIT_ZCOPY           -9
#define SS_INIT_HOLOMAP         -10
#define SS_INIT_XENOARCH        -11
#define SS_INIT_BAY_LEGACY      -12
#define SS_INIT_TICKER          -20
#define SS_INIT_AI              -21
#define SS_INIT_AIFAST          -22
#define SS_INIT_STATPANELS      -80
#define SS_INIT_CHAT            -90 // Should be lower to ensure chat remains smooth during init.
#define SS_INIT_UNIT_TESTS      -100

// SS runlevels

#define RUNLEVEL_INIT 0
#define RUNLEVEL_LOBBY 1
#define RUNLEVEL_SETUP 2
#define RUNLEVEL_GAME 4
#define RUNLEVEL_POSTGAME 8

#define RUNLEVELS_DEFAULT (RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME)
