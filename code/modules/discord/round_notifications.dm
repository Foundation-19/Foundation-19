// Round lifecycle Discord notifications, routed through the TGS DMAPI.
// Round end: an embed with round statistics + a random Foundation flavor
// line to a specific Discord channel. Round start: a role ping to the
// same channel. The channel is resolved by Discord channel ID (TGS
// exposes it as the chat channel's internal id), so no TGS tag setup
// is required.

#define DISCORD_ROUNDEND_CHANNEL_ID "1005541607388491826"
#define DISCORD_ROUND_PING_ROLE "<@&899514330461126656>"

GLOBAL_DATUM_INIT(round_discord_notifier, /datum/round_discord_notifications, new)

/datum/round_discord_notifications
	var/round_started_at = 0
	var/cached_channel = null
	var/channel_resolved = FALSE

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

/datum/round_discord_notifications/New()
	RegisterSignal(SSdcs, COMSIG_ROUND_ENDED, PROC_REF(on_round_ended))
	RegisterSignal(SSticker, COMSIG_TICKER_STARTED, PROC_REF(on_round_started))

// Resolve (and cache) the target chat channel by its Discord channel id.
/datum/round_discord_notifications/proc/get_channel()
	if(channel_resolved)
		return cached_channel
	channel_resolved = TRUE
	if(!world.TgsAvailable())
		return null
	var/list/channels = world.TgsChatChannelInfo()
	if(!channels)
		return null
	for(var/I in channels)
		var/datum/tgs_chat_channel/channel = I
		if("[channel.id]" == DISCORD_ROUNDEND_CHANNEL_ID)
			cached_channel = channel
			return cached_channel
	return null

/datum/round_discord_notifications/proc/on_round_started()
	SIGNAL_HANDLER
	round_started_at = world.time
	spawn(0)
		send_round_start()

/datum/round_discord_notifications/proc/on_round_ended()
	SIGNAL_HANDLER
	spawn(0)
		send_round_end()

/datum/round_discord_notifications/proc/send_round_start()
	var/channel = get_channel()
	if(!channel)
		return
	var/gamemode = SSticker.master_mode
	if(SSticker.mode)
		gamemode = SSticker.mode.name
	var/flavor = pick(start_flavor)
	var/text = "[DISCORD_ROUND_PING_ROLE] A new round has started — [gamemode]. [flavor]"
	world.TgsChatBroadcast(new /datum/tgs_message_content(text), list(channel))

/datum/round_discord_notifications/proc/send_round_end()
	var/channel = get_channel()
	if(!channel)
		return

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
	world.TgsChatBroadcast(message, list(channel))

#undef DISCORD_ROUNDEND_CHANNEL_ID
#undef DISCORD_ROUND_PING_ROLE
