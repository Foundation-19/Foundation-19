/// Turf will be passable if density is 0
#define TURF_PATHING_PASS_DEFAULT 0
/// Turf will be passable depending on [CanPathingPass] return value
#define TURF_PATHING_PASS_PROC 1
/// Turf is never passable
#define TURF_PATHING_PASS_NO 2

// Define set that decides how an atom will be scanned for pathfinding
/// If set, we make the assumption that CanPathingPass() will NEVER return FALSE unless density is true
#define CANPATHINGPASS_DENSITY 0
/// If this is set, we bypass density checks and always call the proc
#define CANPATHINGPASS_ALWAYS_PROC 1
