GLOBAL_LIST_EMPTY(all_observable_events)

// True if net rebuild will be called manually after an event.
GLOBAL_VAR_INIT(defer_powernet_rebuild, FALSE)

// Those networks can only be accessed by pre-existing terminals. AIs and new terminals can't use them.
GLOBAL_LIST_INIT(restricted_camera_networks, list(\
	NETWORK_ERT,\
	NETWORK_MERCENARY,\
	NETWORK_CRESCENT,\
	"Secret"\
))

// World.time of last sent cross-comms message
GLOBAL_VAR_INIT(last_cross_comms_message_time, 0)

// If FALSE - All incoming cross-comms messages will be denied.
GLOBAL_VAR_INIT(cross_comms_allowed, TRUE)
