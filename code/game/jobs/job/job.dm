/datum/job

	/// The name of the job
	var/title = "NOPE"
	/// List of which accesses this job has when config.jobs_have_minimal_access is true.
	var/list/minimal_access = list()
	/// List of which accesses this job has when config.jobs_have_minimal_access is false.
	var/list/access = list()
	/// Defines starting software that's installed on spawned tablets and laptops.
	var/list/software_on_spawn = list()
	/// Bitflag representing which departments this job is part of.
	var/department_flag = 0
	/// How many players can be this job
	var/total_positions = 0
	/// How many players can spawn in as this job
	var/spawn_positions = 0
	/// How many players currently have this job
	var/current_positions = 0

	/// Selection screen color
	var/selection_color = "#515151"
	/// List of alternate titles, if any. May be an associative list - key = title, value = outfit datum.
	var/list/alt_titles
	/// If you have use_age_restriction_for_jobs config option enabled and the database set up, this option will add a requirement for players to be at least minimal_player_age days old. (meaning they first signed in at least that many days before.)
	var/minimal_player_age = 0
	/// Does this position have a department tag? // TODO: move to department_flag
	var/department = null
	/// Is this position a head position (i.e. part of Command)?
	var/head_position = FALSE
	/// The minimum age your character has to be (to be this job).
	var/minimum_character_age
	/// The "ideal" age for characters with this job. Affects candidate weighting.area
	var/ideal_character_age = 30
	/// Do we make records for people who spawn with this job?
	var/create_record = 1
	/// Whether or not this job is given semi-antagonist status.
	var/is_semi_antagonist = FALSE
	/// Does this job type come with a station account?
	var/account_allowed = TRUE
	/// With how much does this job modify the initial account amount?
	var/economic_power = 2

	/// The outfit the employee will be dressed in, if any
	var/outfit_type

	/// Whether or not loadout equipment is allowed and to be created when joining.
	var/loadout_allowed = TRUE

	/// What class we are. Uses defines ranging from CLASS_A to CLASS_E.
	var/class = CLASS_C

	/// If true, someone with this job arriving will be announced over radio
	var/announced = TRUE
	/// If this job should use roundstart spawnpoints for latejoin (offstation jobs etc)
	var/latejoin_at_spawnpoints

	/// What icon shows up for SecHUDs.
	var/hud_icon

	/// Minimum skills employees start with. List should contain skill (as in /decl/hierarchy/skill path), with values which are numbers.
	var/min_skill = list()
	/// Maximum skills allowed for the job. List should contain skill (as in /decl/hierarchy/skill path), with values which are numbers.
	var/max_skill = list()
	/// The number of unassigned skill points the job comes with (on top of the minimum skills).
	var/skill_points = 16
	/// If true, age doesn't buff skill. // TODO: age shouldn't buff skill at all lol
	var/no_skill_buffs = FALSE
	/// If false, you can't join as this role roundstart
	var/available_by_default = TRUE

	var/list/possible_goals = list()
	var/goals_count

	/// If true, this job will be filled only after all non-defered jobs.
	var/defer_roundstart_spawn = FALSE
	/// Starting psi faculties, if any.
	var/list/psi_faculties
	/// Chance of an additional psi latency, if any.
	var/psi_latency_chance = 5
	/// If psionic, will be implanted for control.
	var/give_psionic_implant_on_join = FALSE

	var/required_language = LANGUAGE_ENGLISH

	/// Chance to start with increased mana pool
	var/higher_mana_chance = 2
	/// Chance to start with increased spell points
	var/higher_spell_points_chance = 2

	var/use_species_whitelist // If set, restricts the job to players with the given species whitelist. This does NOT restrict characters joining as the job to the species itself.
	var/require_whitelist // If set to a string, requires a separate whitelist entry to use the job equal to the given string. Note: If not-null the check happens, so please don't set unless you want the whitelist.

	/// Is this job limited for balance purposes, compared to D-class? Intended for LCZ balance
	var/balance_limited = FALSE

	/// The required playtime in other jobs or categories to play the role
	var/list/requirements

	// Information that's only used for specific player-facing information panels (such as the codex)
	/// If true, the player gets a notification telling him to notify admins before disconnecting. // TODO: make this automatic as well
	var/req_admin_notify = FALSE
	/// The higher-ups that the player works directly under.
	var/supervisors = null
	/// How much effort the player needs to put in to have a fun round.
	var/roleplay_difficulty = "Unset - talk to someone about the codex"
	/// How mechanically complex a job is to play.
	var/mechanical_difficulty = "Unset - talk to someone about the codex"
	/// Other guides on the codex that may be relevant. MUST BE LINKS!
	var/list/codex_guides = list("Unset - talk to someone about the codex")
	/// Quick overview of what you do as this job.
	var/duties = "Unset - talk to someone about the codex"
	/// Text used for the main body of the codex.
	var/special_codex_text = "Special text unset - talk to someone about the codex"

/datum/job/New()

	if(!hud_icon)
		hud_icon = "hud[ckey(title)]"

	..()

/datum/job/dd_SortValue()
	return title

/datum/job/proc/equip(mob/living/carbon/human/H, alt_title)

	if (required_language)
		H.add_language(required_language)
		H.set_default_language(all_languages[required_language])

	if (!H.languages.len)
		H.add_language(LANGUAGE_ENGLISH)
		H.set_default_language(all_languages[LANGUAGE_ENGLISH])

	if(psi_latency_chance && prob(psi_latency_chance))
		H.set_psi_rank(pick(PSI_COERCION, PSI_REDACTION, PSI_ENERGISTICS, PSI_PSYCHOKINESIS), 1, defer_update = TRUE)
	if(islist(psi_faculties))
		for(var/psi in psi_faculties)
			H.set_psi_rank(psi, psi_faculties[psi], take_larger = TRUE, defer_update = TRUE)
	if(H.psi)
		H.psi.update()
		if(give_psionic_implant_on_join)
			var/obj/item/implant/psi_control/imp = new
			imp.implanted(H)
			imp.forceMove(H)
			imp.imp_in = H
			imp.implanted = TRUE
			var/obj/item/organ/external/affected = H.get_organ(BP_HEAD)
			if(affected)
				affected.implants += imp
				imp.part = affected
			to_chat(H, SPAN_DANGER("As a registered psionic, you are fitted with a psi-dampening control implant. Using psi-power while the implant is active will result in neural shocks and your violation being reported."))

	if(prob(higher_mana_chance))
		H.mind.mana.mana_level_max *= 2
		H.mind.mana.mana_level = H.mind.mana.mana_level_max
		H.mind.mana.mana_recharge_speed *= 2
	if(prob(higher_spell_points_chance))
		H.mind.mana.spell_points += pickweight(1 = 30, 2 = 12, 3 = 4, 4 = 1)

	var/decl/hierarchy/outfit/outfit = get_outfit(H, alt_title)
	if(outfit)
		. = outfit.equip(H, title, alt_title)

/datum/job/proc/get_outfit(mob/living/carbon/human/H, alt_title)
	if(alt_title && alt_titles)
		. = alt_titles[alt_title]
	. = . || outfit_type
	. = outfit_by_type(.)

/datum/job/proc/setup_account(mob/living/carbon/human/H)
	if(!account_allowed || (H.mind && H.mind.initial_account))
		return

	// Calculate our pay and apply all relevant modifiers.
	var/money_amount = 4 * rand(75, 100) * economic_power

	// Get an average economic power for our cultures.
	var/culture_mod =   0
	var/culture_count = 0
	for(var/token in H.cultural_info)
		var/decl/cultural_info/culture = H.get_cultural_value(token)
		if(culture && !isnull(culture.economic_power))
			culture_count++
			culture_mod += culture.economic_power
	if(culture_count)
		culture_mod /= culture_count
	money_amount *= culture_mod

	// Apply other mods.
	money_amount *= GLOB.using_map.salary_modifier
	money_amount *= 1 + 2 * H.get_skill_value(SKILL_FINANCE)/(SKILL_MAX - SKILL_MIN)
	money_amount = round(money_amount)

	if(money_amount <= 0)
		return // You are too poor for an account.

	//give them an account in the station database
	var/datum/money_account/M = create_account("[H.real_name]'s account", H.real_name, money_amount)
	if(H.mind)
		var/remembered_info = ""
		remembered_info += "<b>Your account number is:</b> #[M.account_number]<br>"
		remembered_info += "<b>Your account pin is:</b> [M.remote_access_pin]<br>"
		remembered_info += "<b>Your account funds are:</b> [GLOB.using_map.local_currency_name_short][M.money]<br>"

		if(M.transaction_log.len)
			var/datum/transaction/T = M.transaction_log[1]
			remembered_info += "<b>Your account was created:</b> [T.time], [T.date] at [T.get_source_name()]<br>"
		H.StoreMemory(remembered_info, /decl/memory_options/system)
		H.mind.initial_account = M

// overrideable separately so AIs/borgs can have cardborg hats without unneccessary new()/qdel()
/datum/job/proc/equip_preview(mob/living/carbon/human/H, alt_title, additional_skips)
	var/decl/hierarchy/outfit/outfit = get_outfit(H, alt_title)
	if(!outfit)
		return FALSE
	. = outfit.equip(H, title, alt_title, OUTFIT_ADJUSTMENT_SKIP_POST_EQUIP|OUTFIT_ADJUSTMENT_SKIP_ID_PDA|additional_skips)

/datum/job/proc/get_access()
	if(minimal_access.len && (!config || config.jobs_have_minimal_access))
		return src.minimal_access.Copy()
	else
		return src.access.Copy()

//If the configuration option is set to require players to be logged as old enough to play certain jobs, then this proc checks that they are, otherwise it just returns 1
/datum/job/proc/player_old_enough(client/C)
	return (available_in_days(C) == 0) //Available in 0 days = available right now = player is old enough to play.

/datum/job/proc/available_in_days(client/C)
	if(C && config.use_age_restriction_for_jobs && isnull(C.holder) && isnum(C.player_age) && isnum(minimal_player_age))
		return max(0, minimal_player_age - C.player_age)
	return 0

/datum/job/proc/apply_fingerprints(mob/living/carbon/human/target)
	if(!istype(target))
		return 0
	for(var/obj/item/item in target.contents)
		apply_fingerprints_to_item(target, item)
	return 1

/datum/job/proc/apply_fingerprints_to_item(mob/living/carbon/human/holder, obj/item/item)
	item.add_fingerprint(holder,1)
	if(item.contents.len)
		for(var/obj/item/sub_item in item.contents)
			apply_fingerprints_to_item(holder, sub_item)

/datum/job/proc/is_position_available()
	if(!check_d_class_balance())
		return FALSE
	else
		return (current_positions < total_positions) || (total_positions == -1)

/datum/job/proc/has_alt_title(mob/H, supplied_title, desired_title)
	return (supplied_title == desired_title) || (H.mind && H.mind.role_alt_title == desired_title)

/datum/job/proc/is_restricted(datum/preferences/prefs, feedback)
	var/datum/species/S

	S = all_species[prefs.species]

	if(LAZYACCESS(minimum_character_age, S.get_bodytype()) && (prefs.age < minimum_character_age[S.get_bodytype()]))
		to_chat(feedback, SPAN_CLASS("boldannounce","Not old enough. Minimum character age is [minimum_character_age[S.get_bodytype()]]."))
		return TRUE

	if(!S.check_background(src, prefs))
		to_chat(feedback, SPAN_CLASS("boldannounce","Incompatible background for [title]."))
		return TRUE

	return FALSE

/datum/job/proc/get_join_link(client/caller, href_string, show_invalid_jobs)
	if(!is_available(caller))
		if(show_invalid_jobs)
			return "<tr bgcolor='[selection_color]'><td style='padding-left:2px;padding-right:2px;'><a style='background: #9E4444' href='[href_string]'>[title]</a></td><td style='padding-left:2px;padding-right:2px;''><center>[current_positions]</center></td><td style='padding-left:2px;padding-right:2px;'><center>(Active: [get_active_count()])</center></td></tr>"
		return ""
	if(is_restricted(caller.prefs))
		if(show_invalid_jobs)
			return "<tr bgcolor='[selection_color]'><td style='padding-left:2px;padding-right:2px;'><a style='background: #9E4444' href='[href_string]'>[title]</a></td><td style='padding-left:2px;padding-right:2px;''><center>[current_positions]</center></td><td style='padding-left:2px;padding-right:2px;'><center>(Active: [get_active_count()])</center></td></tr>"
	else
		return "<tr bgcolor='[selection_color]'><td style='padding-left:2px;padding-right:2px;'><a href='[href_string]'>[title]</a></td><td style='padding-left:2px;padding-right:2px;'><center>[current_positions]</center></td><td style='padding-left:2px;padding-right:2px;'><center>(Active: [get_active_count()])</center></td></tr>"

// Only players with the job assigned and AFK for less than 10 minutes count as active
/datum/job/proc/check_is_active(mob/M)
	return (M.mind && M.client && M.mind.assigned_role == title && M.client.inactivity <= 10 * 60 * 10)

/datum/job/proc/get_active_count()
	var/active = 0
	for(var/mob/M in GLOB.player_list)
		if(check_is_active(M))
			active++
	return active

/datum/job/proc/get_description_blurb()
	return ""

/datum/job/proc/get_job_icon()
	if(!SSjobs.job_icons[title])
		var/mob/living/carbon/human/dummy/mannequin/mannequin = get_mannequin("#job_icon")
		dress_mannequin(mannequin)
		mannequin.dir = SOUTH
		var/icon/preview_icon = getFlatIcon(mannequin)
		preview_icon.Scale(preview_icon.Width() * 2, preview_icon.Height() * 2) // Scaling here to prevent blurring in the browser.
		SSjobs.job_icons[title] = preview_icon
	return SSjobs.job_icons[title]

/datum/job/proc/get_unavailable_reasons(client/caller)
	var/list/reasons = list()
	if(jobban_isbanned(caller, title))
		reasons["You are jobbanned."] = TRUE
	if(is_semi_antagonist && jobban_isbanned(caller, MODE_MISC_AGITATOR))
		reasons["You are semi-antagonist banned."] = TRUE
	if(!player_old_enough(caller))
		reasons["Your player age is too low."] = TRUE
	if(!is_position_available())
		reasons["There are no positions left."] = TRUE
	var/datum/species/S = all_species[caller.prefs.species]
	if(S)
		if(!S.check_background(src, caller.prefs))
			reasons["Your background choices do not allow it."] = TRUE
	if(!meets_req(caller))
		reasons["You do not meet the playtime requirements."] = TRUE
	if(LAZYLEN(reasons))
		. = reasons

/datum/job/proc/dress_mannequin(mob/living/carbon/human/dummy/mannequin/mannequin)
	mannequin.delete_inventory(TRUE)
	equip_preview(mannequin, additional_skips = OUTFIT_ADJUSTMENT_SKIP_BACKPACK)

/datum/job/proc/is_available(client/caller)
	if(!is_position_available())
		return FALSE
	if(jobban_isbanned(caller, title))
		return FALSE
	if(is_semi_antagonist && jobban_isbanned(caller, MODE_MISC_AGITATOR))
		return FALSE
	if(!player_old_enough(caller))
		return FALSE
	if(!meets_req(caller))
		return FALSE
	return TRUE

/datum/job/proc/make_position_available()
	total_positions++

/datum/job/proc/get_roundstart_spawnpoint()
	var/list/loc_list = list()
	for(var/obj/effect/landmark/start/sloc in landmarks_list)
		if(sloc.name != title)	continue
		if(locate(/mob/living) in sloc.loc)	continue
		loc_list += sloc
	if(loc_list.len)
		return pick(loc_list)
	else
		return locate("start*[title]") // use old stype

/**
 *  Return appropriate /datum/spawnpoint for given client
 *
 *  Spawnpoint will be the one set in preferences for the client, unless the
 *  preference is not set, or the preference is not appropriate for the rank, in
 *  which case a fallback will be selected.
 */
/datum/job/proc/get_spawnpoint(client/C)

	if(!C)
		CRASH("Null client passed to get_spawnpoint_for() proc!")

	var/mob/H = C.mob
	var/spawnpoint = C.prefs.spawnpoint
	var/datum/spawnpoint/spawnpos

	if(spawnpoint == DEFAULT_SPAWNPOINT_ID)
		spawnpoint = GLOB.using_map.default_spawn

	if(spawnpoint)
		if(!(spawnpoint in GLOB.using_map.allowed_spawns))
			if(H)
				to_chat(H, SPAN_WARNING("Your chosen spawnpoint ([C.prefs.spawnpoint]) is unavailable for the current map. Spawning you at one of the enabled spawn points instead. To resolve this error head to your character's setup and choose a different spawn point."))
			spawnpos = null
		else
			spawnpos = spawntypes()[spawnpoint]

	if(spawnpos && !spawnpos.check_job_spawning(title))
		if(H)
			to_chat(H, SPAN_WARNING("Your chosen spawnpoint ([spawnpos.display_name]) is unavailable for your chosen job ([title]). Spawning you at another spawn point instead."))
		spawnpos = null

	if(!spawnpos)
		// Step through all spawnpoints and pick first appropriate for job
		for(var/spawntype in GLOB.using_map.allowed_spawns)
			var/datum/spawnpoint/candidate = spawntypes()[spawntype]
			if(candidate.check_job_spawning(title))
				spawnpos = candidate
				break

	if(!spawnpos)
		// Pick at random from all the (wrong) spawnpoints, just so we have one
		warning("Could not find an appropriate spawnpoint for job [title].")
		spawnpos = spawntypes()[pick(GLOB.using_map.allowed_spawns)]

	return spawnpos

/datum/job/proc/post_equip_rank(mob/person, alt_title)
	if(is_semi_antagonist && person.mind)
		GLOB.provocateurs.add_antagonist(person.mind)

/datum/job/proc/get_alt_title_for(client/C)
	return C.prefs.GetPlayerAltTitle(src)

/datum/job/proc/clear_slot()
	if(current_positions > 0)
		current_positions -= 1
		return TRUE
	return FALSE

/datum/job/proc/handle_variant_join(mob/living/carbon/human/H, alt_title)
	return

/datum/job/proc/get_min_skill(decl/hierarchy/skill/S)
	if(min_skill)
		. = min_skill[S.type]
	if(!.)
		. = SKILL_MIN

/datum/job/proc/check_d_class_balance()
	if(!balance_limited) //if this role doesn't care about balance, move on
		return TRUE

	var/department_count = 0
	var/datum/job/classd/CD

	for(var/datum/job/job in SSjobs.primary_job_datums) //find all other jobs in our department
		if(job.department == department)
			department_count += job.get_active_count()

		if(job.type == /datum/job/classd)
			CD = job

	if(department_count < 5) //LCZ can always have at least 5 guards, regardless of Class D population
		return TRUE

	if(department_count < CD.get_active_count() / 4) //if there is more than 4 d-class for every guard
		return TRUE
	else
		return FALSE

///Converts department flags to exp definitions
/datum/job/proc/get_flags_to_exp()
	var/list/exp_list
	LAZYINITLIST(exp_list)

	if(department_flag & CIV)
		exp_list.Add(EXP_TYPE_CREW)
	if(department_flag & COM)
		exp_list.Add(EXP_TYPE_COMMAND)
	if(department_flag & ENG)
		exp_list.Add(EXP_TYPE_ENGINEERING)
	if(department_flag & MED)
		exp_list.Add(EXP_TYPE_MEDICAL)
	if(department_flag & SCI)
		exp_list.Add(EXP_TYPE_SCIENCE)
	if(department_flag & SUP)
		exp_list.Add(EXP_TYPE_SUPPLY)
	if(department_flag & SEC)
		exp_list.Add(EXP_TYPE_SECURITY)
	if(department_flag & MSC)
		exp_list.Add(EXP_TYPE_SILICON) //only silicon have MSC flag despite it standing for misc. jobs. This needs to be fixed and a proper silicon flag added
	if(department_flag & SRV)
		exp_list.Add(EXP_TYPE_SERVICE)
	if(department_flag & LCZ)
		exp_list.Add(EXP_TYPE_LCZ)
	if(department_flag & ECZ)
		exp_list.Add(EXP_TYPE_ECZ)
	if(department_flag & HCZ)
		exp_list.Add(EXP_TYPE_HCZ)
	if(department_flag & BUR)
		exp_list.Add(EXP_TYPE_BUR)
	if(department_flag & REP)
		exp_list.Add(EXP_TYPE_REP)

	return exp_list

/datum/job/proc/meets_req(client/tclient)
	if(!requirements || !config.use_timelocks || check_rights(R_TIMELOCK, FALSE, tclient))
		return TRUE

	var/datum/jobtime/jt = tclient.jobtime

	if(!jt) //guests wont ever meet req because their time isint tracked
		return FALSE

	jt.update_jobtime()
	for(var/requirement in requirements)
		if(jt.get_jobtime(requirement) < requirements[requirement])
			return FALSE

	return TRUE

/datum/job/proc/get_req(client/tclient)
	if(!requirements || !config.use_timelocks || check_rights(R_TIMELOCK, FALSE, tclient))
		return 0

	var/datum/jobtime/jt = tclient.jobtime
	var/list/required_time_remaining = list()

	if(jt)
		jt.update_jobtime()

	for(var/requirement in requirements)
		if(jt)
			required_time_remaining[requirement] = requirements[requirement] - jt.get_jobtime(requirement)
		else
			required_time_remaining[requirement] = requirements[requirement]

		if(required_time_remaining[requirement] <= 0)
			required_time_remaining[requirement] = null

	return required_time_remaining
