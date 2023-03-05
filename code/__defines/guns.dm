#define CALIBER_PISTOL 			"10mm"
#define CALIBER_PISTOL_SMALL 	"9mm"
#define CALIBER_PISTOL_MAGNUM 	".357"
#define CALIBER_PISTOL_FLECHETTE "4mm"
#define CALIBER_PISTOL_ANTIQUE	"~10mm"

#define CALIBER_REVOLVER 			".357 Magnum"
#define CALIBER_REVOLVER_SMALL 		".44 Magnum"
#define CALIBER_REVOLVER_MEDIUM 	".357 Special"
#define CALIBER_REVOLVER_HEAVY		".454 Casull"

#define CALIBER_RIFLE			"5mmR"
#define CALIBER_RIFLE_MILITARY	"7mmR"
#define CALIBER_T12				"10x24mmR"
#define CALIBER_ANTIMATERIAL	"15mmR"

#define CALIBER_SHOTGUN			"12g"
#define CALIBER_GYROJET			"20mmG"
#define CALIBER_CAPS			"caps"
#define CALIBER_DART			"darts"
#define CALIBER_ROCKET			"rocket"

#define HOLD_CASINGS	0 //do not do anything after firing. Manual action, like pump shotguns, or guns that want to define custom behaviour
#define CLEAR_CASINGS	1 //clear chambered so that the next round will be automatically loaded and fired, but don't drop anything on the floor
#define EJECT_CASINGS	2 //drop spent casings on the ground after firing
#define CYCLE_CASINGS	3 //cycle casings, like a revolver. Also works for multibarrelled guns

//Gun loading types
#define SINGLE_CASING 	1	//The gun only accepts ammo_casings. ammo_magazines should never have this as their mag_type.
#define SPEEDLOADER 	2	//Transfers casings from the mag to the gun when used.
#define MAGAZINE 		4	//The magazine item itself goes inside the gun


#define GUN_BULK_RIFLE  5

#define BULLET_IMPACT_NONE  "none"
#define BULLET_IMPACT_METAL "metal"
#define BULLET_IMPACT_MEAT  "meat"

#define SOUNDS_BULLET_MEAT  list('sounds/effects/projectile_impact/bullet_meat1.ogg', 'sounds/effects/projectile_impact/bullet_meat2.ogg', 'sounds/effects/projectile_impact/bullet_meat3.ogg', 'sounds/effects/projectile_impact/bullet_meat4.ogg')
#define SOUNDS_BULLET_METAL  list('sounds/effects/projectile_impact/bullet_metal1.ogg', 'sounds/effects/projectile_impact/bullet_metal2.ogg', 'sounds/effects/projectile_impact/bullet_metal3.ogg')
#define SOUNDS_LASER_MEAT  list('sounds/effects/projectile_impact/energy_meat1.ogg','sounds/effects/projectile_impact/energy_meat2.ogg')
#define SOUNDS_LASER_METAL  list('sounds/effects/projectile_impact/energy_metal1.ogg','sounds/effects/projectile_impact/energy_metal2.ogg')
