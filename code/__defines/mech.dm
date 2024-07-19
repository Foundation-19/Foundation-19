/// Flags for mech propulsion.
// (left and right turns by 90 degrees)
#define PF_SIDE_STRAFE 1<<0
// reverse direction
#define PF_STRAIGHT_STRAFE 1<<1
// all 90 angles or reverse direction
#define PF_OMNI_STRAFE PF_SIDE_STRAFE | PF_STRAIGHT_STRAFE

/// Flags for the mech itself
#define MF_STRAFING 1<<1 // 2 // 1
#define MF_CELL_POWERED 1<<2 // 4 // 2
#define MF_ENGINE_POWERED 1<<3 // 16 // 4
#define MF_AUXILIARY_POWERED 1<<4 // 32 // 8
#define MF_ANY_POWER (MF_CELL_POWERED | MF_ENGINE_POWERED | MF_AUXILIARY_POWERED)

/// Flags for mech equipment

/// These define what power sources this equipment can draw from
#define ME_CELL_POWERED 1<<1
#define ME_ENGINE_POWERED 1<<2
#define ME_AUXILIARY_POWERED 1<<3
#define ME_ANY_POWER (ME_CELL_POWERED | ME_ENGINE_POWERED | ME_AUXILIARY_POWERED)
/// Lets the equipment start without the requirement of power (or try starting)
#define ME_POWERLESS_ACTIVATION 1<<5
/// The equipment doesn't require arms to exist or be powered to function
#define ME_ARM_INDEPENDENT 1<<6
/// This equipment doesn't require the canopy to be closed to be operated.
#define ME_BYPASS_INTERFACE 1<<7

/// Flags for mech components

/// Defines the currently available power sources on the mech.
#define MC_CELL_POWERED 1<<1
#define MC_ENGINE_POWERED 1<<2
#define MC_AUXILIARY_POWERED 1<<3
#define MC_ANY_POWER MQ_CELL_POWERED | MQ_ENGINE_POWERED | MQ_AUXILIARY_POWERED

/// Delay multiplier applied when doing movement using strafing
#define STRAFING_DELAY_MULTIPLIER 1.5


