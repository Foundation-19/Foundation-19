#define GLOBAL_PROC	"some_magic_bullshit"

#define CALLBACK new /datum/callback
#define INVOKE_ASYNC ImmediateInvokeAsync

///Per the DM reference, spawn(-1) will execute the spawned code immediately until a block is met.
#define MAKE_SPAWN_ACT_LIKE_WAITFOR -1
///Create a codeblock that will not block the callstack if a block is met.
#define ASYNC spawn(MAKE_SPAWN_ACT_LIKE_WAITFOR)
