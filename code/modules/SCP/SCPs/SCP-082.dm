/mob/living/carbon/human/scp082
	name = "morbidly obese frenchman"
	desc = "A most massive mound of meat and muscle, with a french accent to boot."
	icon = 'icons/SCP/scp-082.dmi'

	status_flags = NO_ANTAG | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NEED_DIRECT_ABSORB

	roundstart_traits = list(TRAIT_ADVANCED_TOOL_USER)

	handcuffs_breakout_modifier = 0.2
	pixel_x = -16
	pixel_y = -16
	usefov = FALSE // temporary

	/// Door force open cooldown
	var/door_cooldown = 10 SECONDS
	/// Last speech heard up close
	var/last_interaction_time = 0
	/// How much time should pass without interactions to be able to get up and leave
	var/patience_limit = 15 MINUTES
	/// The area we spawned in
	var/area/home_area = null
	/// If TRUE, we are in the hunger state (seperate from regular hunger)
	var/hungering = FALSE
	/// Multiplier for time to open doors when hungering
	var/hungering_door_open_mult = 0.75
	/// The currently selected clothing set. If "", then no clothing
	var/clothing_set = ""
	/// Head mutable appearance
	var/mutable_appearance/head_appearance
	/// Clothing mutable appearance
	var/mutable_appearance/clothing_appearance

	/// Door cooldown tracker
	COOLDOWN_DECLARE(door_cooldown_track)
	/// Cooldown for patience message
	COOLDOWN_DECLARE(patience_cooldown_track)

/mob/living/carbon/human/scp082/Initialize(mapload, new_species)
	. = ..()
	SCP = new /datum/scp(
		src,
		"morbidly obese frenchman",
		SCP_EUCLID,
		"082",
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 10 MINUTES
	SCP.min_playercount = 20

	//add_verb(src, list(
	//))

	InitSkills()
	add_language(LANGUAGE_ENGLISH)
	add_language(LANGUAGE_HUMAN_FRENCH)

	home_area = get_area(src)
	head_appearance = mutable_appearance(icon, hungering ? "hungry" : "static", layer + 0.02)
	clothing_appearance = mutable_appearance(icon, "[clothing_set]", layer + 0.01)

// This code makes me want to drink
/mob/living/carbon/human/scp082/update_icons()
	lying_prev = lying
	update_hud()
	overlays.Cut()

	if (icon_update)
		icon_state = null
		//visible_overlays = overlays_standing
		switch(stat)
			if(CONSCIOUS)
				icon_state = "082_headless"
			if(UNCONSCIOUS)
				icon_state = "082-asleep"
			if(DEAD)
				icon_state = "082-dead"


		/*for(var/i = 1 to LAZYLEN(visible_overlays))
			var/entry = visible_overlays[i]
			if(istype(entry, /image))
				var/image/overlay = entry
				if(i != HO_DAMAGE_LAYER)
					overlay.transform = get_lying_offset(overlay)
				overlays_to_apply += overlay
			else if(istype(entry, /list))
				for(var/image/overlay in entry)
					if(i != HO_DAMAGE_LAYER)
						overlay.transform = get_lying_offset(overlay)
					overlays_to_apply += overlay*/
		// add damage overlays later

	if(stat == CONSCIOUS)
		head_appearance.icon_state = hungering ? "hungry" : "static"
		overlays += head_appearance

	if(clothing_set)
		switch(stat)
			if(CONSCIOUS)
				clothing_appearance.icon_state = clothing_set
			if(UNCONSCIOUS)
				clothing_appearance.icon_state = "[clothing_set]-asleep"
			if(DEAD)
				clothing_appearance.icon_state = "[clothing_set]-dead"
		overlays += clothing_appearance

	/*var/matrix/M = matrix()
	if(lying)
		M.Turn(90)
		M.Scale(size_multiplier)
		M.Translate(1, -6-default_pixel_z)
	else
		M.Scale(size_multiplier)
		M.Translate(0, 16*(size_multiplier-1))
	animate(src, transform = M, time = ANIM_LYING_TIME)*/

/mob/living/carbon/human/scp082/update_body(update_icons = TRUE)
	if(!stand_icon) // not going to change, realistically
		stand_icon = new(icon, "082_headless")

	if(update_icons)
		queue_icon_update()


/mob/living/carbon/human/scp082/proc/InitSkills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/skill as anything in GLOB.skills)
		skillset.skill_list[skill.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_COOKING] = SKILL_MASTER
	skillset.skill_list[SKILL_HAULING] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_COMBAT] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_ANATOMY] = SKILL_EXPERIENCED
	skillset.on_levels_change()

/mob/living/carbon/human/scp082/do_possession(mob/observer/ghost/possessor)
	if(!..())
		return
	priority_announcement.Announce("Motion sensors triggered in the containment chamber of SCP-082, on-site security personnel are to investigate the issue.", "Motion Sensors", 'sounds/AI/049.ogg')
	last_interaction_time = world.time + 5 MINUTES

/mob/living/carbon/human/scp082/proc/OpenDoor(obj/machinery/door/door) // this should probably be a component honestly
	if(!COOLDOWN_FINISHED(src, door_cooldown_track))
		to_chat(src, SPAN_WARNING("You can't open another door just yet!"))
		return

	if(!istype(door))
		return

	if(!door.density)
		return

	if(!door.Adjacent(src))
		to_chat(src, SPAN_WARNING("[door] is too far away."))
		return

	var/open_time = 6 SECONDS
	if(istype(door, /obj/machinery/door/blast))
		if(get_area(src) == home_area && world.time <= last_interaction_time + patience_limit)
			to_chat(src, SPAN_WARNING("You don't feel like leaving just yet."))
			return
		open_time += 10 SECONDS

	if(istype(door, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/airlock = door
		if(airlock.locked)
			open_time += 3 SECONDS
		if(airlock.welded)
			open_time += 3 SECONDS
		if(airlock.secured_wires)
			open_time += 3 SECONDS

	if(istype(door, /obj/machinery/door/airlock/highsecurity))
		open_time += 6 SECONDS

	if(hungering)
		open_time *= hungering_door_open_mult

	door.visible_message(SPAN_WARNING("[src] begins to pry open [door]!"))
	playsound(get_turf(door), 'sounds/machines/airlock_creaking.ogg', 35, 1)
	COOLDOWN_START(src, door_cooldown_track, door_cooldown)

	if(!do_after(src, open_time, door) || !door.Adjacent(src))
		COOLDOWN_RESET(src, door_cooldown_track)
		return

	if(istype(door, /obj/machinery/door/blast))
		var/obj/machinery/door/blast/blastdoor = door
		blastdoor.visible_message(SPAN_DANGER("[src] forcefully opens [blastdoor]!"))
		blastdoor.force_open()
		return

	if(istype(door, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/airlock = door
		airlock.unlock(TRUE) // No more bolting in the SCPs and calling it a day
		airlock.welded = FALSE

	door.set_broken(TRUE)
	door.do_animate("spark")
	visible_message("[src] slices [door]'s controls, [door.open(TRUE) ? "ripping it open!" : "breaking it!"]")

//Overrides

/*mob/living/carbon/human/scp082/on_update_icon()
	if(lying || resting)
		var/matrix/new_matrix = matrix()
		transform = new_matrix.Turn(90)
		return

	transform = null*/

/mob/living/carbon/human/scp082/Life()
	. = ..()
	if(COOLDOWN_FINISHED(src, patience_cooldown_track) && world.time > last_interaction_time + patience_limit && get_area(src) == home_area)
		COOLDOWN_START(src, patience_cooldown_track, 5 MINUTES)
		to_chat(src, SPAN_DANGER("They really abandoned you in here..? Seems like it's time to take a walk."))

/mob/living/carbon/human/scp082/UnarmedAttack(atom/target as obj|mob)
	if(!istype(target))
		return

	if(istype(target, /obj/machinery/door))
		setClickCooldown(CLICK_CD_ATTACK)
		OpenDoor(target)
		return

	if(!ishuman(target))
		return ..()

	//var/mob/living/carbon/human/human_target = target

	/*if(human_target.SCP)
		to_chat(src, SPAN_WARNING("This thing... it isnt normal... you cannot cure it."))
		return*/

	setClickCooldown(CLICK_CD_ATTACK)

	switch(a_intent)
		if(I_HURT) // Might make it shove or smth
			return
	return ..()

/mob/living/carbon/human/scp082/GetUnbuckleTime()
	return 20 SECONDS

//Util Overrides

//mob/living/carbon/human/scp082/update_icons()
//	return

/mob/living/carbon/human/scp082/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp082/handle_breath()
	return 1
/*
/mob/living/carbon/human/scp082/movement_delay()
	return 3.0 - round(anger_timer * 0.03, 0.1)*/

// Override for footstep volume
/mob/living/carbon/human/scp082/handle_footsteps()
	if(!has_footsteps())
		return

	 //every other turf makes a sound
	if((step_count % 2) && MOVING_QUICKLY(src))
		return

	// don't need to step as often when you hop around
	if((step_count % 3) && !has_gravity(src))
		return

	if(istype(move_intent, /decl/move_intent/creep)) //We don't make sounds if we're tiptoeing
		return

	var/turf/T = get_turf(src)
	if(istype(T))
		var/footsound = T.get_footstep_sound(src)
		if(footsound)
			var/range = -(world.view - 2)
			var/volume = 70
			if(MOVING_DELIBERATELY(src))
				volume -= 45
				range -= 0.333
			playsound(T, footsound, volume, 1, range)
			play_special_footstep_sound(T, volume, range)

	show_sound_effect(T, src)



/obj/structure/scp082_closet
	name = "large closet"
