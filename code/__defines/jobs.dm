#define GET_RANDOM_JOB 0
#define BE_CLASS_D 1
#define RETURN_TO_LOBBY 2

//jobtime tracking

//Departments
#define EXP_TYPE_CREW "Crew"
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
#define EXP_TYPE_SPECIAL "Special"
#define EXP_TYPE_ANTAG "Antag"
#define EXP_TYPE_ADMIN "Admin"
#define EXP_TYPE_SCP "SCP"

//Sub Categories
#define EXP_TYPE_LCZ "LCZ"
#define EXP_TYPE_ECZ "ECZ"
#define EXP_TYPE_HCZ "HCZ"
#define EXP_TYPE_BUR "Bureaucrat"
#define EXP_TYPE_REP "Representative"

//Categories are stored on DB along with seperate jobs and sub-categories and departments are calculated in game to avoid cluttering DB.
