/obj/structure
	icon = 'icons/obj/structures.dmi'
	w_class = ITEM_SIZE_NO_CONTAINER
	layer = STRUCTURE_LAYER

	var/breakable
	var/parts
	var/list/connections = list("0", "0", "0", "0")
	var/list/other_connections = list("0", "0", "0", "0")
	var/list/blend_objects = newlist() // Objects which to blend with
	var/list/noblend_objects = newlist() //Objects to avoid blending with (such as children of listed blend objects.
	var/material/material = null
	var/footstep_type
	var/mob_offset = 0 //used for on_structure_offset mob animation

/obj/structure/attack_generic(mob/user, damage, attack_verb, wallbreaker)
	if(wallbreaker && damage && breakable)
		visible_message(SPAN_DANGER("\The [user] smashes \the [src] to pieces!"))
		attack_animation(user)
		qdel(src)
		return 1
	visible_message(SPAN_DANGER("\The [user] [attack_verb] \the [src]!"))
	attack_animation(user)
	damage_health(damage, BRUTE)
	return 1

/obj/structure/proc/mob_breakout(mob/living/escapee)
	set waitfor = FALSE
	return FALSE

/obj/structure/Destroy()
	reset_mobs_offset()
	var/turf/T = get_turf(src)
	if(T && parts)
		new parts(T)
	. = ..()
	if(istype(T))
		T.fluid_update()

/obj/structure/Crossed(mob/living/M)
	if(istype(M))
		M.on_structure_offset(mob_offset)
	..()

/obj/structure/proc/reset_mobs_offset()
	for(var/mob/living/M in loc)
		M.on_structure_offset(0)

/obj/structure/Initialize()
	. = ..()
	if(!CanFluidPass())
		fluid_update()

/obj/structure/Move()
	. = ..()
	if(. && !CanFluidPass())
		fluid_update()

/obj/structure/attackby(obj/item/O, mob/user)
	if(user.a_intent != I_HELP && istype(O, /obj/item/natural_weapon))
		//Bit dirty, but the entire attackby chain seems kinda wrong to begin with
		//Things should probably be parent first and return true if something handled it already, not child first
		src.add_fingerprint(user)
		attack_generic(user, O.force, pick(O.attack_verb))
		return
	. = ..()

/obj/structure/attack_hand(mob/user)
	..()
	if(MUTATION_FERAL in user.mutations)
		attack_generic(user,10,"smashes")
		user.setClickCooldown(CLICK_CD_ATTACK*2)
		attack_animation(user)
		playsound(loc, 'sound/weapons/tablehit1.ogg', 40, 1)
	if(breakable)
		if(MUTATION_HULK in user.mutations)
			user.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ))
			attack_generic(user,1,"smashes")
		else if(istype(user,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = user
			if(H.species.can_shred(user))
				attack_generic(user,1,"slices")
	return ..()

/obj/structure/grab_attack(obj/item/grab/G)
	if (!G.force_danger())
		to_chat(G.assailant, SPAN_DANGER("You need a better grip to do that!"))
		return TRUE
	if (G.assailant.a_intent == I_HURT)
		// Slam their face against the table.
		var/blocked = G.affecting.get_blocked_ratio(BP_HEAD, BRUTE, damage = 8)
		if (prob(30 * (1 - blocked)))
			G.affecting.Weaken(5)
		G.affecting.apply_damage(8, BRUTE, BP_HEAD)
		visible_message(SPAN_DANGER("[G.assailant] slams [G.affecting]'s face against \the [src]!"))
		if (material)
			playsound(loc, material.tableslam_noise, 50, 1)
		else
			playsound(loc, 'sound/weapons/tablehit1.ogg', 50, 1)
		damage_health(rand(1, 5), BRUTE)
		qdel(G)
	else if(atom_flags & ATOM_FLAG_CLIMBABLE)
		var/obj/occupied = turf_is_crowded()
		if (occupied)
			to_chat(G.assailant, SPAN_DANGER("There's \a [occupied] in the way."))
			return TRUE
		G.affecting.forceMove(src.loc)
		G.affecting.Weaken(rand(2,5))
		visible_message(SPAN_DANGER("[G.assailant] puts [G.affecting] on \the [src]."))
		qdel(G)
		return TRUE

/obj/structure/proc/can_visually_connect()
	return anchored

/obj/structure/proc/can_visually_connect_to(obj/structure/S)
	return istype(S, src)

/obj/structure/proc/refresh_neighbors()
	for(var/thing in RANGE_TURFS(src, 1))
		var/turf/T = thing
		T.update_icon()

/obj/structure/proc/update_connections(propagate = 0)
	var/list/dirs = list()
	var/list/other_dirs = list()

	for(var/obj/structure/S in orange(src, 1))
		if(can_visually_connect_to(S))
			if(S.can_visually_connect())
				if(propagate)
					S.update_connections()
					S.update_icon()
				dirs += get_dir(src, S)

	if(!can_visually_connect())
		connections = list("0", "0", "0", "0")
		other_connections = list("0", "0", "0", "0")
		return FALSE

	for(var/direction in GLOB.cardinal)
		var/turf/T = get_step(src, direction)
		var/success = 0
		for(var/b_type in blend_objects)
			if(istype(T, b_type))
				success = 1
				if(propagate)
					var/turf/simulated/wall/W = T
					if(istype(W))
						W.update_connections(1)
				if(success)
					break
			if(success)
				break
		if(!success)
			for(var/obj/O in T)
				for(var/b_type in blend_objects)
					if(istype(O, b_type))
						success = 1
						for(var/obj/structure/S in T)
							if(can_visually_connect_to(S))
								success = 0
						for(var/nb_type in noblend_objects)
							if(istype(O, nb_type))
								success = 0

					if(success)
						break
				if(success)
					break

		if(success)
			dirs += get_dir(src, T)
			other_dirs += get_dir(src, T)

	refresh_neighbors()

	connections = dirs_to_corner_states(dirs)
	other_connections = dirs_to_corner_states(other_dirs)
	return TRUE

/obj/structure/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			qdel(src)
			return
		if(EXPLODE_HEAVY)
			if(prob(50))
				qdel(src)
				return
		if(EXPLODE_LIGHT)
			return
