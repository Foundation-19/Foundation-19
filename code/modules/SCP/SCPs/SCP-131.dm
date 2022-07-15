GLOBAL_LIST_EMPTY(scp131s)

/datum/scp/scp_131
	name = "SCP-131"
	designation = "131"
	classification = SAFE

/mob/living/simple_animal/scp_131
	name = "SCP-131"
	desc = "A teardrop-shaped creature roughly one foot in height, with a wheel-like protrusion beneath. It stares at things with its curious unblinking eye."
	icon = 'icons/SCP/scp-131.dmi'
	icon_living = "SCP-131A"
	// icon_dead = "SCP-131A_d"
	icon_state = "SCP-131A"
	SCP = /datum/scp/scp_131
	maxHealth = 150
	health = 150
	pass_flags = PASS_FLAG_TABLE
	// language = LANGUAGE_EYEPOD
//	species_language = LANGUAGE_EYEPOD
	only_species_language = 1
	density = 0
	universal_speak = 0
	universal_understand = 1
	mob_size = MOB_MEDIUM
	can_pull_size = ITEM_SIZE_TINY
	turns_per_move = 5
	see_in_dark = 6
	can_pull_mobs = MOB_PULL_NONE
	possession_candidate = 1
	response_help  = "pets"
	response_disarm = "gently nudges aside"
	response_harm   = "kicks"
//	emote_see = list("whirrs around", "swivels in place")
	var/turns_since_scan = 0
	var/mob/movement_target
	var/mob/study_target
	var/mob/flee_target
	var/mob/living/carbon/human/friend
	var/befriend_job = null
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

/mob/living/simple_animal/scp_131/say(var/message, var/datum/language/speaking = null, whispering)
	src << "<span class = 'notice'>You cannot speak.</span>"
	return 0

/mob/living/simple_animal/scp_131/a
	name = "SCP-131-A"
	icon_living = "SCP-131A"
	icon_state = "SCP-131A"
	// icon_dead = "SCP-131A_d"

/mob/living/simple_animal/scp_131/b
	name = "SCP-131-B"
	icon_living = "SCP-131B"
	icon_state = "SCP-131B"
	// icon_dead = "SCP-131B_d"

/mob/living/simple_animal/scp_131/Initialize()
//	add_language(LANGUAGE_EYEPOD, 1)
	GLOB.scp131s += src
	add_verb(src, /mob/living/proc/ventcrawl)
	add_verb(src, /mob/living/proc/hide)
	return ..()

/mob/living/simple_animal/scp_131/update_icon()
	if(stat != DEAD && resting)
		// icon_state = "SCP-131A_rest"
	else if(stat == DEAD)
		// icon_state = "SCP-131A_d"
	else
		// icon_state = "SCP-131A"

/mob/living/simple_animal/scp_131/death()
	. = ..()
	update_icon()

/mob/living/simple_animal/scp131/Destroy()
	GLOB.scp131s -= src
	return ..()

/mob/living/simple_animal/scp_131/verb/bond_with()
	set name = "Bond With"
	set category = "IC"
	set src in view(1)

	if(!friend)
		var/mob/living/carbon/human/H = usr
		if(istype(H) && (!befriend_job || H.job == befriend_job))
			friend = usr
			. = 1
	else if(usr == friend)
		. = 1 //already friends, but show success anyways

	if(.)
		set_dir(get_dir(src, friend))
		visible_emote(pick("whirrs around [friend]'s legs.",
							"brushes against [friend].",
							"stares reverently up at [friend].",
							"seems to look where [friend] is looking."))
	else
		to_chat(usr, "<span class='notice'>[src] ignores you.</span>")
	return

/mob/living/simple_animal/scp_131/proc/handle_movement_target()
	var/follow_dist = 5
	if (friend)
		if (friend.stat >= DEAD || friend.is_asystole()) //danger
			follow_dist = 1
		else if (friend.stat || friend.health <= 50) //danger or just sleeping
			follow_dist = 3
		var/current_dist = get_dist(src, friend)
		var/near_dist = max(follow_dist - 2, 1)

		if (movement_target != friend)
			if (current_dist > follow_dist && !istype(movement_target, /mob/living) && (friend in oview(src)))
				//stop existing movement
				walk_to(src,0)
				turns_since_scan = 0

				//walk to friend
				set_AI_busy(FALSE)
				movement_target = friend
				walk_to(src, movement_target, near_dist, 4)

			//already following and close enough, stop
			else if (current_dist <= near_dist)
				walk_to(src,0)
				movement_target = null
				set_AI_busy(FALSE)

	if (!friend || movement_target != friend)
		//if our target is neither inside a turf or inside a human(???), stop
		// if((movement_target) && !(isturf(movement_target.loc) || ishuman(movement_target.loc) ))

		if ((movement_target) && (get_dist(src, movement_target) < 2))
			set_dir(get_dir(src, movement_target))
			study_target = movement_target
			movement_target = null
			set_AI_busy(FALSE)

		//if we have no target or our current one is out of sight/too far away
		if(!study_target && ( !movement_target || !(movement_target.loc in oview(src, 4))))
			movement_target = null
			set_AI_busy(FALSE)
			for(var/mob/living/subject in oview(src)) //search for a new target to study
				if(isturf(subject.loc) && !subject.stat)
					movement_target = subject
					break

		if(study_target)
			if (get_dist(src, study_target) < 5)
				set_dir(get_dir(src, study_target))
				if(prob(25))
					visible_emote(pick("looks inquisitively at [study_target].","studies [study_target].","observes [study_target]."))
					if(prob(50)) study_target = null

		if(movement_target)
			set_AI_busy(FALSE)
			walk_to(src,movement_target,0,3)

/mob/living/simple_animal/scp_131/proc/handle_flee_target()
	//see if we should stop fleeing
	if (flee_target && !(flee_target.loc in view(src)))
		flee_target = null
		set_AI_busy(FALSE)

	if (flee_target)
		if(prob(10)) say("Eeeeee!")
		else if(prob(10)) visible_emote(pick("flees from [flee_target].","anxiously avoids [flee_target].","cowers from [flee_target]."))
		set_AI_busy(FALSE)
		walk_away(src, flee_target, 7, 2)

/mob/living/simple_animal/scp_131/proc/set_flee_target(atom/A)
	if(A)
		flee_target = A
		turns_since_scan = 5

/mob/living/simple_animal/scp_131/attackby(var/obj/item/O, var/mob/user)
	. = ..()
	if(O.force)
		set_flee_target(user? user : src.loc)

/mob/living/simple_animal/scp_131/attack_hand(mob/living/carbon/human/M as mob)
	. = ..()
	if(M.a_intent == I_HURT || M.a_intent == I_DISARM)
		set_flee_target(M)

/mob/living/simple_animal/scp_131/ex_act()
	. = ..()
	set_flee_target(src.loc)

/mob/living/simple_animal/scp_131/bullet_act(var/obj/item/projectile/proj)
	. = ..()
	set_flee_target(proj.firer? proj.firer : src.loc)

/mob/living/simple_animal/scp_131/hitby(atom/movable/AM)
	. = ..()


/mob/living/simple_animal/scp_131/Life()
	..()

	// For everyone it sees
	for(var/mob/living/subject in oview(src,5))
		if (subject.SCP)
			if(prob(15)) // get curious!
				set_dir(get_dir(src, subject))
				visible_emote(pick("turns its curious eye towards [subject].","studies [subject].","gazes at [subject] in fascination."))

	turns_since_scan++
	if (turns_since_scan > 5)
		walk_to(src,0)
		turns_since_scan = 0

		if (flee_target) //fleeing takes precendence
			handle_flee_target()
		else
			handle_movement_target()

	if (stat || !friend)
		return
	if (get_dist(src, friend) <= 1)
		if (friend.stat >= DEAD || friend.is_asystole())
			if (prob((friend.stat < DEAD)? 50 : 15))
				var/verb = pick("jabbers", "babbles")
				audible_emote(pick("[verb] in distress.", "[verb] anxiously."))
		else
			if (prob(5))
				set_dir(get_dir(src, friend))
				visible_emote(pick("whirrs around [friend]'s legs.",
								   "rolls around near [friend].",
								   "stares briefly up at [friend].",
								   "seems to follow [friend]'s gaze."))
	else if (friend.health <= 50)
		if (prob(10))
			var/verb = pick("jabbers", "babbles")
			audible_emote("[verb] in fear.", "[verb] nervously.")

	update_icon()
