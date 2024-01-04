// Species flags.
#define SPECIES_FLAG_NO_MINOR_CUT           (1<<0)  // Can step on broken glass with no ill-effects. Either thick skin (diona/vox), cut resistant (slimes) or incorporeal (shadows)
#define SPECIES_FLAG_IS_PLANT               (1<<1)  // Is a treeperson.
#define SPECIES_FLAG_NO_SCAN                (1<<2)  // Cannot be scanned in a DNA machine/genome-stolen.
#define SPECIES_FLAG_NO_PAIN                (1<<3)  // Cannot suffer halloss/recieves deceptive health indicator.
#define SPECIES_FLAG_NO_SLIP                (1<<4)  // Cannot fall over.
#define SPECIES_FLAG_NO_POISON              (1<<5)  // Cannot not suffer toxloss.
#define SPECIES_FLAG_NO_EMBED               (1<<6)  // Can step on broken glass with no ill-effects and cannot have shrapnel embedded in it.
#define SPECIES_FLAG_NO_TANGLE              (1<<7)  // This species wont get tangled up in weeds
#define SPECIES_FLAG_NO_BLOCK               (1<<8)  // Unable to block or defend itself from attackers.
#define SPECIES_FLAG_NEED_DIRECT_ABSORB     (1<<9)  // This species can only have their DNA taken by direct absorption.
#define SPECIES_FLAG_LOW_GRAV_ADAPTED       (1<<10)  // This species is used to lower than standard gravity, affecting stamina in high-grav
#define SPECIES_FLAG_NO_DISEASE             (1<<11)  // This species are immune to diseases

// Species spawn flags
#define SPECIES_IS_WHITELISTED               (1<<0)    // Must be whitelisted to play.
#define SPECIES_IS_RESTRICTED                (1<<1)    // Is not a core/normally playable species. (castes, mutantraces)
#define SPECIES_CAN_JOIN                     (1<<2)    // Species is selectable in chargen.
#define SPECIES_NO_FBP_CONSTRUCTION          (1<<3)    // FBP of this species can't be made in-game.
#define SPECIES_NO_FBP_CHARGEN               (1<<4)    // FBP of this species can't be selected at chargen.
#define SPECIES_NO_ROBOTIC_INTERNAL_ORGANS   (1<<5)    // Species cannot start with robotic organs or have them attached.

// Species appearance flags
#define HAS_SKIN_TONE_NORMAL    (1<<0)   // Skin tone selectable in chargen for baseline humans (0-220)
#define HAS_SKIN_COLOR          (1<<1)   // Skin colour selectable in chargen. (RGB)
#define HAS_LIPS                (1<<2)   // Lips are drawn onto the mob icon. (lipstick)
#define HAS_UNDERWEAR           (1<<3)   // Underwear is drawn onto the mob icon.
#define HAS_EYE_COLOR           (1<<4)   // Eye colour selectable in chargen. (RGB)
#define HAS_HAIR_COLOR          (1<<5)   // Hair colour selectable in chargen. (RGB)
#define RADIATION_GLOWS         (1<<6)   // Radiation causes this character to glow.
#define HAS_SKIN_TONE_GRAV      (1<<7)   // Skin tone selectable in chargen for grav-adapted humans (0-100)
#define HAS_SKIN_TONE_SPCR      (1<<8)   // Skin tone selectable in chargen for spacer humans (0-165)
#define HAS_SKIN_TONE_TRITON    (1<<9)
#define HAS_BASE_SKIN_COLOURS   (1<<10)   // Has multiple base skin sprites to go off of
#define HAS_A_SKIN_TONE (HAS_SKIN_TONE_NORMAL | HAS_SKIN_TONE_GRAV | HAS_SKIN_TONE_SPCR | HAS_SKIN_TONE_TRITON) // Species has a numeric skintone

// Skin Defines
#define SKIN_NORMAL 0
#define SKIN_THREAT 1

// Darkvision Levels these are inverted from normal so pure white is the darkest
// possible and pure black is none
#define DARKTINT_NONE      "#ffffff"
#define DARKTINT_MODERATE  "#f9f9f5"
#define DARKTINT_GOOD      "#ebebe6"
