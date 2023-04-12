
// This code seriously needs some love.
// TODO: Make this not terrible.

GLOBAL_LIST_EMPTY(scp2343s)
/mob/living/carbon/human/scp2343
	desc = "A brusk and wiley man."
	SCP = /datum/scp/scp_343
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7
	icon = 'icons/SCP/scp_2343.dmi'
	icon_state = "americangod"
	status_flags = NO_ANTAG


/datum/scp/scp_2343
	name = "SCP-2343"
	designation = "2343"
	classification = SAFE

/mob/living/carbon/human/scp2343/IsAdvancedToolUser()
	return TRUE

/mob/living/carbon/human/scp2343/Login()
	. = ..()
	if(client)
		add_language(LANGUAGE_ENGLISH)
		add_language(LANGUAGE_HUMAN_FRENCH)
		add_language(LANGUAGE_HUMAN_GERMAN)
		add_language(LANGUAGE_HUMAN_SPANISH)
		if(!(MUTATION_XRAY in mutations))
			mutations.Add(MUTATION_XRAY)
			update_mutations()
			update_sight()
	if(target)
		target = null

/mob/living/carbon/human/scp2343/Logout()
	. = ..()
	if(mind)
		mind = null
	if(target)
		target = null

/mob/living/carbon/human/scp2343/Initialize()
	update_icons()

	// fix names
	real_name = "SCP-2343"
	SetName(real_name)
	if(mind)
		mind.name = real_name

	GLOB.scp2343s += src
	add_verb(src, /mob/living/carbon/human/scp2343/proc/phase_through_airlock)
	return ..()

/mob/living/carbon/human/scp2343/Destroy()
	GLOB.scp2343s -= src
	return ..()

/mob/living/carbon/human/scp2343/forceMove(destination)
	. = ..(destination)

/mob/living/carbon/human/scp2343/update_icons()
	return

/mob/living/carbon/human/scp2343/on_update_icon()
	if (lying || resting)
		var/matrix/M =  matrix()
		transform = M.Turn(90)
	else
		transform = null
	return

/mob/living/carbon/human/scp2343/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp2343/handle_breath()
	return 1

/mob/living/carbon/human/scp2343/movement_delay()
	return 3.0

/mob/living/carbon/human/attack_hand(mob/living/carbon/M)
	if (!isscp2343(M) || src == M)
		return ..(M)
	var/mob/living/carbon/human/scp2343/H = M
	if (H.a_intent == I_HELP)
		to_chat(H, SPAN_WARNING("You start to heal [src] wounds"))
		visible_message(SPAN_NOTICE("\The [H] starts to heal [src] wounds"))
		if( do_after(H, 120) )
			src.revive()
			visible_message(SPAN_NOTICE("\The [H] fully healed [src]!"))
		return
	switch (stat)
		if (CONSCIOUS, UNCONSCIOUS)
			visible_message("<span class = 'danger'><big>[H] strikes [src], sent it flying away!</big></span>")
			var/atom/throw_target = get_edge_target_turf(src, get_dir(src, get_step_away(src, src)))
			Stun(3)
			throw_at(throw_target, 200, 4)


#define PHASE_TIME (2 SECONDS)
/mob/living/carbon/human/scp2343/var/phase_cooldown = -1
/mob/living/carbon/human/scp2343/proc/phase_through_airlock()
	set name = "Phase Through Object"
	set category = "SCP"
	set desc = "Phase through an object in front of you."

	if (world.time < phase_cooldown)
		to_chat(src, "<span class = 'warning'>You can't phase again yet.</span>")
		return

	for (var/obj/O in get_step(src, dir))

		if (!isstructure(O) && !ismachinery(O))
			continue

		if (istype(O, /obj/machinery/camera))
			continue

		if (istype(O, /obj/structure/cable))
			continue

		if (istype(O, /obj/structure/catwalk))
			continue

		if (istype(O, /obj/machinery/light))
			continue

		if (istype(O, /obj/machinery/power/apc))
			continue

		if (istype(O, /obj/machinery/button))
			continue

		if (istype(O, /obj/machinery/power/terminal))
			continue

		var/turf/target = get_turf(O)
		if (target.density)
			return

		visible_message("<span class = 'danger'>[src] starts to phase through \the [O].</span>")

		phase_cooldown = world.time + PHASE_TIME + 0.5 SECONDS

		alpha = 128

		layer = OBSERVER_LAYER

		switch(dir)
			if (NORTH, NORTHEAST, NORTHWEST)
				animate(src, pixel_y = 58, time = PHASE_TIME)
			if (SOUTH, SOUTHEAST, SOUTHWEST)
				animate(src, pixel_y = -58, time = PHASE_TIME)
			if (EAST)
				animate(src, pixel_x = 58, time = PHASE_TIME)
			if (WEST)
				animate(src, pixel_x = -58, time = PHASE_TIME)

		if (do_after(src, PHASE_TIME, O))
			forceMove(get_step(src, dir))
			visible_message("<span class = 'danger'>[src] phases through \the [O].</span>")


		alpha = 255
		layer = MOB_LAYER + 0.1
		pixel_x = 0
		pixel_y = 0
		break
#undef PHASE_TIME
