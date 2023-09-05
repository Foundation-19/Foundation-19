// There are three different power channels, lighting, equipment, and enviroment
// Each may have one of the following states
#define POWERCHAN_OFF		0	// Power channel is off
#define POWERCHAN_OFF_TEMP	1	// Power channel is off until there is power
#define POWERCHAN_OFF_AUTO	2	// Power channel is off until power passes a threshold
#define POWERCHAN_ON		3	// Power channel is on until there is no power
#define POWERCHAN_ON_AUTO	4	// Power channel is on until power drops below a threshold

// Power channels set to Auto change when power levels rise or drop below a threshold

#define AUTO_THRESHOLD_LIGHTING  50
#define AUTO_THRESHOLD_EQUIPMENT 25
// The ENVIRON channel stays on as long as possible, and doesn't have a threshold

#define CRITICAL_APC_EMP_PROTECTION 10	// EMP effect duration is divided by this number if the APC has "critical" flag

// Used to check whether or not to update the icon_state
#define UPDATE_CELL_IN 		(1<<0)
#define UPDATE_OPENED1 		(1<<1)
#define UPDATE_OPENED2 		(1<<2)
#define UPDATE_MAINT 		(1<<3)
#define UPDATE_BROKE 		(1<<4)
#define UPDATE_BLUESCREEN 	(1<<5)
#define UPDATE_WIREEXP 		(1<<6)
#define UPDATE_ALLGOOD 		(1<<7)

// Used to check whether or not to update the overlay
#define APC_UPOVERLAY_CHARGEING0 	(1<<0)
#define APC_UPOVERLAY_CHARGEING1 	(1<<1)
#define APC_UPOVERLAY_CHARGEING2 	(1<<2)
#define APC_UPOVERLAY_LOCKED 		(1<<3)
#define APC_UPOVERLAY_OPERATING 	(1<<4)

// APC cover status:
/// The APCs cover is closed.
#define APC_COVER_CLOSED 0
/// The APCs cover is open.
#define APC_COVER_OPENED 1
/// The APCs cover is missing.
#define APC_COVER_REMOVED 2

// APC PCU status:
/// The APC doesn't have a PCU.
#define APC_PCU_NONE 0
/// The APC has a PCU, but it isn't screwed in.
#define APC_PCU_UNSCREWED 1
/// The APC has a PCU that's screwed in properly.
#define APC_PCU_SCREWED 2
