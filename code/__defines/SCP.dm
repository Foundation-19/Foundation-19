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
