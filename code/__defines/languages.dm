//Human
#define LANGUAGE_HUMAN_GERMAN		"German"
#define LANGUAGE_HUMAN_CHINESE		"Mandarin"
#define LANGUAGE_HUMAN_ARABIC		"Arabic"
#define LANGUAGE_HUMAN_INDIAN		"Hindustani"
#define LANGUAGE_HUMAN_SPANISH		"Spanish"
#define LANGUAGE_HUMAN_RUSSIAN		"Russian"
#define LANGUAGE_HUMAN_FRENCH		"French"
#define LANGUAGE_HUMAN_JAPANESE		"Japanese"
#define LANGUAGE_HUMAN_ITALIAN		"Italian"

//Human misc
#define LANGUAGE_GUTTER				"Gutter"
#define LANGUAGE_ENGLISH			"English"

//Alien
#define LANGUAGE_EAL				"Encoded Audio Language"
#define LANGUAGE_UNATHI_SINTA		"Sinta'unathi"
#define LANGUAGE_UNATHI_YEOSA		"Yeosa'unathi"
#define LANGUAGE_SKRELLIAN			"Skrellian"
#define LANGUAGE_ROOTLOCAL			"Local Rootspeak"
#define LANGUAGE_ROOTGLOBAL			"Global Rootspeak"
#define LANGUAGE_ADHERENT			"Protocol"
#define LANGUAGE_VOX				"Vox-pidgin"
#define LANGUAGE_NABBER				"Serpentid"

//Antag
#define LANGUAGE_CULT				"Cult"
#define LANGUAGE_CULT_GLOBAL		"Occult"
#define LANGUAGE_ALIUM				"Alium"

//Other
#define LANGUAGE_PRIMITIVE			"Primitive"
#define LANGUAGE_SIGN				"Sign Language"
#define LANGUAGE_ROBOT_GLOBAL		"Robot Talk"
#define LANGUAGE_DRONE_GLOBAL		"Drone Talk"
#define LANGUAGE_CHANGELING_GLOBAL	"Changeling"
#define LANGUAGE_BORER_GLOBAL		"Cortical Link"
#define LANGUAGE_MANTID_NONVOCAL	"Ascent-Glow"
#define LANGUAGE_MANTID_VOCAL		"Ascent-Voc"
#define LANGUAGE_MANTID_BROADCAST	"Worldnet"

//SCP
#define LANGUAGE_EYEPOD				"Eyepod"

// Language flags.
#define WHITELISTED  1   // Language is available if the speaker is whitelisted.
#define RESTRICTED   2   // Language can only be acquired by spawning or an admin.
#define NONVERBAL    4   // Language has a significant non-verbal component. Speech is garbled without line-of-sight.
#define SIGNLANG     8   // Language is completely non-verbal. Speech is displayed through emotes for those who can understand.
#define HIVEMIND     16  // Broadcast to all mobs with this language.
#define NONGLOBAL    32  // Do not add to general languages list.
#define INNATE       64  // All mobs can be assumed to speak and understand this language. (audible emotes)
#define NO_TALK_MSG  128 // Do not show the "\The [speaker] talks into \the [radio]" message
#define NO_STUTTER   256 // No stuttering, slurring, or other speech problems
#define ALT_TRANSMIT 512 // Language is not based on vision or sound (Todo: add this into the say code and use it for the rootspeak languages)

// Misc
#define MAX_LANGUAGES 3
