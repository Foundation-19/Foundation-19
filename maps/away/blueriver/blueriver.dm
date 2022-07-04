//quality code theft
#include "blueriver_areas.dm"
/obj/effect/overmap/visitable/sector/arcticplanet
	name = "arctic moon"
	desc = "Sensor arrays detect a tiny moon with sub-zero surface conditions and sparse flora, possibly seeded from Earth species.<br><br>Topographical scans highlight the profile of a small vessel, located on the western side of a valley surrounded by mineral-rich mountains, broadcasting no callsign or identification codes. Subterranean energy signatures are present and constantly fluctuating, and highly in excess of expected levels.<br><br>The moon has a very long rotational period, with sunrise in an estimated 56 hours."
	in_space = 0
	known = 1
	icon_state = "globe"
	initial_generic_waypoints = list(
		"nav_blueriv_1",
		"nav_blueriv_2",
		"nav_blueriv_3",
		"nav_blueriv_antag"
	)

/obj/effect/overmap/visitable/sector/arcticplanet/Initialize()
	. = ..()
	name = "[generate_planet_name()], \an [name]"
	var/matrix/M = new
	M.Turn(90)
	transform = M

/datum/map_template/ruin/away_site/blueriver
	name = "Bluespace River"
	id = "awaysite_blue"
	spawn_cost = 2
	description = "Two z-level map with an arctic planet and an alien underground surface"
	suffixes = list("blueriver/blueriver-1.dmm", "blueriver/blueriver-2.dmm")
	generate_mining_by_z = 2
	area_usage_test_exempted_root_areas = list(/area/bluespaceriver)
	apc_test_exempt_areas = list(
		/area/bluespaceriver/underground = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/bluespaceriver/ground = NO_SCRUBBER|NO_VENT|NO_APC
	)

//This is ported from /vg/ and isn't entirely functional. If it sees a threat, it moves towards it, and then activates it's animation.
//At that point while it sees threats, it will remain in it's attack stage. It's a bug, but I figured it nerfs it enough to not be impossible to deal with
/mob/living/simple_animal/hostile/hive_alien/defender
	name = "hive defender"
	desc = "A terrifying monster resembling a massive, bloated tick in shape. Hundreds of blades are hidden underneath its rough shell."
	icon = 'maps/away/blueriver/blueriver.dmi'
	icon_state = "hive_executioner_move"
	icon_living = "hive_executioner_move"
	icon_dead = "hive_executioner_dead"
	move_to_delay = 5
	speed = -1
	health = 280
	maxHealth = 280
	can_escape = TRUE

	harm_intent_damage = 8
	natural_weapon = /obj/item/natural_weapon/defender_blades
	ai_holder_type = /datum/ai_holder/simple_animal/melee/defender
	var/attack_mode = FALSE

	var/transformation_delay_min = 4
	var/transformation_delay_max = 8

/datum/ai_holder/simple_animal/melee/defender/lose_target()
	. = ..()
	var/mob/living/simple_animal/hostile/hive_alien/defender/D = holder
	if(D.attack_mode && !find_target()) //If we don't immediately find another target, switch to movement mode
		D.mode_movement()

	return ..()

/datum/ai_holder/simple_animal/melee/defender/lose_target()
	. = ..()
	var/mob/living/simple_animal/hostile/hive_alien/defender/D = holder
	if(D.attack_mode && !find_target()) //If we don't immediately find another target, switch to movement mode
		D.mode_movement()

	return ..()

/datum/ai_holder/simple_animal/melee/defender/engage_target()
	. = ..()
	var/mob/living/simple_animal/hostile/hive_alien/defender/D = holder
	if(!D.attack_mode)
		return D.mode_attack()

	flick("hive_executioner_attacking", src)

	return ..()
/obj/item/natural_weapon/defender_blades
	name = "blades"
	attack_verb = list("eviscerated")
	force = 30
	edge = TRUE
	hitsound = 'sound/weapons/slash.ogg'

/mob/living/simple_animal/hostile/hive_alien/defender/proc/mode_movement() //Slightly broken, but it's alien and unpredictable so w/e
	set waitfor = 0
	icon_state = "hive_executioner_move"
	flick("hive_executioner_movemode", src)
	sleep(rand(transformation_delay_min, transformation_delay_max))
	anchored = FALSE
	speed = -1
	move_to_delay = 8
	. = FALSE

	//Immediately find a target so that we're not useless for 1 Life() tick!
	ai_holder.find_target()

/mob/living/simple_animal/hostile/hive_alien/defender/proc/mode_attack()
	set waitfor = 0
	icon_state = "hive_executioner_attack"
	flick("hive_executioner_attackmode", src)
	sleep(rand(transformation_delay_min, transformation_delay_max))
	anchored = TRUE
	speed = 0
	attack_mode = TRUE
	walk(src, 0)

/mob/living/simple_animal/hostile/hive_alien/defender/wounded
	name = "wounded hive defender"
	health = 80
	can_escape = FALSE

/obj/effect/shuttle_landmark/nav_blueriv/nav1
	name = "Arctic Moon Landing Point #1"
	landmark_tag = "nav_blueriv_1"
	base_area = /area/bluespaceriver/ground

/obj/effect/shuttle_landmark/nav_blueriv/nav2
	name = "Arctic Moon Landing Point #2"
	landmark_tag = "nav_blueriv_2"
	base_area = /area/bluespaceriver/ground

/obj/effect/shuttle_landmark/nav_blueriv/nav3
	name = "Arctic Moon Landing Point #3"
	landmark_tag = "nav_blueriv_3"
	base_area = /area/bluespaceriver/ground

/obj/effect/shuttle_landmark/nav_blueriv/nav4
	name = "Arctic Moon Navpoint #4"
	landmark_tag = "nav_blueriv_antag"
	base_area = /area/bluespaceriver/ground

/turf/simulated/floor/blueriver
	name = "glowing floor"
	desc = "The ground here is made of indeterminate substance. It shimmers gently, without any apparent cause."
	icon = 'riverturfs.dmi'
	icon_state = "floor"
	temperature = 233

/turf/simulated/floor/blueriver/Initialize()
	. = ..()
	set_light(0.7, 1, 5, l_color = "#0066ff")

/turf/simulated/wall/iron/blueriver
	name = "alien wall"
	desc = "Its surface seems to be constantly moving, as if it were breathing. You feel a sense of lightheadedness just from looking at it."
	icon = 'riverturfs.dmi'
	icon_state = "evilwall_1"
	temperature = 233

/turf/simulated/wall/iron/blueriver/Initialize()
	. = ..()
	icon_state = "evilwall_[rand(1, 8)]"

/turf/simulated/wall/iron/blueriver/update_material()
	. = ..()
	name = initial(name)
	desc = initial(desc)

/turf/simulated/wall/iron/blueriver/on_update_icon()
	return

/turf/simulated/wall/iron/blueriver/update_connections(propagate)
	return // No connected textures for these walls

/turf/unsimulated/floor/bluespace_river
	name = "blue river"
	desc = "This looks like a sort of semi-solid liquid, with the consistency of slime. It glows a shade of blue that's strangely familiar, and flows silently under the influence of some unseen force."
	icon = 'blueriver.dmi'
	icon_state = "bluespacecrystal1"
	opacity = FALSE

/turf/unsimulated/floor/bluespace_river/Initialize()
	. = ..()
	icon_state = "bluespacecrystal[rand(1, 3)]"
	set_light(0.7, 1, 5, l_color = "#0066ff")

/turf/unsimulated/floor/bluespace_river/attackby(obj/item/W, mob/user)
	if (istype(W, /obj/item/stack/material/rods))
		to_chat(user, SPAN_WARNING("There's nothing to support a catwalk here. It seems that existing catwalks were built from one side, then moved over as a bridge."))
		return
	else if (istype(W, /obj/item/device/ano_scanner))
		user.visible_message(
			SPAN_NOTICE("\The [user] takes a reading from \the [src] with \the [W]."),
			SPAN_NOTICE("You wave \the [W] as close to \the [src] as you can get without touching it."),
			SPAN_ITALIC("You hear two fast beeps.")
		)
		playsound(user, 'sound/effects/fastbeep.ogg', 20)
		if (user.skill_check(SKILL_SCIENCE, SKILL_BASIC))
			to_chat(user, SPAN_NOTICE("\
			\The [src]'s readings are irregular - oscillating rapidly from intense exotic energy counts one moment, dropping to almost nothing the next. \
			Strangely, its coordinate readout also seems to be affected, becoming exponentially more inaccurate the closer it gets. \
			You can't draw any conclusions, but you can safely conclude that, whatever it is, you should <i><b>not</b></i> touch it."))
		else
			to_chat(user, SPAN_NOTICE("\
			You can see that the scanner immediately acts up, with its readings fluctuating crazily, but you don't understand what any of it means. \
			You can at least make an educated guess that, whatever it is, you should give it a wide berth."))
		return
	user.drop_from_inventory(W)
	chomp_chomp_yummy_explorers(W)

/turf/unsimulated/floor/bluespace_river/attack_hand(mob/user)
	if (user.pulling)
		. = ..() // we're moving something else onto the tile
		user.stop_pulling()
		return
	user.visible_message(
		SPAN_WARNING("\The [user] reaches out..."),
		SPAN_WARNING("You reach out towards \the [src]...")
	)
	if (!do_after(user, 5 SECONDS))
		user.visible_message(
			SPAN_WARNING("\The [user] pulls \himself back."),
			SPAN_WARNING("You draw away from \the [src].")
		)
		return
	chomp_chomp_yummy_explorers(user)

/turf/unsimulated/floor/bluespace_river/attack_robot(mob/user)
	attack_hand(user)

/turf/unsimulated/floor/bluespace_river/attack_generic(mob/user)
	attack_hand(user)

/turf/unsimulated/floor/bluespace_river/Bumped(atom/AM)
	// gently inform the player that this is an invisible wall, essentially
	// this only procs on dense turfs, which means it's only the ones blocking further progression
	if (isliving(AM))
		var/mob/living/L = AM
		to_chat(L, SPAN_WARNING("\The [src] continues through thin crevices, winding deeper into the moon. You can't safely go any further."))

/turf/unsimulated/floor/bluespace_river/Crossed(atom/movable/M)
	. = ..()
	if (locate(/obj/structure/catwalk) in src || !can_erase(M))
		return
	if (isliving(M)) // we don't include this in `can_erase()` so that mobs can still manually touch/be shoved into the goop and not be deleted
		var/mob/living/L = M
		if (!L.lying && L.can_overcome_gravity())
			return
	chomp_chomp_yummy_explorers(M)

/// Returns whether or not this blue river turf can consume an item.
/turf/unsimulated/floor/bluespace_river/proc/can_erase(atom/A)
	if (ismovable(A))
		var/atom/movable/AM = A
		if (AM.throwing) // wait 'til objects and mobs finish flying through the air
			if (AM.throwing.target_turf == src)
				return TRUE
			else
				return FALSE
	return !QDELETED(A) && A.simulated && !isobserver(A) && !istype(A, /obj/item/projectile) && has_gravity(A)

/// Deletes the provided atom from existence forever with a spooky message. Mobs will leave behind an afterimage that slowly fades away.
/turf/unsimulated/floor/bluespace_river/proc/chomp_chomp_yummy_explorers(atom/movable/M)
	if (!can_erase(M))
		return
	if (isliving(M))
		var/mob/living/L = M
		L.visible_message(
			SPAN_DANGER("\The [L] makes contact with \the [src]... and then goes completely still."),
			SPAN_DANGER(FONT_LARGE("You [L.loc == src ? "fall into" : "touch"] \the [src]. Instantly, you feel a tingling, starting inside of you, and then spreading out. \
			As your mind and body are completely erased from existence, you realize: you never were the real one, were you?")),
		)

		// Create an afterimage of the mob that slowly fades off
		// The actual mob is instantly deleted - this is just for effect
		// It's inspired by what an observer theoretically sees when something passes the event horizon of a black hole!
		var/obj/effect/temporary/T = new (get_turf(L), 30 SECONDS)

		T.icon = image(M)
		T.icon_state = M.icon_state
		T.copy_overlays(M)
		T.layer = MOB_LAYER
		T.set_dir(M.dir)

		T.anchored = TRUE
		T.name = M.name
		T.gender = M.gender
		var/datum/gender/G = gender_datums[M.gender]
		T.desc = "A picture-perfect image of \the [T], [G.his] body and expression unmoving. [G.He] [G.is] slowly fading away, into nothing."
		T.mouse_opacity = M.mouse_opacity

		animate(T, color = "#0066ff", alpha = 0, time = 30 SECONDS)
		if (L.key)
			log_and_message_admins("made contact with a bluespace river turf and was deleted.", L)
		L.death(TRUE)
		L.ghostize() // preserve image for ghosts and such
		QDEL_IN(L, 0) // We run a timer for this because otherwise it produces nullrefs
	else
		M.visible_message(SPAN_WARNING("\The [M] makes contact with \the [src], and instantly blinks out of existence!"))
		qdel(M)

/obj/machinery/crystal_static/blueriver
	name = "crystal outcrop"
	desc = "Slightly translucent, like frosted glass. You aren't sure what it is, but it seems like it's gradually grown around a central core."
	alpha = 120
	anchored = TRUE
	color = "blue"
	stat_immune = NOSCREEN | NOINPUT | NOPOWER

/obj/machinery/crystal_static/blueriver/Initialize()
	. = ..()
	name = "crystal [pick("cluster", "outcrop", "shards", "accretion")]"

/obj/machinery/crystal_static/blueriver/attackby(obj/item/I, mob/user)
	if (istype(I, /obj/item/device/ano_scanner))
		user.visible_message(
			SPAN_NOTICE("\The [user] takes a reading from \the [src] with \the [I]."),
			SPAN_NOTICE("You scan \the [src] with \the [I]."),
			SPAN_ITALIC("You hear two fast beeps.")
		)
		playsound(user, 'sound/effects/fastbeep.ogg', 20)
		if (user.skill_check(SKILL_SCIENCE, SKILL_BASIC))
			to_chat(user, SPAN_NOTICE("\The [I]'s readout is wildly sporadic. \
			It picks up fluctuating levels of exotic energy, followed by nothing - almost like a flickering light. \
			You can conclude, at least, that \the [src] is inert and harmless; it's anomalous, but no more dangerous to touch than a window. \
			Judging by its structure and positioning, you can conclude that it might have gradually accrued around the center, almost like mineral buildup in a faucet. \
			Whether that's a natural phenomenon or something artificial is anyone's guess."))
		else
			to_chat(user, SPAN_NOTICE("\The [I]'s readings seem strange. \
			They fluctate constantly, going between the high and low end of the spectrum on a whim, and with no obvious pattern. \
			You don't know what any of it means, but it doesn't seem dangerous to be around."))
		return
	. = ..()
