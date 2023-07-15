// Classifcations

#define SAFE 1
#define EUCLID 2
#define KETER 3
#define THAUMIEL 4
#define NEUTRALIZED 5

//Meta bitflags

///Is the SCP playable?
#define PLAYABLE 	(1<<0)
///Is it a roleplay oriented SCP?
#define ROLEPLAY	(1<<1)
///Does the scp have memetic properties?
#define MEMETIC		(1<<2)

//Memetic bitflags

#define MVISUAL				(1<<0)
#define MAUDIBLE			(1<<1)
#define MINSPECT			(1<<2)
///Should memetics still take affect through cameras and pictures?
#define MSELF_PERPETRAITING	(1<<3)
///Is the individual still affected after they no longer meet the memetic requirements?
#define MPERSISTENT			(1<<4)


#define SCP_096 "096"
