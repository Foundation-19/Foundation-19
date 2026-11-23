// Classifcations

#define SCP_SAFE		"Safe"
#define SCP_EUCLID		"Euclid"
#define SCP_KETER 		"Keter"
#define SCP_THAUMIEL	"Thaumiel"
#define SCP_NEUTRALIZED "Neutralized"

// SCP 914 defines
#define MODE_ROUGH "Rough"
#define MODE_COARSE "Coarse"
#define MODE_ONE_TO_ONE "1:1"
#define MODE_FINE "Fine"
#define MODE_VERY_FINE "Very Fine"

//Meta bitflags

///Is the SCP playable?
#define SCP_PLAYABLE 		(1<<0)
///Is it a roleplay oriented SCP?
#define SCP_ROLEPLAY		(1<<1)
///Does the scp have memetic properties?
#define SCP_MEMETIC			(1<<2)
///Is this SCP disabled and should be prevented from spawning?
#define SCP_DISABLED (1<<3)

//Memetic bitflags

///Do memetics take affect when the atom is seen?
#define MVISUAL				(1<<0)
///Do memetics take affect when the atom is heard?
#define MAUDIBLE			(1<<1)
///Do memetics take affect when the atom is inspected?
#define MINSPECT			(1<<2)
///Should memetics take affect through cameras?
#define MCAMERA				(1<<3)
///Should memetics take affect through photos?
#define MPHOTO				(1<<4)
///Is the individual still affected after they no longer meet the memetic requirements? Only use if the MSYNCED flag is used.
#define MPERSISTENT			(1<<5)
///Is the scp memetic effect synced? If this flag is enabled the memetic comp's active_memetic_effect() must be called to enact the memetic effect.
#define MSYNCED				(1<<6)

// Containment status defines
#define SCP_CONTAINED		"Contained"
#define SCP_BREACHED		"Breached"
#define SCP_UNKNOWN			"Unknown"
#define SCP_NEUTRALIZED_STATUS "Neutralized"

// Research tier defines
#define SCP_RESEARCH_NONE		0
#define SCP_RESEARCH_PRELIMINARY	1
#define SCP_RESEARCH_BASIC		2
#define SCP_RESEARCH_ADVANCED		3
#define SCP_RESEARCH_EXPERT		4
#define SCP_RESEARCH_FULL		5

// Research tier names
#define SCP_RESEARCH_TIER_NAME(tier) (list("None", "Preliminary", "Basic", "Advanced", "Expert", "Full")[(tier)+1])

// Research point thresholds per tier
#define SCP_RESEARCH_THRESHOLDS list(50, 150, 350, 700, 1500)

// Containment signals
#define COMSIG_CONTAINMENT_BREACH		"containment_breach"
#define COMSIG_CONTAINMENT_WARNING		"containment_warning"
#define COMSIG_CONTAINMENT_RECONTAINED	"containment_recontained"
#define COMSIG_SCP_RESEARCH_UPDATE		"scp_research_update"

// Containment rating defines
#define SCP_RATING_A	"A"
#define SCP_RATING_B	"B"
#define SCP_RATING_C	"C"
#define SCP_RATING_D	"D"
#define SCP_RATING_F	"F"
