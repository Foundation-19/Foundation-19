//Used with the ticker to help choose the gamemode.
#define CHOOSE_GAMEMODE_SUCCESS     1 // A gamemode was successfully chosen.
#define CHOOSE_GAMEMODE_RETRY       2 // The gamemode could not be chosen; we will use the next most popular option voted in, or the default.
#define CHOOSE_GAMEMODE_REVOTE      3 // The gamemode could not be chosen; we need to have a revote.
#define CHOOSE_GAMEMODE_RESTART     4 // The gamemode could not be chosen; we will restart the server.
#define CHOOSE_GAMEMODE_SILENT_REDO 5 // The gamemode could not be chosen; we request to have the the proc rerun on the next tick.

//End game state, to manage round end.
#define END_GAME_NOT_OVER         1
#define END_GAME_MODE_FINISH_DONE 2
#define END_GAME_AWAITING_MAP     3
#define END_GAME_READY_TO_END     4
#define END_GAME_ENDING           5
#define END_GAME_AWAITING_TICKETS 6
#define END_GAME_DELAYED          7

#define BE_PLANT "BE_PLANT"
#define BE_SYNTH "BE_SYNTH"
#define BE_PAI   "BE_PAI"

// Antagonist datum flags.
#define ANTAG_OVERRIDE_JOB      (1<<0)  // Assigned job is set to MODE when spawning.
#define ANTAG_OVERRIDE_MOB      (1<<1)  // Mob is recreated from datum mob_type var when spawning.
#define ANTAG_CLEAR_EQUIPMENT   (1<<2)  // All preexisting equipment is purged.
#define ANTAG_CHOOSE_NAME       (1<<3)  // Antagonists are prompted to enter a name.
#define ANTAG_IMPLANT_IMMUNE    (1<<4)  // Cannot be loyalty implanted.
#define ANTAG_SUSPICIOUS        (1<<5)  // Shows up on roundstart report.
#define ANTAG_HAS_LEADER        (1<<6)  // Generates a leader antagonist.
#define ANTAG_RANDSPAWN         (1<<7)  // Potentially randomly spawns due to events.
#define ANTAG_VOTABLE           (1<<8)  // Can be voted as an additional antagonist before roundstart.
#define ANTAG_SET_APPEARANCE    (1<<9)  // Causes antagonists to use an appearance modifier on spawn.
#define ANTAG_RANDOM_EXCEPTED   (1<<10) // If a game mode randomly selects antag types, antag types with this flag should be excluded.
#define ANTAG_PATAPHYSICS       (1<<11) // Enables an antag to spawn through the Pataphysical Incursion Event
// Mode/antag template macros.
#define MODE_BORER         "borer"
#define MODE_LOYALIST      "loyalist"
#define MODE_COMMANDO      "commando"
#define MODE_DEATHSQUAD    "deathsquad"
#define MODE_ERT           "ert"
#define MODE_ACTOR         "actor"
#define MODE_MERCENARY     "mercenary"
#define MODE_NINJA         "ninja"
#define MODE_RAIDER        "raider"
#define MODE_WIZARD        "wizard"
#define MODE_CHANGELING    "changeling"
#define MODE_CULTIST       "cultist"
#define MODE_MONKEY        "monkey"
#define MODE_RENEGADE      "renegade"
#define MODE_REVOLUTIONARY "revolutionary"
#define MODE_MALFUNCTION   "malf"
#define MODE_TRAITOR       "traitor"
#define MODE_DEITY         "deity"
#define MODE_GODCULTIST    "god cultist"
#define MODE_THRALL        "mind thrall"
#define MODE_PARAMOUNT     "paramount"
#define MODE_MURPHYLAW     "murphy law"
#define MODE_DONQUIXOTE    "don quixote"
#define MODE_FOUNDATION    "foundation agent"
#define MODE_MISC_AGITATOR "provocateur"
#define MODE_HUNTER        "hunter"
#define MODE_SHARKPUNCHINGCENTRE "shark punching centre operative"

#define DEFAULT_TELECRYSTAL_AMOUNT 130
#define IMPLANT_TELECRYSTAL_AMOUNT(x) (round(x * 0.49)) // If this cost is ever greater than half of DEFAULT_TELECRYSTAL_AMOUNT then it is possible to buy more TC than you spend

/////////////////
////WIZARD //////
/////////////////

/*		WIZARD SPELL FLAGS		*/
#define GHOSTCAST       (1<<0)  //can a ghost cast it?
#define NEEDSCLOTHES    (1<<1)  //does it need the wizard garb to cast? Nonwizard spells should not have this
#define NEEDSHUM        (1<<2)  //does it require the caster to be human?
#define Z2NOCAST        (1<<3)  //if this is added, the spell can't be cast at centcomm
#define NO_SOMATIC	    (1<<4)	//spell will go off if the person is incapacitated or stunned
#define IGNOREPREV	    (1<<5)	//if set, each new target does not overlap with the previous one
//The following flags only affect different types of spell, and therefore overlap
//Targeted spells
#define INCLUDEUSER	    (1<<6)	//does the spell include the caster in its target selection?
#define SELECTABLE	    (1<<7)	//can you select each target for the spell?
#define NOFACTION		(1<<8)  //Don't do the same as our faction
#define NONONFACTION	(1<<9)  //Don't do people other than our faction
//AOE spells
#define IGNOREDENSE     (1<<10)	//are dense turfs ignored in selection?
#define IGNORESPACE	    (1<<11)	//are space turfs ignored in selection?
//End split flags
#define CONSTRUCT_CHECK	(1<<12)	    //used by construct spells - checks for nullrods
#define NO_BUTTON		(1<<13)	    //spell won't show up in the HUD with this

//invocation
#define INVOKE_SHOUT	"shout"
#define INVOKE_WHISPER	"whisper"
#define INVOKE_EMOTE	"emote"
#define INVOKE_NONE		"none"

//upgrading
#define UPGRADE_SPEED	"speed"
#define UPGRADE_POWER	"power"
#define UPGRADE_TOTAL	"total"

//casting costs
#define SPELL_RECHARGE	"recharge"
#define SPELL_CHARGES	"charges"
#define SPELL_HOLDVAR	"holdervar"

//Voting-related
#define VOTE_PROCESS_ABORT    1
#define VOTE_PROCESS_COMPLETE 2
#define VOTE_PROCESS_ONGOING  3

#define VOTE_STATUS_PREVOTE   1
#define VOTE_STATUS_ACTIVE    2
#define VOTE_STATUS_COMPLETE  3
