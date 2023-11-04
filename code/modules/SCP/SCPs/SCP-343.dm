/mob/living/carbon/human/scp343
	name = "strange elderly man"
	desc = "A mysterious powerful man. He looks a lot like what you would imagine god to look like."
	icon = 'icons/SCP/scp-343.dmi'

	icon_state = null

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	status_flags = CANPUSH|GODMODE

	//Config

	///Cooldown for our phasing ability
	var/phase_cooldown = 5 SECONDS
	///How long it takes us to phase
	var/phase_time = 2 SECONDS

	//Mechanical

	///Cooldow tracker for our phasing ability
	var/phase_cooldown_track

/mob/living/carbon/human/scp343/Initialize(mapload, new_species = "SCP-343")
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"strange elderly man", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"343", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY|SCP_DISABLED
	)

	add_language(LANGUAGE_ENGLISH)
	add_language(LANGUAGE_HUMAN_FRENCH)
	add_language(LANGUAGE_HUMAN_GERMAN)
	add_language(LANGUAGE_HUMAN_SPANISH)
	if(!(MUTATION_XRAY in mutations))
		mutations.Add(MUTATION_XRAY)
		update_mutations()
		update_sight()

	add_verb(src, /mob/living/carbon/human/scp343/verb/object_phase)

//Mechanics

/mob/living/carbon/human/scp343/verb/object_phase()
	set name = "Phase Through Object"
	set category = "SCP"
	set desc = "Phase through an object in front of you."

	if((world.time - phase_cooldown_track) < phase_cooldown)
		to_chat(src, SPAN_WARNING("You can't phase again yet."))
		return

	var/obj/target_object = null
	for(var/obj/O in get_step(src, dir))
		// Things that we will ignore
		if(!isstructure(O) && !ismachinery(O))
			continue

		if(!O.density)
			continue

		// Things that will block our phasing
		if(istype(O, /obj/machinery/shieldwall) || istype(O, /obj/machinery/shieldwallgen))
			to_chat(src, SPAN_WARNING("You cannot phase through [O]."))
			return

		// There can be more than one available dense object, but that doesn't matter
		target_object = O

	if(!istype(target_object))
		to_chat(src, SPAN_WARNING("There's nothing to phase through in that direction."))
		return

	var/turf/target_turf = get_step(target_object, dir)
	if(target_turf.density)
		to_chat(src, SPAN_WARNING("\The [target_turf] is preventing us from phasing in that direction."))
		return

	phase_cooldown_track = world.time

	// Mob effects
	var/old_layer = layer
	var/anim_x = 0
	var/anim_y = 0
	layer = OBSERVER_LAYER
	alpha = 128

	if(dir in list(NORTH, NORTHEAST, NORTHWEST))
		anim_y = 32
	if(dir in list(SOUTH, SOUTHEAST, SOUTHWEST))
		anim_y = -32
	if(dir in list(EAST, NORTHEAST, SOUTHEAST))
		anim_x = 32
	if(dir in list(WEST, NORTHWEST, SOUTHWEST))
		anim_x = -32
	animate(src, pixel_x = anim_x, pixel_y = anim_y, time = phase_time)

	if(do_after(src, phase_time, target_object))
		forceMove(get_step(src, dir))
		visible_message(SPAN_NOTICE("[src] silently phases through [target_object]"))

	layer = old_layer
	alpha = 255
	pixel_x = 0
	pixel_y = 0

//Overrides

/mob/living/carbon/human/scp343/UnarmedAttack(atom/A, proximity)
	if((a_intent == I_HURT) && iscarbon(A))
		to_chat(src, SPAN_WARNING("You know better than to hurt one of your own children."))
		return

	if((a_intent == I_HELP) && ismob(A))
		var/mob/living/target = A
		to_chat(src, SPAN_WARNING("You start to heal [target]'s wounds"))
		visible_message(SPAN_NOTICE("\The [src] starts to heal [target]'s wounds"))
		if(!do_after(src, 12 SECONDS, A, bonus_percentage = 25))
			return
		target.revive()
		visible_message(SPAN_NOTICE("\The [src] has fully healed [target]!"))
		return

	return ..()

/mob/living/carbon/human/scp343/IsAdvancedToolUser()
	return TRUE

/mob/living/carbon/human/scp343/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp343/handle_breath()
	return 1

/mob/living/carbon/human/scp343/movement_delay()
	return 3.0

//TODO: Change pathing of SCPs to no longer be humans so that we dont have to do this bullshit.
/mob/living/carbon/human/scp343/update_icons()
	return

/mob/living/carbon/human/scp343/on_update_icon()
	if(lying || resting)
		var/matrix/M =  matrix()
		transform = M.Turn(90)
	else
		transform = null
	return
