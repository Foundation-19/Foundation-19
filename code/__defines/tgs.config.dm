//Remember, every codebase is different, you probably have better methods for these defines than the ones given here --Yes, but I am inexperienced
#define TGS_EXTERNAL_CONFIGURATION
#define TGS_DEFINE_AND_SET_GLOBAL(Name, Value) GLOBAL_VAR_INIT(##Name, ##Value); GLOBAL_PROTECT(##Name)
#define TGS_READ_GLOBAL(Name) GLOB.##Name
#define TGS_WRITE_GLOBAL(Name, Value) GLOB.##Name = ##Value
#define TGS_WORLD_ANNOUNCE(message) to_chat(world, SPAN_BOLD([html_encode(##message)]))
#define TGS_INFO_LOG(message) log_world("TGS Info: [##message]")
#define TGS_WARNING_LOG(message) log_world("TGS Warn: [##message]")
#define TGS_ERROR_LOG(message) log_world("TGS Error: [##message]")
#define TGS_NOTIFY_ADMINS(event) message_admins(##event)
#define TGS_CLIENT_COUNT GLOB.clients
#define TGS_PROTECT_DATUM(Path) // Leave blank if your codebase doesn't give administrators code reflection capabilities
