/// Flags for mech propulsion.
#define PF_SIDE_STRAFE 1<<0
#define PF_STRAIGHT_STRAFE 1<<1
#define PF_OMNI_STRAFE PF_SIDE_STRAFE | PF_STRAIGHT_STRAFE

/// Flags for the mech itself
#define MF_STRAFING 1<<1
#define MF_CELL_POWERED 1<<2
#define MF_ENGINE_POWERED 1<<3
#define MF_AUXILIARY_AVAILABLE 1<<4

/// Flags for mech equipment

#define ME_CELL_POWERED 1<<1
#define ME_ENGINE_POWERED 1<<2
#define ME_AUXILIARY_POWERED 1<<3
#define ME_ANY_POWER ME_CELL_POWERED | ME_ENGINE_POWERED | ME_AUXILIARY_POWERED
#define ME_AUXILIARY_SUPPLIER 1<<4

/// Flags for mech components

#define MC_CELL_POWERED 1<<1
#define MC_ENGINE_POWERED 1<<2
#define MC_AUXILIARY_POWERED 1<<3
#define MC_ANY_POWER MQ_CELL_POWERED | MQ_ENGINE_POWERED | MQ_AUXILIARY_POWERED

/// Delay multiplier applied when doing movement using strafing
#define STRAFING_DELAY_MULTIPLIER 1.5


