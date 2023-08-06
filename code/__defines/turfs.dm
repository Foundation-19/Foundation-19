#define TURF_REMOVE_CROWBAR     (1<<0)
#define TURF_REMOVE_SCREWDRIVER (1<<1)
#define TURF_REMOVE_SHOVEL      (1<<2)
#define TURF_REMOVE_WRENCH      (1<<3)
#define TURF_CAN_BREAK          (1<<4)
#define TURF_CAN_BURN           (1<<5)
#define TURF_HAS_EDGES  		(1<<6)
#define TURF_HAS_CORNERS		(1<<7)
#define TURF_HAS_INNER_CORNERS	(1<<8)
#define TURF_IS_FRAGILE         (1<<9)
#define TURF_ACID_IMMUNE        (1<<10)
#define TURF_IS_WET             (1<<11)
#define TURF_HAS_RANDOM_BORDER	(1<<12)
#define TURF_DISALLOW_BLOB		(1<<13)

//Used for floor/wall smoothing
#define SMOOTH_NONE 0	//Smooth only with itself
#define SMOOTH_ALL 1	//Smooth with all of type
#define SMOOTH_WHITELIST 2	//Smooth with a whitelist of subtypes
#define SMOOTH_BLACKLIST 3 //Smooth with all but a blacklist of subtypes

#define RANGE_TURFS(CENTER, RADIUS) block(locate(max(CENTER.x-(RADIUS), 1), max(CENTER.y-(RADIUS),1), CENTER.z), locate(min(CENTER.x+(RADIUS), world.maxx), min(CENTER.y+(RADIUS), world.maxy), CENTER.z))
