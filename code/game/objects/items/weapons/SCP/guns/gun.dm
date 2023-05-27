

/obj/item/gun/projectile/scp
	/// Bool for determining bolt state
	var/is_bolt_open = FALSE
	/// Bool for determining is gun cocked or not. If it isn't cocked and your gun is in single action, it won't fire after you click it.
	var/is_cocked = FALSE
	/// Single or double action, determines the need to cock gun before firing. Rifles and other auto are single-action, while most pistols are double.
	var/action_type = GUN_SINGLE_ACTION
	/// Side of ejection: left, right or down
	var/ejection_side = GUN_CASING_EJECTION_RIGHT
	var/bolt_back_sound = 'sound/weapons/guns/interaction/reload_bolt_back.ogg'
	var/bolt_forward_sound = 'sound/weapons/guns/interaction/reload_bolt_forward.ogg'
	/// Determines the need to draw and `update_icon()` of bolt after cycling
	var/has_bolt_icon = FALSE
	/// Determines the need for rendering stock. Won't render if null.
	var/stock_icon
	/// Determines the need for rendering front end, needed for when gun is too long. Won't render if null.
	var/foreend_icon
	/// Pixel_x offset of stock
	var/stock_offset = -4
	/// Pixel_x offset of foreend
	var/foreend_offset = 20
	/// Time of last bolt cycle, needed for manual bolt cycling cooldown
	var/last_bolt_cycle = 0
	/// Determines if bolt stays open on manual cycle if magazine is empty
	var/bolt_hold = FALSE
	/// Determines if bolt stays open on automatic cycle if magazine is empty
	var/bolt_hold_on_empty_mag = FALSE
	/// Determines the need to cycle bolt manually after each shot (pump action shotgun)
	var/manual_action = FALSE
	fire_sound = null
	appearance_flags = KEEP_TOGETHER
	item_icons = list(
		slot_l_hand_str = 'icons/SCP/guns/onmob/lefthand_guns.dmi',
		slot_r_hand_str = 'icons/SCP/guns/onmob/righthand_guns.dmi',
		)


/obj/item/gun/projectile/scp/MouseDrop(obj/over_object)
	handle_mousedrop_unload(over_object)

/obj/item/gun/projectile/scp/proc/handle_mousedrop_unload(obj/over_object)
	var/mob/living/carbon/human/user = usr
	if (!over_object || !(ishuman(user)))
		return
	if (loc != user)
		return
	if(user.incapacitated())
		return
	if(!ammo_magazine)
		return

	switch(over_object.name)
		if("r_hand")
			if(!user.put_in_r_hand(ammo_magazine))
				unload_ammo(user, allow_dump = TRUE)
				return
		if("l_hand")
			if(!user.put_in_l_hand(ammo_magazine))
				unload_ammo(user, allow_dump = TRUE)
				return
		else
			return

	user.visible_message("[user] removes [ammo_magazine] from [src].",
	SPAN_NOTICE("You remove [ammo_magazine] from [src]."))
	playsound(src.loc, mag_remove_sound, 70)
	ammo_magazine.update_icon()
	ammo_magazine = null
	update_icon()
	return 1

// TODO make all skill-checks into function

/obj/item/gun/projectile/scp/proc/firemode_switch_action(mob/user)
	var/datum/firemode/new_mode = switch_firemodes(user)
	if(prob(20) && !user.skill_check(SKILL_WEAPONS, SKILL_BASIC))
		new_mode = switch_firemodes(user)
	if(new_mode)
		to_chat(user, SPAN_NOTICE("\The [src] is now set to [new_mode.name]."))

/obj/item/gun/projectile/scp/AltClick(mob/user)
	firemode_switch_action(user)
	return TRUE

/obj/item/gun/projectile/scp/MiddleClick(mob/user)
	firemode_switch_action(user)
	return TRUE

/obj/item/gun/projectile/scp/attack_self(mob/user)
	if(world.time < last_bolt_cycle + 1 SECOND)
		return
	last_bolt_cycle = world.time
	if(!is_bolt_open)
		cycle_bolt(manual = TRUE)
	else
		bolt_forward(manual = TRUE)
	if(has_bolt_icon)
		update_icon()


/// Moving back backwards and forward, loading cartridge from magazine. Setting manual variable adds cycling sounds and delay between actions
/obj/item/gun/projectile/scp/proc/cycle_bolt(manual)
	bolt_back(manual)

	if(check_magazine_empty() && ((ammo_magazine && bolt_hold_on_empty_mag) || (manual && bolt_hold)))
		return

	if(manual)
		sleep(5)
	bolt_forward(manual)

/obj/item/gun/projectile/scp/proc/bolt_back(manual)
	is_bolt_open = TRUE
	if(manual && bolt_back_sound)
		playsound(src, bolt_back_sound, 70)
	if(chambered)
		ejectCasing(manual)
	is_cocked = TRUE


/obj/item/gun/projectile/scp/proc/bolt_forward(manual)
	if(manual && bolt_forward_sound)
		playsound(src, bolt_forward_sound, 70)
	load_round_from_magazine()
	is_bolt_open = FALSE

/obj/item/gun/projectile/scp/proc/check_magazine_empty()
	if(length(loaded)) // FIXME switch to magazine/internal instead of loaded list
		return FALSE
	if(ammo_magazine && length(ammo_magazine.stored_ammo))
		return FALSE
	return TRUE

/obj/item/gun/projectile/scp/proc/load_round_from_magazine()
	if(chambered)
		return
	if(length(loaded))
		chambered = loaded[1]
		loaded -= chambered
		return 1
	if(ammo_magazine && length(ammo_magazine.stored_ammo))
		chambered = ammo_magazine.stored_ammo[length(ammo_magazine.stored_ammo)]
		ammo_magazine.stored_ammo -= chambered
		return 1

/obj/item/gun/projectile/scp/proc/process_jam()
	if(!is_jammed && prob(jam_chance))
		src.visible_message(SPAN_DANGER("\The [src] jams!"))
		is_jammed = 1
		var/mob/user = loc
		if(istype(user))
			if(prob(user.skill_fail_chance(SKILL_WEAPONS, 100, SKILL_MASTER)))
				return null
			else
				to_chat(user, SPAN_NOTICE("You reflexively clear the jam on \the [src]."))
				is_jammed = 0
				playsound(src.loc, 'sound/weapons/flipblade.ogg', 50, 1)


/obj/item/gun/projectile/scp/proc/can_fire(mob/user, atom/target)
	if(world.time < next_fire_time)
		if (world.time % 3) //to prevent spam
			to_chat(user, SPAN_WARNING("[src] is not ready to fire yet!"))
		return FALSE
	if(!user || !target)
		return FALSE
	if(target.z != user.z)
		return FALSE
	if(!waterproof && submerged())
		return FALSE
	if(is_bolt_open)
		return FALSE
	return TRUE

/obj/item/gun/projectile/scp/handle_click_empty(mob/user, is_cocked, automatic)
	if(is_cocked)
		playsound(src.loc, 'sound/weapons/guns/trigger_click.ogg', 40)
		user.visible_message("*click click*", SPAN_DANGER("*click*"))
		show_sound_effect(get_turf(src), user, SFX_ICON_SMALL)
		return
	if(!automatic)
		playsound(src.loc, 'sound/weapons/guns/trigger_empty.ogg', 10)
		to_chat(user, SPAN_DANGER("*click*"))

/obj/item/gun/projectile/scp/toggle_safety(mob/user)
	if (user?.is_physically_disabled())
		return

	safety_state = !safety_state
	update_icon()
	if(user)
		user.visible_message(SPAN_WARNING("[user] switches the safety of \the [src] [safety_state ? "on" : "off"]."), SPAN_NOTICE("You switch the safety of \the [src] [safety_state ? "on" : "off"]."), range = 3)
		last_safety_check = world.time
		playsound(src, selector_sound, 20, 1)


// TODO split this proc into couple more

/obj/item/gun/projectile/scp/Fire(atom/target, mob/living/user, clickparams, pointblank=0, reflex=0, set_click_cooldown = TRUE, automatic)
	if(!can_fire(user, target))
		return

	add_fingerprint(user)

	if(safety()) // TODO Move to separate function
		if(user.a_intent == I_HURT && !user.skill_fail_prob(SKILL_WEAPONS, 100, SKILL_EXPERIENCED, 0.5)) //reflex un-safeying
			toggle_safety(user)
		else
			handle_click_safety(user)
			return

	if(!special_check(user))
		return

	if(!is_cocked && action_type == GUN_SINGLE_ACTION)
		handle_click_empty(user, is_cocked, automatic)
		return

	last_safety_check = world.time

	if(set_click_cooldown)
		var/shoot_time = (burst - 1) * burst_delay
		user.setClickCooldown(shoot_time) //no clicking on things while shooting
		next_fire_time = world.time + shoot_time

	var/held_twohanded = (user.can_wield_item(src) && is_held_twohanded(user))

	//actually attempt to shoot
	var/turf/targloc = get_turf(target) //cache this in case target gets deleted during shooting, e.g. if it was a securitron that got destroyed.
	for(var/i in 1 to burst)
		if(is_bolt_open) // FIXME Shouldn't really work like that...
			return
		var/obj/projectile = consume_next_projectile(user)
		if(!projectile)
			handle_click_empty(user, is_cocked, automatic)
			is_cocked = FALSE
			break

		process_accuracy(projectile, user, target, i, held_twohanded)

		var/obj/item/projectile/P = projectile
		if(istype(P)) // only for real projectiles
			P.shot_from = src.name

		if(pointblank)
			process_point_blank(projectile, user, target)

		if(process_projectile(projectile, user, target, user.zone_sel?.selecting, clickparams))
			handle_post_fire(user, target, pointblank, reflex)
			update_icon()

		if(i < burst)
			sleep(burst_delay)

		if(!(target && target.loc))
			target = targloc
			pointblank = 0

	//update timing
	var/delay = max(burst_delay+1, fire_delay)
	user.setClickCooldown(min(delay, DEFAULT_QUICK_COOLDOWN))
	user.SetMoveCooldown(move_delay) // FIXME Maybe run and gun???
	next_fire_time = world.time + delay

/obj/item/gun/projectile/scp/handle_autofire()
	set waitfor = FALSE
	. = TRUE
	if(QDELETED(autofiring_at) || QDELETED(autofiring_by))
		. = FALSE
	else if(autofiring_by.get_active_hand() != src || autofiring_by.incapacitated())
		. = FALSE
	else if(!autofiring_by.client || !(autofiring_by in view(autofiring_by.client.view, autofiring_by)))
		. = FALSE
	if(!.)
		clear_autofire()
	else if(can_autofire())
		autofiring_by.set_dir(get_dir(src, autofiring_at))
		Fire(autofiring_at, autofiring_by, null, (get_dist(autofiring_at, autofiring_by) <= 1), FALSE, FALSE, TRUE)


/obj/item/gun/projectile/scp/consume_next_projectile()
	if(is_jammed)
		return

	if(chambered)
		return chambered.expend()

// TODO rewrite this piece of shit

/obj/item/gun/projectile/scp/handle_post_fire(mob/user, atom/target, pointblank=0, reflex=0)
	if(combustion)
		var/turf/curloc = get_turf(src)
		if(curloc)
			curloc.hotspot_expose(700, 5)

	if(!user)
		return

	if(istype(user,/mob/living/carbon/human) && user.is_cloaked()) //shooting will disable a rig cloaking device
		var/mob/living/carbon/human/H = user
		if(istype(H.back,/obj/item/rig))
			var/obj/item/rig/R = H.back
			for(var/obj/item/rig_module/stealth_field/S in R.installed_modules)
				S.deactivate()

	var/user_message = SPAN_WARNING("You fire \the [src][pointblank ? " point blank":""] at \the [target][reflex ? " by reflex" : ""]!")
	if (silenced)
		to_chat(user, user_message)
	else
		user.visible_message(
			SPAN_DANGER("\The [user] fires \the [src][pointblank ? " point blank":""] at \the [target][reflex ? " by reflex" : ""]!"),
			user_message,
			SPAN_DANGER("You hear a [fire_sound_text]!")
		)

	if (pointblank && ismob(target))
		admin_attack_log(user, target,
			"shot point blank with \a [type]",
			"shot point blank with \a [type]",
			"shot point blank (\a [type])"
		)

	if(one_hand_penalty)
		if(!src.is_held_twohanded(user))
			switch(one_hand_penalty)
				if(4 to 6)
					if(prob(50)) //don't need to tell them every single time
						to_chat(user, SPAN_WARNING("Your aim wavers slightly."))
				if(6 to 8)
					to_chat(user, SPAN_WARNING("You have trouble keeping \the [src] on target with just one hand."))
				if(8 to INFINITY)
					to_chat(user, SPAN_WARNING("You struggle to keep \the [src] on target with just one hand!"))
		else if(!user.can_wield_item(src))
			switch(one_hand_penalty)
				if(4 to 6)
					if(prob(50)) //don't need to tell them every single time
						to_chat(user, SPAN_WARNING("Your aim wavers slightly."))
				if(6 to 8)
					to_chat(user, SPAN_WARNING("You have trouble holding \the [src] steady."))
				if(8 to INFINITY)
					to_chat(user, SPAN_WARNING("You struggle to hold \the [src] steady!"))

	if(screen_shake)
		var/shake_mult = 3 / user.get_skill_value(SKILL_WEAPONS)
		INVOKE_ASYNC(GLOBAL_PROC, /proc/directional_recoil, user, shake_mult * (screen_shake+1), Get_Angle(user, target))

	if(!manual_action)
		cycle_bolt()

	update_icon()

/obj/item/gun/projectile/scp/proc/ejectCasing(manual)
	if(!chambered)
		return
	chambered.forceMove(get_turf(src))
	chambered.set_dir(pick(GLOB.alldirs))
	var/hor_eject_vel = rand(45, 55) / 10
	var/vert_eject_vel = rand(40, 45) / 10
	var/angle_of_movement = rand(-20, 20)

	if(manual)
		hor_eject_vel *= 0.5
		vert_eject_vel *= 0.5

	if(istype(chambered, /obj/item/ammo_casing/shotgun) && !manual)
		hor_eject_vel *= 0.7
		vert_eject_vel *= 0.7

	switch(ejection_side)
		if(GUN_CASING_EJECTION_DOWN)
			hor_eject_vel = rand(0, 2)
			vert_eject_vel = -2
			angle_of_movement = rand(0, 360)
		if(GUN_CASING_EJECTION_RIGHT)
			angle_of_movement += dir2angle(turn(loc.dir, -90))
		if(GUN_CASING_EJECTION_DOWN)
			angle_of_movement += dir2angle(turn(loc.dir, 90))

	pixel_z = 8
	chambered.SpinAnimation(4, 1)
	chambered.AddComponent(/datum/component/movable_physics, _horizontal_velocity = hor_eject_vel, \
		_vertical_velocity = vert_eject_vel, _horizontal_friction = rand(20, 24) / 100, _z_gravity = 9.8, \
		_z_floor = 0, _angle_of_movement = angle_of_movement, _physic_flags = QDEL_WHEN_NO_MOVEMENT, \
		_bounce_sounds = chambered.fall_sounds)
	chambered = null

/obj/item/gun/projectile/scp/on_update_icon()
	..()
	if(stock_icon)
		var/image/stock = image(icon, stock_icon)
		stock.pixel_x = stock_offset
		add_overlay(stock)

	if(foreend_icon)
		var/image/foreend = image(icon, foreend_icon)
		foreend.pixel_x = foreend_offset
		add_overlay(foreend)

	if(ammo_magazine && ammo_magazine.gun_mag_icon && generate_mag_icon_state())
		add_overlay(image(icon, generate_mag_icon_state()))

	if(has_bolt_icon)
		add_overlay(image(icon, "bolt_[is_bolt_open ? "open" : "closed"]"))


/obj/item/gun/projectile/scp/proc/generate_mag_icon_state()
	return ammo_magazine.gun_mag_icon

/obj/item/gun/projectile/scp/play_fire_sound(mob/user, obj/item/projectile/P)
	var/shot_sound = fire_sound? fire_sound : P.fire_sound
	if(!shot_sound)
		return
	if(silenced)
		playsound(user, shot_sound, 15, 1) //TODO add sil_sound variable
		show_sound_effect(get_turf(src), user, SFX_ICON_SMALL)
	else
		playsound(user, shot_sound, 85, 1)
		show_sound_effect(get_turf(src), user, SFX_ICON_JAGGED)

/obj/item/gun/projectile/scp/examine(mob/user)
	. = ..()
	to_chat(user, "It's caliber is [caliber].")
	if(is_jammed && user.skill_check(SKILL_WEAPONS, SKILL_BASIC))
		to_chat(user, SPAN_WARNING("It looks jammed."))
	to_chat(user, "It has [chambered ? "a round chambered" : "no chambered round"].")
	if(ammo_magazine)
		to_chat(user, "It has \a [ammo_magazine] loaded.")
	if(user.skill_check(SKILL_WEAPONS, SKILL_TRAINED))
		to_chat(user, "Has [get_ammo_count()] round\s remaining.") //FIXME remove loaded ammo counter

#define EXP_TAC_RELOAD 1 SECOND
#define PROF_TAC_RELOAD 0.5 SECONDS
#define EXP_SPD_RELOAD 0.5 SECONDS
#define PROF_SPD_RELOAD 0.25 SECONDS

/obj/item/gun/projectile/scp/proc/handle_casing_insertion(obj/item/ammo_casing/C, mob/user)
	if(caliber != C.caliber)
		return
	if(is_bolt_open && !chambered)
		if(!user.unEquip(C, src))
			return
		chambered = C
		. = TRUE
	else if (load_method == SINGLE_CASING)
		if(length(loaded) >= max_shells)
			to_chat(user, SPAN_WARNING("[src] is full."))
			return
		if(!user.unEquip(C, src))
			return
		loaded.Insert(1, C) //add to the head of the list
		. = TRUE
	if(!.)
		return
	user.visible_message("[user] inserts \a [C] into [src].", SPAN_NOTICE("You insert \a [C] into [src]."))
	playsound(loc, load_sound, 50, 1)
	update_icon()

/obj/item/gun/projectile/scp/proc/handle_tactical_reload(obj/item/ammo_magazine/AM, mob/user)
	if(user.a_intent == I_HELP || user.a_intent == I_DISARM || !user.skill_check(SKILL_WEAPONS, SKILL_EXPERIENCED))
		to_chat(user, SPAN_WARNING("[src] already has a magazine loaded."))//already a magazine here
		return
	if(user.a_intent == I_GRAB) //Tactical reloading
		if(!can_special_reload)
			to_chat(user, SPAN_WARNING("You can't tactically reload this gun!"))
			return
		//Experienced gets a 1 second delay, master gets a 0.5 second delay
		if(!do_after(user, user.get_skill_value(SKILL_WEAPONS) == SKILL_MASTER ? PROF_TAC_RELOAD : EXP_TAC_RELOAD, src))
			return
		if(!user.unEquip(AM, src))
			return
		ammo_magazine.update_icon()
		user.put_in_hands(ammo_magazine)
		user.visible_message(SPAN_WARNING("\The [user] reloads \the [src] with \the [AM]!"),\
							SPAN_WARNING("You tactically reload \the [src] with \the [AM]!"))
	else //Speed reloading
		if(!can_special_reload)
			to_chat(user, SPAN_WARNING("You can't speed reload with this gun!"))
			return
		//Experienced gets a 0.5 second delay, master gets a 0.25 second delay
		if(!do_after(user, user.get_skill_value(SKILL_WEAPONS) == SKILL_MASTER ? PROF_SPD_RELOAD : EXP_SPD_RELOAD, src))
			return
		if(!user.unEquip(AM, src))
			return
		ammo_magazine.update_icon()
		ammo_magazine.dropInto(user.loc)
		user.visible_message(SPAN_WARNING("\The [user] reloads \the [src] with \the [AM]!"),\
							SPAN_WARNING("You speed reload \the [src] with \the [AM]!"))
	ammo_magazine = AM
	playsound(loc, mag_insert_sound, 75, 1)
	show_sound_effect(loc, user, SFX_ICON_SMALL)
	update_icon()
	AM.update_icon()


/obj/item/gun/projectile/scp/proc/handle_magazine_insertion(obj/item/ammo_magazine/AM, mob/user)
	if((ispath(allowed_magazines) && !istype(AM, allowed_magazines)) || (islist(allowed_magazines) && !is_type_in_list(AM, allowed_magazines)))
		to_chat(user, SPAN_WARNING("\The [AM] won't fit into [src]."))
		return
	if(ammo_magazine)
		handle_tactical_reload(AM, user)
		return
	if(!user.unEquip(AM, src))
		return
	ammo_magazine = AM
	user.visible_message("[user] inserts [AM] into [src].", SPAN_NOTICE("You insert [AM] into [src]."))
	playsound(loc, mag_insert_sound, 50, 1)
	show_sound_effect(loc, user, SFX_ICON_SMALL)
	update_icon()
	AM.update_icon()

/obj/item/gun/projectile/scp/proc/handle_speedloader_reload(obj/item/ammo_magazine/AM, mob/user)
	if(length(loaded) >= max_shells)
		to_chat(user, SPAN_WARNING("[src] is full!"))
		return
	var/count = 0
	for(var/obj/item/ammo_casing/C in AM.stored_ammo)
		if(length(loaded) >= max_shells)
			break
		if(C.caliber == caliber)
			C.forceMove(src)
			loaded += C
			AM.stored_ammo -= C
			count++
	if(count)
		user.visible_message("[user] reloads [src].", SPAN_NOTICE("You load [count] round\s into [src]."))
		playsound(src.loc, 'sound/weapons/empty.ogg', 50, 1)
		AM.update_icon()
		update_icon()

/obj/item/gun/projectile/scp/load_ammo(obj/item/A, mob/user)
	if(istype(A, /obj/item/ammo_casing))
		handle_casing_insertion(A, user)
		return TRUE

	if(!istype(A, /obj/item/ammo_magazine))
		return
	. = TRUE
	var/obj/item/ammo_magazine/AM = A
	if(!(load_method & AM.mag_type) || caliber != AM.caliber)
		return //incompatible

	switch(AM.mag_type)
		if(MAGAZINE)
			handle_magazine_insertion(AM, user)
			return
		if(SPEEDLOADER)
			handle_speedloader_reload(AM, user)
			return

#undef EXP_TAC_RELOAD
#undef PROF_TAC_RELOAD
#undef EXP_SPD_RELOAD
#undef PROF_SPD_RELOAD
