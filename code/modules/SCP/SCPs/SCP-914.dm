// The structure spawns "auxiliary units" automatically, only spawn this one
/obj/structure/scp_914
	name = "SCP 914"
	desc = "A large clockwork device consisting of numerous parts and sections."
	icon = 'icons/obj/scp914.dmi'
	icon_state = "center"
	anchored = TRUE
	density = TRUE

	var/current_mode = MODE_ONE_TO_ONE
	/// When TRUE - cannot be interacted with at all
	var/processing = FALSE
	/// When higher than world.time - cannot be operated
	var/activation_cooldown = 0
	var/activation_cooldown_time = 10 SECONDS
	// Disgusting list I needed for the "knob" to work
	var/list/available_modes = list(
		MODE_ROUGH,
		MODE_COARSE,
		MODE_ONE_TO_ONE,
		MODE_FINE,
		MODE_VERY_FINE,
		)

	var/list/connected_parts = list()
	var/obj/structure/scp_914_input_booth/input_part = null
	var/obj/structure/scp_914_output_booth/output_part = null

/obj/structure/scp_914/Initialize()
	. = ..()
	input_part = new(get_step(get_step(src, WEST), WEST))
	output_part = new(get_step(get_step(src, EAST), EAST))
	connected_parts += input_part
	connected_parts += output_part
	connected_parts += new /obj/structure/scp_914_input_connector(get_step(src, WEST))
	connected_parts += new /obj/structure/scp_914_output_connector(get_step(src, EAST))

/obj/structure/scp_914/Destroy()
	for(var/obj/O in connected_parts)
		QDEL_NULL(O)
	connected_parts = null
	input_part = null
	output_part = null
	return ..()

/obj/structure/scp_914/examine(mob/user)
	. = ..()
	to_chat(user, SPAN_NOTICE("The knob is currently pointing towards \"[current_mode]\"."))

/obj/structure/scp_914/attack_hand(mob/user)
	if(!CanOperate(user))
		return FALSE

	var/switch_dir = get_dir(user, src)
	switch(switch_dir)
		if(EAST, NORTHEAST)
			switch_dir = -1
		else
			switch_dir = 1

	var/switch_num = 1
	for(var/i = 1 to length(available_modes))
		if(available_modes[switch_num] == current_mode)
			break
		switch_num += 1
	switch_num += switch_dir
	if(switch_num > length(available_modes))
		switch_num = 1
	else if(switch_num < 1)
		switch_num = length(available_modes)

	current_mode = available_modes[switch_num]
	playsound(src, 'sound/machines/lever_flip.ogg', 25, TRUE)
	user.visible_message(
		SPAN_NOTICE("\The [user] puts [src] on \"[current_mode]\" mode."),
		SPAN_NOTICE("You put [src] on \"[current_mode]\" mode."))
	return TRUE

/obj/structure/scp_914/MouseDrop_T(mob/target, mob/user)
	if(target == user)
		return Activate(user)
	return ..()

/obj/structure/scp_914/proc/CanOperate(mob/user)
	if(!isliving(user)) // Silently forbid them from operating it
		return FALSE

	if(processing)
		to_chat(user, SPAN_WARNING("\The [src] is currently processing something!"))
		return FALSE

	// All parts must be there and connected
	if(!(istype(input_part) && istype(output_part) && length(connected_parts) >= 4))
		to_chat(user, SPAN_DANGER("\The [src] is broken!"))
		return FALSE

	return TRUE

/obj/structure/scp_914/proc/Activate(mob/user)
	if(!CanOperate(user))
		return FALSE

	if(activation_cooldown > world.time)
		to_chat(user, SPAN_WARNING("\The [src] was used too recently to be activated again!"))
		return FALSE

	processing = TRUE
	playsound(src, 'sound/scp/914/refine.ogg', 75, FALSE, 14)
	user.visible_message(
		SPAN_NOTICE("\The [user] activates \the [src]!"),
		SPAN_NOTICE("You activate \the [src]!"))

	var/obj/effect/temp_visual/scp914_door_effect/D1 = new(get_turf(input_part))
	var/obj/effect/temp_visual/scp914_door_effect/D2 = new(get_turf(output_part))
	animate(D1, pixel_z = 0, alpha = 255, time = (2 SECONDS))
	animate(D2, pixel_z = 0, alpha = 255, time = (2 SECONDS))

	sleep(2 SECONDS)

	playsound(input_part, 'sound/scp/914/door_close.ogg', 50, TRUE, -4)
	playsound(output_part, 'sound/scp/914/door_close.ogg', 50, TRUE, -4)

	var/list/upgrade_items = list()
	for(var/atom/movable/A in get_turf(input_part))
		if(A.anchored)
			continue
		if(ismob(A))
			playsound(src, 'sound/scp/914/mob_use.ogg', 100, TRUE, 24)
		upgrade_items += A
		A.forceMove(src)

	input_part.set_density(TRUE)
	output_part.set_density(TRUE)

	sleep(11 SECONDS)
	if(QDELETED(src) || !istype(output_part))
		QDEL_NULL(D1)
		QDEL_NULL(D2)
		return

	// THE UPGRADENING!!!
	for(var/atom/movable/A in upgrade_items)
		// Even if it gets deleted, some objects have effects on destruction, so let's keep them at output
		A.forceMove(get_turf(output_part))
		var/CR = A.Conversion914(current_mode)
		if(CR == A)
			continue
		if(islist(CR))
			for(var/atom/movable/AR in CR)
				AR.forceMove(get_turf(output_part))
				if(isitem(AR))
					AR.pixel_x = clamp(A.pixel_x, -16, 16)
					AR.pixel_y = clamp(A.pixel_y, -16, 16)
			QDEL_NULL(A)
			continue
		QDEL_NULL(A)
		var/atom/movable/NA = new CR(get_turf(output_part))
		// Keep offsets if item
		if(isitem(NA))
			NA.pixel_x = clamp(A.pixel_x, -16, 16)
			NA.pixel_y = clamp(A.pixel_y, -16, 16)
	upgrade_items = null

	activation_cooldown = world.time + activation_cooldown_time
	processing = FALSE

	animate(D1, pixel_z = 16, alpha = 0, time = (1 SECONDS))
	animate(D2, pixel_z = 16, alpha = 0, time = (1 SECONDS))
	input_part.set_density(FALSE)
	output_part.set_density(FALSE)
	playsound(input_part, 'sound/scp/914/door_open.ogg', 50, TRUE, -4)
	playsound(output_part, 'sound/scp/914/door_open.ogg', 50, TRUE, -4)

// Support structures and effects
// Booths
/obj/structure/scp_914_input_booth
	name = "input booth"
	desc = "An input booth of a larger structure."
	icon = 'icons/obj/scp914.dmi'
	icon_state = "left"
	anchored = TRUE
	density = FALSE

/obj/structure/scp_914_output_booth
	name = "output booth"
	desc = "An output booth of a larger structure."
	icon = 'icons/obj/scp914.dmi'
	icon_state = "right"
	anchored = TRUE
	density = FALSE

// Connectors
/obj/structure/scp_914_input_connector
	name = "input tube"
	desc = "A large copper tube with word \"Input\" written on a plaque."
	icon = 'icons/obj/scp914.dmi'
	icon_state = "input"
	anchored = TRUE
	density = TRUE

/obj/structure/scp_914_output_connector
	name = "output tube"
	desc = "A large copper tube with word \"Output\" written on a plaque."
	icon = 'icons/obj/scp914.dmi'
	icon_state = "output"
	anchored = TRUE
	density = TRUE

// Door effect
/obj/effect/temp_visual/scp914_door_effect
	icon = 'icons/obj/scp914.dmi'
	icon_state = "door"
	pixel_z = 16
	duration = 15 SECONDS
	alpha = 0
