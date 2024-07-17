/// Flags for mech propulsion.
#define PF_SIDE_STRAFE 1<<0
#define PF_STRAIGHT_STRAFE 1<<1
#define PF_OMNI_STRAFE PF_SIDE_STRAFE | PF_STRAIGHT_STRAFE

/// Flags for the mech itself
#define MF_STRAFING 1<<1

/// Delay multiplier applied when doing movement using strafing
#define STRAFING_DELAY_MULTIPLIER 1.5
