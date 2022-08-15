#define SHEET_MATERIAL_AMOUNT 2000

#define TECH_MATERIAL "materials"
#define TECH_ENGINEERING "engineering"
#define TECH_PHORON "phorontech"
#define TECH_POWER "powerstorage"
#define TECH_BLUESPACE "bluespace"
#define TECH_BIO "biotech"
#define TECH_COMBAT "combat"
#define TECH_MAGNET "magnets"
#define TECH_DATA "programming"
#define TECH_ESOTERIC "esoteric"

#define IMPRINTER	(1<<0)	//For circuits. Uses glass/chemicals.
#define PROTOLATHE	(1<<1)	//New stuff. Uses glass/metal/chemicals
#define MECHFAB		(1<<2)	//Mechfab
#define CHASSIS		(1<<3)	//For protolathe, but differently

#define T_BOARD(name)	"circuit board (" + (name) + ")"
