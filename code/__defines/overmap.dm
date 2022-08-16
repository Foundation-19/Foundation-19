#define SHIP_SIZE_TINY	1
#define SHIP_SIZE_SMALL	2
#define SHIP_SIZE_LARGE	3

//multipliers for max_speed to find 'slow' and 'fast' speeds for the ship
#define SHIP_SPEED_SLOW  1/(40 SECONDS)
#define SHIP_SPEED_FAST  1/(5 SECONDS)

#define OVERMAP_WEAKNESS_NONE       0
#define OVERMAP_WEAKNESS_FIRE       (1<<0)
#define OVERMAP_WEAKNESS_EMP        (1<<1)
#define OVERMAP_WEAKNESS_MINING     (1<<2)
#define OVERMAP_WEAKNESS_EXPLOSIVE  (1<<3)
#define OVERMAP_WEAKNESS_DROPPOD    (1<<4)
