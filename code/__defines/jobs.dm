#define GET_RANDOM_JOB 0
#define BE_CLASS_D 1
#define RETURN_TO_LOBBY 2

//jobtime tracking

//Departments
#define EXP_TYPE_CREW "Staff"
#define EXP_TYPE_COMMAND "Command"
#define EXP_TYPE_ENGINEERING "Engineering"
#define EXP_TYPE_MEDICAL "Medical"
#define EXP_TYPE_SCIENCE "Science"
#define EXP_TYPE_SUPPLY "Supply"
#define EXP_TYPE_SECURITY "Security"
#define EXP_TYPE_SILICON "Silicon"
#define EXP_TYPE_SERVICE "Service"

//Categories
#define EXP_TYPE_LIVING "Living"
#define EXP_TYPE_GHOST "Ghost"
#define EXP_TYPE_ANTAG "Antag"
#define EXP_TYPE_ADMIN "Admin"
#define EXP_TYPE_SCP "SCP"

//Sub Categories
#define EXP_TYPE_LCZ "LCZ"
#define EXP_TYPE_ECZ "EZ"
#define EXP_TYPE_HCZ "HCZ"
#define EXP_TYPE_BUR "Bureaucrat"
#define EXP_TYPE_REP "Representative"

//Categories are stored on DB along with seperate jobs and sub-categories and departments are calculated in game to avoid cluttering DB.

//Bit Flag Defines
#define ENG			(1<<0)
#define SEC			(1<<1)
#define MED			(1<<2)
#define SCI			(1<<3)
#define CIV			(1<<4)
#define COM			(1<<5)
#define MSC			(1<<6)
#define SRV			(1<<7)
#define SUP			(1<<8)
#define SPT			(1<<9)
#define EXP			(1<<10)
#define ROB			(1<<11)
#define LCZ			(1<<12)
#define ECZ			(1<<13)
#define HCZ			(1<<14)
#define BUR			(1<<15)
#define REP			(1<<16)

// Class rank defines
#define CLASS_A "Class-A"
#define CLASS_B "Class-B"
#define CLASS_C "Class-C"
#define CLASS_D "Class-D"
#define CLASS_E "Class-E"
#define CLASS_CI "Class-CI" // Funnee CI edit.
