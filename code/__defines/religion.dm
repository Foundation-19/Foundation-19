#define SECT_MAXWELLISTS "maxwellists"
#define SECT_SECOND_HYTOTH "second_hytoth"

/// List of all playable sects.
#define PLAYABLE_SECTS list(SECT_MAXWELLISTS, SECT_SECOND_HYTOTH)

/// Role below priests, for losing most powers of priests but still being holy.
#define HOLY_ROLE_DEACON 1
/// Default priestly role
#define HOLY_ROLE_PRIEST 2
/// The one who designates the religion
#define HOLY_ROLE_HIGHPRIEST 3

/// The probability, when not overridden by sects, for a bible's bless effect to trigger on a smack
#define DEFAULT_SMACK_CHANCE 60
