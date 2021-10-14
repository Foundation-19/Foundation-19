GLOBAL_LIST_EMPTY(scp343s)

/mob/living/carbon/human/scp343
	desc = "A mysterious powerful man."
	SCP = /datum/scp/SCP_343
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

/mob/living/carbon/human/scp343/examine(mob/user)
	user << "<b><span class = 'euclid'><big>SCP-343</big></span></b> - [desc]"

/datum/scp/SCP_343
	name = "SCP-343"
	designation = "343"
	classification = SAFE

/obj/sprite_helper/scp343
	icon = 'icons/mob/scp343.dmi'

/mob/living/carbon/human/scp343/IsAdvancedToolUser()
	return FALSE

/mob/living/carbon/human/scp343/New()
	..()

	spawn (20)
		fix_icons()

		// fix names
		real_name = "SCP-343"
		SetName(real_name)
		if(mind)
			mind.name = real_name

	set_species("SCP-343")
	GLOB.scp343s += src

	verbs += /mob/living/carbon/human/scp343/proc/phase_through_airlock


/mob/living/carbon/human/scp343/Destroy()
	GLOB.scp343s -= src
	..()

/mob/living/carbon/human/scp343/Move()
	..()
	update_stuff()

/mob/living/carbon/human/scp343/forceMove(destination)
	. = ..(destination)
	update_stuff()

/mob/living/carbon/human/scp343/proc/update_stuff()
	// stand_icon tends to come back after movement
	fix_icons()

/mob/living/carbon/human/scp343/proc/fix_icons()
	icon = null
	icon_state = null
	stand_icon = null
	lying_icon = null
	update_icon = FALSE

	if (!vis_contents.len)
		vis_contents += new /obj/sprite_helper/scp343

	// we're lying, turn right
	var/obj/sprite_helper/scp343/SH = vis_contents[vis_contents.len]

	if (lying || resting)
		SH.icon = turn(icon('icons/mob/scp343.dmi'), 90)
	else
		SH.icon = 'icons/mob/scp343.dmi'

	SH.dir = dir

/mob/living/carbon/human/scp343/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp343/handle_breath()
	return 1

/mob/living/carbon/human/scp343/movement_delay()
	return 1.0

/mob/living/carbon/human/attack_hand(mob/living/carbon/M)
	if (!isscp343(M) || src == M)
		return ..(M)
	var/mob/living/carbon/human/scp343/H = M
	if (H.a_intent == I_HELP)
		to_chat(H, "<span class='warning'>You start to heal [src] wounds</span>")
		visible_message("<span class='notice'>\The [H] starts to heal [src] wounds</span>")
		if( do_after(H, 120) )
			src.revive()
			visible_message("<span class='notice'>\The [H] fully healed [src]!</span>")
		return
	switch (stat)
		if (CONSCIOUS, UNCONSCIOUS)
			visible_message("<span class = 'danger'><big>[H] strikes [src], sent it flying away!</big></span>")
			var/atom/throw_target = get_edge_target_turf(src, get_dir(src, get_step_away(src, src)))
			Stun(3)
			throw_at(throw_target, 200, 4)


#define PHASE_TIME (2 SECONDS)
/mob/living/carbon/human/scp343/var/phase_cooldown = -1
/mob/living/carbon/human/scp343/proc/phase_through_airlock()
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

		for (var/obj/OO in get_turf(O))
			if (OO.density && OO != O)
				continue

		var/turf/target = get_step(O, dir)
		if (target.density)
			continue

		visible_message("<span class = 'danger'>[src] starts to phase through \the [O].</span>")

		phase_cooldown = world.time + PHASE_TIME + 5

		var/initial_loc = loc
		var/atom/sprite = null

		alpha = 128
		for (var/atom in vis_contents)
			var/atom/a = atom
			a.alpha = 128
			a.layer = 5.1
			sprite = a

		if (sprite)
			for (var/v in 1 to 58)
				spawn (round(v * 0.5, 0.1))
					if (!src || !O || loc != initial_loc)
						goto __fixsprite__
					else
						switch (get_dir(src, O))
							if (NORTH, NORTHEAST, NORTHWEST)
								++sprite.pixel_y
							if (SOUTH, SOUTHEAST, SOUTHWEST)
								--sprite.pixel_y
							if (EAST)
								++sprite.pixel_x
							if (WEST)
								--sprite.pixel_x

		if (do_after(src, PHASE_TIME, O))
			forceMove(get_step(src, dir))
			forceMove(get_step(src, dir))
			visible_message("<span class = 'danger'>[src] phases through \the [O].</span>")

		__fixsprite__

		alpha = 255
		for (var/atom in vis_contents)
			var/atom/a = atom
			a.alpha = 255
			a.layer = MOB_LAYER + 0.1
			a.pixel_x = 0
			a.pixel_y = 0

		break
#undef PHASE_TIME