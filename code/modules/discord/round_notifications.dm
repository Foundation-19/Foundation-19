// Round lifecycle Discord notifications, routed through the TGS DMAPI.
// Round end: an embed with round statistics + a random Foundation flavor
// line to a specific Discord channel. Round start: a role ping to the
// same channel. The channel is resolved by Discord channel ID (TGS
// exposes it as the chat channel's internal id), so no TGS tag setup
// is required.
//
// Implemented as a subsystem so signal registration happens in
// Initialize() — a GLOBAL_DATUM_INIT constructor runs before SSdcs /
// SSticker exist and RegisterSignal silently no-ops on null.

#define DISCORD_ROUNDEND_CHANNEL_ID "1005541607388491826"
#define DISCORD_ROUND_CHANNEL_TAG "New Round Ping"
#define DISCORD_ROUND_PING_ROLE "<@&899514330461126656>"

SUBSYSTEM_DEF(round_discord_notifications)
	name = "Round Discord Notifications"
	init_order = SS_INIT_MISC_LATE
	flags = SS_NO_FIRE

	var/round_started_at = 0
	var/cached_channel = null
	var/channel_resolved = FALSE
	var/last_resolution_error = null

	var/list/end_flavor = list(
		"Secure. Contain. Protect. Another shift safely concluded.",
		"Amnestics have been administered to all involved personnel.",
		"Class-B amnestics are being distributed at exit checkpoints.",
		"The O5 Council has reviewed this shift's performance. Adequate.",
		"Ethics Committee note: D-Class personnel are people too. Legally.",
		"All personnel must surrender anomalous items before leaving the site.",
		"Remember: anomalous incidents reported after shift end are non-compensable.",
		"This shift's incident report has been archived, redacted, and burned.",
		"Site-53 operations report filed. The Foundation thanks you for your service.",
		"Dr. Bright is still not permitted to use this shift's ending as a punchline.",
	)

	var/list/start_flavor = list(
		"New shift beginning. The anomalous never rest, and neither do we.",
		"Site Director reminds all personnel that unauthorized experimentation is still unauthorized.",
		"Coffee machine in the breakroom is operational. Morale projections: moderate.",
		"Please do not feed the anomalies.",
		"Reminder: eye contact with Keter-class entities is prohibited.",
		"The Foundation is cold. The Foundation is sure.",
		"Breakroom pastries are provided by the Ethics Committee. Enjoy.",
		"Site-53 is now open for another shift. Try to keep the skyline intact.",
		"All new researchers are reminded that the walkthrough of SCP-914 outputs was scheduled yesterday.",
		"Dr. ██████ wishes everyone a productive and uneventful shift.",
	)

/datum/controller/subsystem/round_discord_notifications/Initialize()
	RegisterSignal(SSdcs, COMSIG_ROUND_ENDED, PROC_REF(on_round_ended))
	RegisterSignal(SSticker, COMSIG_TICKER_STARTED, PROC_REF(on_round_started))
	// One-time boot audit: gives the server log a definitive answer about
	// whether the target channel resolves, ~30s after startup so the
	// bridge handshake has settled.
	addtimer(CALLBACK(src, PROC_REF(audit_channels)), 30 SECONDS, TIMER_STOPPABLE)
	return ..()

/datum/controller/subsystem/round_discord_notifications/proc/audit_channels()
	channel_resolved = FALSE
	cached_channel = null
	var/datum/tgs_chat_channel/channel = get_channel()
	if(channel)
		log_game("round_discord: boot audit OK — using channel [channel.friendly_name] ([channel.id]).")
	else
		log_game("round_discord: boot audit FAILED — [last_resolution_error]")

// Resolve (and retryable) target chat channel. Match order:
// 1. Channel tagged "New Round Ping" in TGS (authoritative — the user's
//    channel setup; tag matching is comma-split like send2chat).
// 2. TGS internal channel id equal to the Discord snowflake (fallback for
//    TGS builds that expose raw Discord ids).
// A failed lookup is NOT cached — the bridge may not have pushed channel
// data yet (e.g. at round start), so each send re-attempts resolution.
// If nothing matches, messages are NOT broadcast site-wide: they're
// dropped with a log so pings never spam general/admin channels.
/datum/controller/subsystem/round_discord_notifications/proc/get_channel()
	if(channel_resolved)
		return cached_channel
	if(!world.TgsAvailable())
		last_resolution_error = "TGS not available"
		log_game("round_discord: TGS not available; notifications disabled.")
		return null
	var/list/channels = world.TgsChatChannelInfo()
	if(!channels || !length(channels))
		last_resolution_error = "TgsChatChannelInfo() returned no channels (bridge may still be connecting)"
		log_game("round_discord: [last_resolution_error].")
		return null
	var/list/dump = list()
	var/list/tags_dump = list()
	for(var/I in channels)
		var/datum/tgs_chat_channel/channel = I
		dump += "'[channel.friendly_name]' id=[channel.id] tag=[channel.custom_tag || "none"]"
		var/list/tags = splittext(channel.custom_tag || "", ",")
		if(DISCORD_ROUND_CHANNEL_TAG in tags)
			cached_channel = channel
			channel_resolved = TRUE
			last_resolution_error = null
			log_game("round_discord: resolved by tag '[DISCORD_ROUND_CHANNEL_TAG]' — channel [channel.friendly_name].")
			return cached_channel
		if("[channel.id]" == DISCORD_ROUNDEND_CHANNEL_ID)
			cached_channel = channel
			channel_resolved = TRUE
			last_resolution_error = null
			log_game("round_discord: resolved by id — channel [channel.friendly_name].")
			return cached_channel
	tags_dump.Cut()
	last_resolution_error = "no channel tagged '[DISCORD_ROUND_CHANNEL_TAG]' (or id [DISCORD_ROUNDEND_CHANNEL_ID]). TGS channels: [english_list(dump)]"
	log_game("round_discord: [last_resolution_error]")
	return null

// Delivery: only to the resolved target channel. If resolution fails,
// the message is DROPPED (never broadcast site-wide — a round ping must
// not spam general/admin channels) and the reason is logged.
/datum/controller/subsystem/round_discord_notifications/proc/deliver(message)
	var/datum/tgs_chat_channel/channel = get_channel()
	if(!channel)
		log_game("round_discord: message dropped. [last_resolution_error]")
		return FALSE
	world.TgsChatBroadcast(message, list(channel))
	return TRUE

/datum/controller/subsystem/round_discord_notifications/proc/on_round_started()
	SIGNAL_HANDLER
	round_started_at = world.time
	spawn(0)
		send_round_start()
		// If the bridge hadn't pushed channel data yet, try once more.
		if(!channel_resolved)
			addtimer(CALLBACK(src, PROC_REF(send_round_start)), 30 SECONDS, TIMER_STOPPABLE)

/datum/controller/subsystem/round_discord_notifications/proc/on_round_ended()
	SIGNAL_HANDLER
	spawn(0)
		send_round_end()

/datum/controller/subsystem/round_discord_notifications/proc/send_round_start()
	var/gamemode = SSticker.master_mode
	if(SSticker.mode)
		gamemode = SSticker.mode.name
	var/flavor = pick(start_flavor)
	var/text = "[DISCORD_ROUND_PING_ROLE] A new round has started — [gamemode]. [flavor]"
	deliver(new /datum/tgs_message_content(text))

/datum/controller/subsystem/round_discord_notifications/proc/send_round_end()
	var/gamemode = SSticker.master_mode
	if(SSticker.mode)
		gamemode = SSticker.mode.name

	var/duration = "Unknown"
	if(round_started_at)
		duration = DisplayTimeText(world.time - round_started_at)

	// Survivor census at round end: players still alive vs dead.
	var/survivors = 0
	var/dead = 0
	for(var/mob/M in GLOB.player_list)
		if(M.stat == DEAD)
			dead++
		else
			survivors++

	// SCP site metrics from the persistence + research trackers.
	var/breaches = 0
	var/stability = null
	if(SSscp_persistence && SSscp_persistence.manager)
		breaches = SSscp_persistence.manager.active_breaches
		stability = round(SSscp_persistence.manager.global_containment_stability)
	if(GLOB.scp_research_tracker)
		breaches = max(breaches, GLOB.scp_research_tracker.total_breaches_this_round)

	var/flavor = pick(end_flavor)

	var/datum/tgs_chat_embed/structure/embed = new
	embed.title = "Site-53 Round Report"
	embed.description = flavor
	embed.timestamp = time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")
	embed.colour = survivors ? "#1a7a1a" : "#8b0000"
	var/datum/tgs_chat_embed/provider/author/author = new("Foundation Operations")
	embed.author = author
	embed.fields = list(
		new /datum/tgs_chat_embed/field("Gamemode", gamemode),
		new /datum/tgs_chat_embed/field("Duration", duration),
		new /datum/tgs_chat_embed/field("Survivors", "[survivors]"),
		new /datum/tgs_chat_embed/field("Casualties", "[dead]"),
	)
	if(stability != null)
		embed.fields += new /datum/tgs_chat_embed/field("Containment Stability", "[stability]%")
		embed.fields += new /datum/tgs_chat_embed/field("Breaches This Round", "[breaches]")

	var/message_text = "A round of [gamemode] has ended. [flavor]"
	var/datum/tgs_message_content/message = new(message_text)
	message.embed = embed
	deliver(message)

/// Admin chat command: lists every channel TGS reports (id/tag/name) and
/// sends a test round-start ping + test round-end embed through the normal
/// delivery path (tag/id match, all-channel fallback if neither matches).
/datum/tgs_chat_command/discordtest
	name = "discordtest"
	help_text = "Dumps the TGS channel list and sends a test round-start ping and round-end embed."
	admin_only = TRUE

/datum/tgs_chat_command/discordtest/Run(datum/tgs_chat_user/sender, params)
	var/datum/controller/subsystem/round_discord_notifications/SS = SSround_discord_notifications
	if(!SS)
		return new /datum/tgs_message_content("round_discord_notifications subsystem not initialized.")
	var/dump = "Channels visible to the game: "
	if(world.TgsAvailable())
		var/list/channels = world.TgsChatChannelInfo()
		if(channels && length(channels))
			var/list/parts = list()
			for(var/I in channels)
				var/datum/tgs_chat_channel/channel = I
				parts += "'[channel.friendly_name]' id=[channel.id] tag=[channel.custom_tag || "none"]"
			dump += english_list(parts)
		else
			dump += "NONE (bridge not connected or no designated game channels)"
	else
		dump += "TGS unavailable"
	// Force fresh resolution so config/tag changes are picked up.
	SS.channel_resolved = FALSE
	SS.cached_channel = null
	SS.send_round_start()
	var/datum/tgs_message_content/ack = new(dump + " — test ping sent, round-end embed follows.")
	SS.send_round_end()
	return ack

#undef DISCORD_ROUNDEND_CHANNEL_ID
#undef DISCORD_ROUND_CHANNEL_TAG
#undef DISCORD_ROUND_PING_ROLE
