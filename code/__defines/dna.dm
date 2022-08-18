// Bitflags for mutations.
#define STRUCDNASIZE 27
#define   UNIDNASIZE 13

// Generic mutations:
#define MUTATION_COLD_RESISTANCE 1
#define MUTATION_XRAY            2
#define MUTATION_HULK            3
#define MUTATION_CLUMSY          4
#define MUTATION_FAT             5
#define MUTATION_HUSK            6
#define MUTATION_LASER           7  // Harm intent - click anywhere to shoot lasers from eyes.
#define MUTATION_HEAL            8 // Healing people with hands.
#define MUTATION_SPACERES        9 // Can't be harmed via pressure damage.
#define MUTATION_SKELETON        10
#define MUTATION_FERAL           11 // Smash objects instead of using them, and unable to use items

// Other Mutations:
#define mNobreath      100 // No need to breathe.
#define mRemote        101 // Remote viewing.
#define mRegen         102 // Health regeneration.
#define mRun           103 // No slowdown.
#define mRemotetalk    104 // Remote talking.
#define mMorph         105 // Hanging appearance.
#define mBlend         106 // Nothing. (seriously nothing)
#define mHallucination 107 // Hallucinations.
#define mFingerprints  108 // No fingerprints.
#define mShock         109 // Insulated hands.
#define mSmallsize     110 // Table climbing.

// disabilities
#define NEARSIGHTED (1<<0)
#define EPILEPSY    (1<<1)
#define COUGHING    (1<<2)
#define TOURETTES   (1<<3)
#define NERVOUS     (1<<4)

// sdisabilities
#define BLINDED     (1<<0)
#define MUTED       (1<<1)
#define DEAFENED    (1<<2)

// What each index means:
#define DNA_OFF_LOWERBOUND 0
#define DNA_OFF_UPPERBOUND 1
#define DNA_ON_LOWERBOUND  2
#define DNA_ON_UPPERBOUND  3

// Define block bounds (off-low,off-high,on-low,on-high)
// Used in setupgame.dm
#define DNA_DEFAULT_BOUNDS list(1,2049,2050,4095)
#define DNA_HARDER_BOUNDS  list(1,3049,3050,4095)
#define DNA_HARD_BOUNDS    list(1,3490,3500,4095)

// UI Indices (can change to mutblock style, if desired)
#define DNA_UI_HAIR_R      1
#define DNA_UI_HAIR_G      2
#define DNA_UI_HAIR_B      3
#define DNA_UI_BEARD_R     4
#define DNA_UI_BEARD_G     5
#define DNA_UI_BEARD_B     6
#define DNA_UI_SKIN_TONE   7
#define DNA_UI_SKIN_R      8
#define DNA_UI_SKIN_G      9
#define DNA_UI_SKIN_B      10
#define DNA_UI_EYES_R      11
#define DNA_UI_EYES_G      12
#define DNA_UI_EYES_B      13
#define DNA_UI_GENDER      14
#define DNA_UI_BEARD_STYLE 15
#define DNA_UI_HAIR_STYLE  16
#define DNA_UI_LENGTH      16 // Update this when you add something, or you WILL break shit.

#define DNA_SE_LENGTH 27

// The way blocks are handled badly needs a rewrite, this is horrible.
// Too much of a project to handle at the moment, TODO for later.
GLOBAL_VAR_INIT(BLINDBLOCK,0)
GLOBAL_VAR_INIT(DEAFBLOCK,0)
GLOBAL_VAR_INIT(HULKBLOCK,0)
GLOBAL_VAR_INIT(TELEBLOCK,0)
GLOBAL_VAR_INIT(FIREBLOCK,0)
GLOBAL_VAR_INIT(XRAYBLOCK,0)
GLOBAL_VAR_INIT(CLUMSYBLOCK,0)
GLOBAL_VAR_INIT(FAKEBLOCK,0)
GLOBAL_VAR_INIT(COUGHBLOCK,0)
GLOBAL_VAR_INIT(GLASSESBLOCK,0)
GLOBAL_VAR_INIT(EPILEPSYBLOCK,0)
GLOBAL_VAR_INIT(TWITCHBLOCK,0)
GLOBAL_VAR_INIT(NERVOUSBLOCK,0)
GLOBAL_VAR_INIT(MONKEYBLOCK, STRUCDNASIZE)

GLOBAL_VAR_INIT(BLOCKADD,0)
GLOBAL_VAR_INIT(DIFFMUT,0)

GLOBAL_VAR_INIT(HEADACHEBLOCK,0)
GLOBAL_VAR_INIT(NOBREATHBLOCK,0)
GLOBAL_VAR_INIT(REMOTEVIEWBLOCK,0)
GLOBAL_VAR_INIT(REGENERATEBLOCK,0)
GLOBAL_VAR_INIT(INCREASERUNBLOCK,0)
GLOBAL_VAR_INIT(REMOTETALKBLOCK,0)
GLOBAL_VAR_INIT(MORPHBLOCK,0)
GLOBAL_VAR_INIT(BLENDBLOCK,0)
GLOBAL_VAR_INIT(HALLUCINATIONBLOCK,0)
GLOBAL_VAR_INIT(NOPRINTSBLOCK,0)
GLOBAL_VAR_INIT(SHOCKIMMUNITYBLOCK,0)
GLOBAL_VAR_INIT(SMALLSIZEBLOCK,0)
