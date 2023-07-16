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

// Subsystem init_order, from highest priority to lowest priority
// Subsystems shutdown in the reverse of the order they initialize in
// The numbers just define the ordering, they are meaningless otherwise.

#define SS_INIT_EARLY            100
#define SS_INIT_INPUT            99
#define SS_INIT_GARBAGE          95
#define SS_INIT_BCCM             94
#define SS_INIT_DBCORE           90
#define SS_INIT_CHEMISTRY        80
#define SS_INIT_MATERIALS        75
#define SS_INIT_PLANTS           70
#define SS_INIT_ANTAGS           65
#define SS_INIT_CULTURE          60
#define SS_INIT_MISC             55
#define SS_INIT_SKYBOX           50
#define SS_INIT_STATION          45
#define SS_INIT_MAPPING          40
#define SS_INIT_JOBS             35
#define SS_INIT_JOBTIME			 30
#define SS_INIT_CHAR_SETUP       25
#define SS_INIT_CIRCUIT          20
#define SS_INIT_GRAPH            15
#define SS_INIT_OPEN_SPACE       10
#define SS_INIT_ATOMS            8
#define SS_INIT_MACHINES         6
#define SS_INIT_ICON_UPDATE      4
#define SS_INIT_OVERLAY          2
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
#define SS_INIT_EXPLOSIONS      -69
#define SS_INIT_STATPANELS      -80
#define SS_INIT_CHAT            -90 // Should be lower to ensure chat remains smooth during init.
#define SS_INIT_UNIT_TESTS      -100

// SS runlevels

#define RUNLEVEL_INIT 		0
#define RUNLEVEL_LOBBY 		(1<<0)
#define RUNLEVEL_SETUP 		(1<<1)
#define RUNLEVEL_GAME 		(1<<2)
#define RUNLEVEL_POSTGAME 	(1<<3)

#define RUNLEVELS_DEFAULT (RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME)

// Explosion Subsystem subtasks
#define SSEXPLOSIONS_MOVABLES 1
#define SSEXPLOSIONS_TURFS    2
#define SSEXPLOSIONS_THROWS   3
