#define TGS_STATUS_THROTTLE 7
/datum/tgs_chat_command/tgscheck
	name = "check"
	help_text = "Gets the playercount, gamemode, and address of the server"
	var/last_tgs_check = 0


/datum/tgs_chat_command/tgscheck/Run(datum/tgs_chat_user/sender, params)
	var/rtod = REALTIMEOFDAY
	if(rtod - last_tgs_check < TGS_STATUS_THROTTLE)
		return
	last_tgs_check = rtod
	var/server = config.server
	return "Round Time: [gameTimestamp("hh:mm")] | Players: [length(GLOB.clients)] | Map: Site 53 | Mode: [ticker.mode.name] | Round Status: [ticker.HasRoundStarted() ? (ticker.IsRoundInProgress() ? "Active" : "Finishing") : "Starting"] | Link: [server ? server : "<byond://[world.internet_address]:[world.port]>"]"
