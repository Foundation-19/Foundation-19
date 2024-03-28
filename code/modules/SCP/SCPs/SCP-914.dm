// The structure spawns "auxiliary units" automatically, only spawn this one
/obj/structure/scp_914
	name = "SCP-914"
	desc = "A large clockwork device consisting of numerous parts and sections."
	icon = 'icons/SCP/SCP-914-64x64.dmi'
	icon_state = "center"
	bound_width = 64
	bound_height = 64
	anchored = TRUE
	density = TRUE

	var/current_mode = MODE_ONE_TO_ONE
	/// When TRUE - cannot be interacted with at all
	var/processing = FALSE
	/// When higher than world.time - cannot be operated
	var/activation_cooldown = 0
	var/activation_cooldown_time = 10 SECONDS
	/// Limit on how many atoms can go into 914 at once
	var/item_limit = 10
	// Disgusting list I needed for the "knob" to work
	var/list/available_modes = list(
		MODE_ROUGH,
		MODE_COARSE,
		MODE_ONE_TO_ONE,
		MODE_FINE,
		MODE_VERY_FINE,
		)

	var/list/parts_to_spawn = list(
		/obj/structure/scp_914_part/input_connector,
		/obj/structure/scp_914_part/output_connector,
		/obj/structure/scp_914_part/input_side,
		/obj/structure/scp_914_part/output_side,
		)
	var/list/connected_parts = list()
	var/obj/structure/scp_914_part/input_booth/input_part = null
	var/obj/structure/scp_914_part/output_booth/output_part = null

/obj/structure/scp_914/Initialize()
	. = ..()
	input_part = new(get_turf(src))
	output_part = new(get_turf(src))
	connected_parts += input_part
	connected_parts += output_part
	// Misc parts
	for(var/O in parts_to_spawn)
		connected_parts += new O(get_turf(src))

	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"clockwork mechanism", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"914" //Numerical Designation
	)

/obj/structure/scp_914/Destroy()
	for(var/obj/O in connected_parts)
		QDEL_NULL(O)
	connected_parts = null
	input_part = null
	output_part = null
	return ..()

/obj/structure/scp_914/ex_act()
	return

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
	playsound(src, 'sounds/machines/lever_flip.ogg', 25, TRUE)
	user.visible_message(
		SPAN_NOTICE("\The [user] puts [src] on \"[current_mode]\" mode."),
		SPAN_NOTICE("You put [src] on \"[current_mode]\" mode."))
	return TRUE

/obj/structure/scp_914/MouseDrop_T(mob/target, mob/user)
	if(target == user)
		return Activate(user)
	return ..()

/obj/structure/scp_914/proc/CanOperate(mob/user)
	if(!ishuman(user)) // Silently forbid them from operating it
		return FALSE

	if(user.SCP) // Some SCPs are humans, for whatever reason
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
	playsound(src, 'sounds/scp/914/refine.ogg', 75, FALSE, 14)
	user.visible_message(
		SPAN_NOTICE("\The [user] activates \the [src]!"),
		SPAN_NOTICE("You activate \the [src]!"))

	var/obj/effect/temp_visual/scp914_door_effect/D1 = new(get_turf(input_part))
	var/obj/effect/temp_visual/scp914_door_effect/D2 = new(get_turf(output_part))
	D1.pixel_x = -4
	D2.pixel_x = 4
	animate(D1, pixel_z = 0, alpha = 255, time = (2 SECONDS))
	animate(D2, pixel_z = 0, alpha = 255, time = (2 SECONDS))

	sleep(2 SECONDS)

	playsound(input_part, 'sounds/scp/914/door_close.ogg', 50, TRUE, -4)
	playsound(output_part, 'sounds/scp/914/door_close.ogg', 50, TRUE, -4)

	var/list/upgrade_items = list()
	var/current_count = 0
	for(var/atom/movable/A in get_turf(input_part))
		if(current_count >= item_limit)
			break
		if(A.anchored)
			continue
		if(ismob(A))
			playsound(src, 'sounds/scp/914/mob_use.ogg', 100, TRUE, 24)
		upgrade_items += A
		A.forceMove(src)
		current_count += 1

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
		var/CR = A.Conversion914(current_mode, user)
		if(CR == A)
			continue
		QDEL_NULL(A)
		if(islist(CR))
			for(var/AR_path in CR)
				var/atom/movable/AR = AR_path
				if(!isatom(AR))
					if(!ispath(AR)) // Something went wrong, uh oh
						continue
					AR = new AR_path(get_turf(output_part))
				AR.forceMove(get_turf(output_part))
				if(isitem(AR))
					AR.pixel_x = rand(-16, 16)
					AR.pixel_y = rand(-16, 16)
			continue
		var/atom/movable/NA = CR
		if(!isatom(NA)) // If return value was path
			if(!ispath(NA)) // Something went wrong, uh oh
				continue
			NA = new CR(get_turf(output_part))
		// Keep offsets if item
		if(isitem(NA))
			NA.pixel_x = rand(-16, 16)
			NA.pixel_y = rand(-16, 16)
	upgrade_items = null

	activation_cooldown = world.time + activation_cooldown_time
	processing = FALSE

	animate(D1, pixel_z = 16, alpha = 0, time = (1 SECONDS))
	animate(D2, pixel_z = 16, alpha = 0, time = (1 SECONDS))
	input_part.set_density(FALSE)
	output_part.set_density(FALSE)
	playsound(input_part, 'sounds/scp/914/door_open.ogg', 50, TRUE, -4)
	playsound(output_part, 'sounds/scp/914/door_open.ogg', 50, TRUE, -4)

// Support structures and effects
/obj/structure/scp_914_part
	name = "SCP-914 part"
	desc = "Why did you spawn this thing? It's not for you."
	anchored = TRUE
	density = TRUE
	/// The object will be moved this far to left/right on spawn
	var/spawn_x = 0

/obj/structure/scp_914_part/Initialize()
	. = ..()
	// If some moron spawned it by itself, without SCP-914
	if(!(locate(/obj/structure/scp_914) in get_turf(src)))
		. = INITIALIZE_HINT_QDEL
		CRASH("[name] was spawned without appropriate SCP-914 main object.")
	forceMove(locate(x + spawn_x, y, z))

/obj/structure/scp_914_part/ex_act()
	return

// Booths
/obj/structure/scp_914_part/input_booth
	name = "intake booth"
	desc = "An intake booth of a larger structure."
	icon = 'icons/SCP/SCP-914-32x64.dmi'
	icon_state = "left-door"
	bound_height = 64
	density = FALSE
	spawn_x = -2

/obj/structure/scp_914_part/output_booth
	name = "output booth"
	desc = "An output booth of a larger structure."
	icon = 'icons/SCP/SCP-914-32x64.dmi'
	icon_state = "right-door"
	bound_height = 64
	density = FALSE
	spawn_x = 3

// Sides
/obj/structure/scp_914_part/input_side
	name = "booth side"
	desc = "A metal part surrounding input booth."
	icon = 'icons/SCP/SCP-914-32x64.dmi'
	icon_state = "left"
	bound_height = 64
	spawn_x = -3

/obj/structure/scp_914_part/output_side
	name = "booth side"
	desc = "A metal part surrounding output booth."
	icon = 'icons/SCP/SCP-914-32x64.dmi'
	icon_state = "right"
	bound_height = 64
	spawn_x = 4

// Connectors
/obj/structure/scp_914_part/input_connector
	name = "intake tube"
	desc = "A large copper tube with word \"Intake\" written on a plaque."
	icon = 'icons/SCP/SCP-914-32x64.dmi'
	icon_state = "input"
	spawn_x = -1

/obj/structure/scp_914_part/output_connector
	name = "output tube"
	desc = "A large copper tube with word \"Output\" written on a plaque."
	icon = 'icons/SCP/SCP-914-32x64.dmi'
	icon_state = "output"
	spawn_x = 2

// Door effect
/obj/effect/temp_visual/scp914_door_effect
	icon = 'icons/SCP/SCP-914-32x64.dmi'
	icon_state = "door"
	pixel_z = 16
	duration = 15 SECONDS
	alpha = 0
