#define OUTFIT_NONE                          0
#define OUTFIT_HAS_BACKPACK                  (1<<0)
#define OUTFIT_EXTENDED_SURVIVAL             (1<<1)
#define OUTFIT_RESET_EQUIPMENT               (1<<2)
#define OUTFIT_USES_ACCOUNT                  (1<<3)
#define OUTFIT_USES_EMAIL                    (1<<4)

#define OUTFIT_FLAGS_JOB_DEFAULT (OUTFIT_HAS_BACKPACK | OUTFIT_USES_ACCOUNT | OUTFIT_USES_EMAIL)

#define OUTFIT_ADJUSTMENT_SKIP_POST_EQUIP    (1<<0)
#define OUTFIT_ADJUSTMENT_SKIP_SURVIVAL_GEAR (1<<1)
#define OUTFIT_ADJUSTMENT_SKIP_ID_PDA        (1<<2)
#define OUTFIT_ADJUSTMENT_PLAIN_HEADSET      (1<<3)
#define OUTFIT_ADJUSTMENT_SKIP_BACKPACK      (1<<4)

#define OUTFIT_ADJUSTMENT_ALL_SKIPS (OUTFIT_ADJUSTMENT_SKIP_POST_EQUIP|OUTFIT_ADJUSTMENT_SKIP_SURVIVAL_GEAR|OUTFIT_ADJUSTMENT_SKIP_ID_PDA|OUTFIT_ADJUSTMENT_SKIP_BACKPACK)
