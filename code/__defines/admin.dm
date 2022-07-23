// A set of constants used to determine which type of mute an admin wishes to apply.
#define MUTE_IC         (1<<0)
#define MUTE_OOC        (1<<1)
#define MUTE_PRAY       (1<<2)
#define MUTE_ADMINHELP  (1<<3)
#define MUTE_DEADCHAT   (1<<4)
#define MUTE_AOOC       (1<<5)
#define MUTE_MENTOR     (1<<6)
#define MUTE_ALL        (~0)

// Some constants for DB_Ban
#define BANTYPE_PERMA       1
#define BANTYPE_TEMP        2
#define BANTYPE_JOB_PERMA   3
#define BANTYPE_JOB_TEMP    4
#define BANTYPE_ANY_FULLBAN 5 // Used to locate stuff to unban.

#define ROUNDSTART_LOGOUT_REPORT_TIME 6000 // Amount of time (in deciseconds) after the rounds starts, that the player disconnect report is issued.

// Admin permissions.
#define R_BUILDMODE     (1<<0)
#define R_ADMIN         (1<<1)
#define R_BAN           (1<<2)
#define R_FUN           (1<<3)
#define R_SERVER        (1<<4)
#define R_DEBUG         (1<<5)
#define R_POSSESS       (1<<6)
#define R_PERMISSIONS   (1<<7)
#define R_STEALTH       (1<<8)
#define R_REJUVINATE    (1<<9)
#define R_VAREDIT       (1<<10)
#define R_SOUNDS        (1<<11)
#define R_SPAWN         (1<<12)
#define R_MOD           (1<<13)
#define R_MENTOR        (1<<14)
#define R_HOST          (1<<15) //higher than this will overflow
#define R_INVESTIGATE   (R_ADMIN|R_MOD)

#define R_MAXPERMISSION (1<<15) // This holds the maximum value for a permission. It is used in iteration, so keep it updated.

#define ADDANTAG_PLAYER (1<<0)	// Any player may call the add antagonist vote.
#define ADDANTAG_ADMIN  (1<<1)	// Any player with admin privilegies may call the add antagonist vote.
#define ADDANTAG_AUTO   (1<<2)	// The add antagonist vote is available as an alternative for transfer vote.

#define TICKET_CLOSED   (1<<0)  // Ticket has been resolved or declined
#define TICKET_OPEN     (1<<1)  // Ticket has been created, but not responded to
#define TICKET_ASSIGNED (1<<2)  // An admin has assigned themself to the ticket and will respond

#define LAST_CKEY(M) (M.ckey || M.last_ckey)
#define LAST_KEY(M)  (M.key || M.last_ckey)

///Max length of a keypress command before it's considered to be a forged packet/bogus command
#define MAX_KEYPRESS_COMMANDLENGTH 16
///Maximum keys that can be bound to one button
#define MAX_COMMANDS_PER_KEY 5
///Maximum keys per keybind
#define MAX_KEYS_PER_KEYBIND 3
///Length of held key buffer
#define HELD_KEY_BUFFER_LENGTH 15
