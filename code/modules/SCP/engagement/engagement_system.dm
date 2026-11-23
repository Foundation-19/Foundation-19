// Player Engagement Pack for Foundation-19.
// Ported from daedalusdock persistent_progression (login_streak, prestige,
// progressive_job_unlock, round_awards), consolidated and adapted:
//  - single JSON persistence file data/player_engagement.json via rustg
//  - no TG persistent_progression dependency; this datum IS the store
//  - no skill system hooks; progressive unlock gates by playtime instead

#define ENGAGEMENT_FILE "data/player_engagement.json"
#define ENGAGEMENT_SAVE_INTERVAL 5 MINUTES

SUBSYSTEM_DEF(engagement)
	name = "Player Engagement"
	wait = 600
	flags = SS_BACKGROUND
	var/list/player_data = list()          // ckey -> list datum
	var/next_save = 0

/datum/controller/subsystem/engagement/Initialize()
	load_data()
	log_game("Engagement Subsystem: Initialized ([player_data.len] players)")
	return ..()

/datum/controller/subsystem/engagement/fire()
	if(world.time > next_save)
		save_data()
		next_save = world.time + ENGAGEMENT_SAVE_INTERVAL

/datum/controller/subsystem/engagement/Shutdown()
	save_data()
	return ..()

/datum/controller/subsystem/engagement/proc/get_player(ckey)
	if(!ckey)
		return null
	if(!player_data[ckey])
		player_data[ckey] = new /datum/engagement_data(ckey)
	return player_data[ckey]

/datum/controller/subsystem/engagement/proc/load_data()
	if(!fexists(ENGAGEMENT_FILE))
		return
	var/json_data = file2text(ENGAGEMENT_FILE)
	if(!rustg_json_is_valid(json_data))
		return
	var/list/data = json_decode(json_data)
	for(var/ckey in data || list())
		var/list/raw = data[ckey]
		var/datum/engagement_data/E = new /datum/engagement_data(ckey)
		E.load_from(raw)
		player_data[ckey] = E
	log_game("Engagement: loaded [player_data.len] player records")

/datum/controller/subsystem/engagement/proc/save_data()
	var/list/out = list()
	for(var/ckey in player_data)
		var/datum/engagement_data/E = player_data[ckey]
		out[ckey] = E.save_to()
	var/result = rustg_file_write(json_encode(out), ENGAGEMENT_FILE)
	if(result != "ok" && result != "true")
		log_game("Engagement: save error [result]")

// ---------------------------------------------------------------------------

/datum/engagement_data
	var/ckey
	var/first_login = 0
	var/last_login = 0
	var/current_streak = 0
	var/longest_streak = 0
	var/total_playtime = 0          // deciseconds
	var/total_xp = 0
	var/prestige_level = 0
	var/list/unlocked_titles = list()
	var/list/round_awards = list()  // list of list(round, title, desc)

/datum/engagement_data/New(new_ckey)
	ckey = new_ckey

/datum/engagement_data/proc/load_from(list/raw)
	first_login = raw["first_login"] || 0
	last_login = raw["last_login"] || 0
	current_streak = raw["current_streak"] || 0
	longest_streak = raw["longest_streak"] || 0
	total_playtime = raw["total_playtime"] || 0
	total_xp = raw["total_xp"] || 0
	prestige_level = raw["prestige_level"] || 0
	unlocked_titles = raw["unlocked_titles"] || list()
	round_awards = raw["round_awards"] || list()

/datum/engagement_data/proc/save_to()
	return list(
		"first_login" = first_login,
		"last_login" = last_login,
		"current_streak" = current_streak,
		"longest_streak" = longest_streak,
		"total_playtime" = total_playtime,
		"total_xp" = total_xp,
		"prestige_level" = prestige_level,
		"unlocked_titles" = unlocked_titles,
		"round_awards" = round_awards
	)

/datum/engagement_data/proc/playtime_hours()
	return round(total_playtime / (1 HOURS), 0.1)

// XP with prestige multiplier.
/datum/engagement_data/proc/award_xp(amount, source)
	var/multiplier = 1 + prestige_level * 0.1
	total_xp += round(amount * multiplier)
	return round(amount * multiplier)

/datum/engagement_data/proc/get_rank()
	// Rank tiers by total XP.
	switch(total_xp)
		if(0 to 999)
			return "Recruit"
		if(1000 to 4999)
			return "Junior Staff"
		if(5000 to 14999)
			return "Staff"
		if(15000 to 34999)
			return "Senior Staff"
		if(35000 to 69999)
			return "Specialist"
		if(70000 to 119999)
			return "Site Authority"
		else
			return "O5 Proxy"

// Login streaks -----------------------------------------------------------

/datum/controller/subsystem/engagement/proc/on_player_login(mob/H)
	if(!H?.ckey)
		return
	var/datum/engagement_data/E = get_player(H.ckey)
	var/now = world.realtime
	var/time_since = now - E.last_login

	if(E.first_login == 0)
		E.first_login = now
		to_chat(H, SPAN_NOTICE("<b>Welcome to Site-53.</b> Your Foundation career begins now."))

	if(time_since > 3 DAYS)
		to_chat(H, SPAN_NOTICE("Welcome back, [E.get_rank()]. It has been [round(time_since / (1 DAYS))] days."))

	update_streak(H, E, now)
	E.last_login = now
	save_data()

/datum/controller/subsystem/engagement/proc/update_streak(mob/H, datum/engagement_data/E, now)
	var/today = round(now / (24 HOURS))
	var/last_day = null
	// streak last-day stored inside longest record via round_awards bookkeeping
	// (kept in E.last_login day form)
	if(E.current_streak > 0 && E.last_login)
		last_day = round(E.last_login / (24 HOURS))

	if(last_day == null)
		E.current_streak = 1
	else if(today == last_day)
		return
	else if(today == last_day + 1)
		E.current_streak++
	else
		E.current_streak = 1

	if(E.current_streak > E.longest_streak)
		E.longest_streak = E.current_streak

	apply_streak_bonus(H, E)

/datum/controller/subsystem/engagement/proc/apply_streak_bonus(mob/H, datum/engagement_data/E)
	var/streak = E.current_streak
	var/xp = 50 * streak
	E.award_xp(xp, "login_streak")
	var/title = null
	switch(streak)
		if(3) title = "Regular"
		if(7) title = "Committed"
		if(14) title = "Dedicated"
		if(30) title = "Foundation Loyalist"
	if(title && !(title in E.unlocked_titles))
		E.unlocked_titles += title
		to_chat(H, SPAN_NOTICE("<b>Login Streak: Day [streak]</b> — +[xp] XP, Title unlocked: <b>[title]</b>"))
	else
		to_chat(H, SPAN_NOTICE("<b>Login Streak: Day [streak]</b> — +[xp] XP"))

// Hook from client login.
/mob/Login()
	. = ..()
	if(ckey)
		SSengagement?.on_player_login(src)

// Progressive access gate: playtime-based job gating suggestions.
// Other systems can query these procs to gate features.
/datum/engagement_data/proc/meets_playtime(hours_required)
	return playtime_hours() >= hours_required

/datum/engagement_data/proc/meets_xp(amount_required)
	return total_xp >= amount_required

// Round awards ------------------------------------------------------------

/proc/award_round_medal(mob/player, title, desc)
	if(!player?.ckey || !SSengagement)
		return
	var/datum/engagement_data/E = SSengagement.get_player(player.ckey)
	E.round_awards += list(list(
		"round" = game_id,
		"title" = title,
		"desc" = desc
	))
	if(E.round_awards.len > 50)
		E.round_awards.Cut(1, 2)
	to_chat(player, SPAN_NOTICE("<b>Round Award:</b> [title] — [desc]"))
