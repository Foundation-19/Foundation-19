//See card.dm, topic.dm, manifest.dm for deep access stuff. NTOS datum/computer_file/program/card_mod - HDK
#define ACCESS_REGION_NONE -1
#define ACCESS_REGION_ALL 0
#define ACCESS_REGION_SECURITY 1 //SSjobs.titles_by_department(SEC)
#define ACCESS_REGION_MEDBAY 2 //SSjobs.titles_by_department(MED)
#define ACCESS_REGION_RESEARCH 3 //SSjobs.titles_by_department(SCI)
#define ACCESS_REGION_ENGINEERING 4 //SSjobs.titles_by_department(ENG)
#define ACCESS_REGION_COMMAND 5 //SSjobs.titles_by_department(COM)
#define ACCESS_REGION_GENERAL 6
//#define ACCESS_REGION_SUPPLY 7 //7 - SSjobs.titles_by_department(SUP)
//#define ACCESS_REGION_SERVICE 8 //8 - SSjobs.titles_by_department(SRV)

// Keep those two up to date
#define ACCESS_REGION_MIN 1
#define ACCESS_REGION_MAX 6 //8 - may be related to number of jobs above 0 in the define list above - HDK

#define ACCESS_TYPE_NONE 1
#define ACCESS_TYPE_CENTCOM 2
#define ACCESS_TYPE_STATION 4
#define ACCESS_TYPE_SYNDICATE 8
#define ACCESS_TYPE_ALL (ACCESS_TYPE_NONE|ACCESS_TYPE_CENTCOM|ACCESS_TYPE_STATION|ACCESS_TYPE_SYNDICATE)
