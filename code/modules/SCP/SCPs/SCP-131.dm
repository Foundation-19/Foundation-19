/mob/living/simple_animal/friendly/scp131
	name = "eyepod"
	desc = "A teardrop-shaped creature roughly one foot in height, with a wheel-like protrusion beneath. It stares at things with its curious unblinking eye."
	icon = 'icons/SCP/scp-131.dmi'

	icon_state = "SCP-131A"
	maxHealth = 150
	health = 150
	pass_flags = PASS_FLAG_TABLE

	species_language = LANGUAGE_EYEPOD
	only_species_language = 1
	universal_understand = 1

	mob_size = MOB_SMALL
	can_pull_size = ITEM_SIZE_TINY
	can_pull_mobs = MOB_PULL_NONE

	turns_per_move = 5
	see_in_dark = 6

	response_help  = "plays with"
	response_disarm = "gently nudges aside"
	response_harm   = "kicks"

	ai_holder_type = /datum/ai_holder/simple_animal/passive/scp131
	say_list_type = /datum/say_list/scp131

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	//Config

	///How long can 131 be seperated from its friend before becoming disinterested
	var/acceptable_seperation_time = 2 MINUTES
	///Panic visual message cooldown
	var/panic_message_cooldown = 2 SECONDS

	//Mechanical
	///Our current friend
	var/mob/living/carbon/human/friend
	///Last time we saw our friend
	var/friend_last_seen
	///ref to remove friend timer to avoid having duplicates
	var/delfriend_timer
	///Last time we sent the panic message
	var/panic_message_time

/mob/living/simple_animal/friendly/scp131/Initialize()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"eyepod", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"131", //Numerical Designation
	)

	SCP.min_time = 5 MINUTES

	add_language(LANGUAGE_EYEPOD)
	add_verb(src, /mob/living/proc/ventcrawl)
	add_verb(src, /mob/living/proc/hide)
	return ..()

/mob/living/simple_animal/friendly/scp131/Destroy()
	. = ..()
	remove_friend()

/mob/living/simple_animal/friendly/scp131/scp131A
	name = "SCP-131-A"
	icon_state = "SCP-131A"

/mob/living/simple_animal/friendly/scp131/scp131A/Initialize()
	. = ..()
	SCP.designation = "131-A"

/mob/living/simple_animal/friendly/scp131/scp131B
	name = "SCP-131-B"
	icon_state = "SCP-131B"

/mob/living/simple_animal/friendly/scp131/scp131B/Initialize()
	. = ..()
	SCP.designation = "131-B"

// AI Stuff

/datum/say_list/scp131
	emote_hear = list("babbles")

/datum/ai_holder/simple_animal/passive/scp131
	dying_threshold = 0.8
	wander = TRUE

/datum/ai_holder/simple_animal/passive/scp131/should_flee()
	if(leader && (leader in view(world.view, src))) //avoid running away if our friend is in danger
		return FALSE
	return ..()

/datum/ai_holder/simple_animal/passive/scp131/special_flee_check()
	for(var/atom/scpInView in GLOB.SCP_list)
		if(!holder.can_see(scpInView))
			continue
		if(scpInView.SCP.classification == SCP_SAFE)
			continue
		return TRUE
	return FALSE

// Mechanics

/mob/living/simple_animal/friendly/scp131/proc/update_friend(mob/living/carbon/human/new_friend)
	if(!istype(new_friend))
		return
	if(friend)
		return
	friend = new_friend
	LAZYADD(friends, friend)
	ai_holder.set_follow(friend)

/mob/living/simple_animal/friendly/scp131/proc/remove_friend()
	friend = null
	ai_holder?.lose_follow()

///Allows 131 to panic when its friend is injured or when a hostile scp is in sight.
/mob/living/simple_animal/friendly/scp131/proc/panic()
	if(friend && can_see(friend))
		while(get_dist(src, friend) > 1)
			step_towards(src, friend)
		if((world.time - panic_message_time) > panic_message_cooldown)
			visible_emote("babbles rapidly in a panicked tone")
			panic_message_time = world.time
		ai_holder.handle_wander_movement() //Makes us jump around our friend
	else
		if((world.time - panic_message_time) > panic_message_cooldown)
			visible_emote("babbles rapidly in a panicked tone")
			panic_message_time = world.time
		ai_holder.set_stance(STANCE_FLEE)

// Overrides

/mob/living/simple_animal/friendly/scp131/Life()
	. = ..()

	if(friend)
		if(can_see(friend))
			friend_last_seen = world.time
		else if((world.time - friend_last_seen) > acceptable_seperation_time)
			remove_friend()
			return

		if(friend.stat != CONSCIOUS)
			panic()
			if(!delfriend_timer && (friend.stat == DEAD))
				delfriend_timer = addtimer(CALLBACK(src, PROC_REF(remove_friend)), 1 MINUTE)
			return

	for(var/atom/scpInView in GLOB.SCP_list)
		if(!can_see(scpInView))
			continue
		if(scpInView.SCP.classification == SCP_SAFE)
			continue

		if((isscp173(scpInView)) && friend && can_see(friend))
			face_atom(scpInView)
			return
		else
			ai_holder.give_target(scpInView)
			panic()
			return

/mob/living/simple_animal/friendly/scp131/attack_hand(mob/living/carbon/human/M)
	if(M.a_intent == I_HELP)
		if(prob(65) && !friend)
			update_friend(M)
			face_atom(M)
			visible_emote(pick("whirls around [M]'s legs", "nudges [M] playfully", "rolls around near [M]", "stares briefly up at [M]", "seems to follow [M]'s gaze."))
		else if(friend && (M == friend))
			visible_emote(pick("whirls around [M]'s legs", "nudges [M] playfully", "rolls around near [M]", "stares briefly up at [M]", "seems to follow [M]'s gaze."))
		else
			to_chat(M, SPAN_NOTICE("[src] seems to ignore you."))
	else if((M.a_intent == I_HURT) && (M == friend))
		remove_friend()
	. = ..()
