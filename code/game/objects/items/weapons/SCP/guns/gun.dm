#define GUN_SINGLE_ACTION "single_action"
#define GUN_DOUBLE_ACTION "double_action"

#define GUN_CASING_EJECTION_DOWN "ejection_down"
#define GUN_CASING_EJECTION_RIGHT "ejection_right"
#define GUN_CASING_EJECTION_LEFT "ejection_left"

/obj/item/gun/projectile/scp
	var/bolt_open = FALSE
	var/cocked = FALSE
	var/action_type = GUN_SINGLE_ACTION
	var/ejection_side = GUN_CASING_EJECTION_RIGHT
	var/bolt_back_sound = 'sound/weapons/guns/interaction/reload_bolt_back.ogg'
	var/bolt_forward_sound = 'sound/weapons/guns/interaction/reload_bolt_forward.ogg'
	var/has_bolt_icon = FALSE
	var/stock_icon
	var/foreend_icon
	var/stock_offset = -4
	var/foreend_offset = 20
	var/last_bolt_cycle = 0
	var/bolt_hold = FALSE
	var/bolt_hold_on_empty_mag = FALSE
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

/obj/item/gun/projectile/scp/AltClick(mob/user)
	var/datum/firemode/new_mode = switch_firemodes(user)
	if(prob(20) && !user.skill_check(SKILL_WEAPONS, SKILL_BASIC))
		new_mode = switch_firemodes(user)
	if(new_mode)
		to_chat(user, SPAN_NOTICE("\The [src] is now set to [new_mode.name]."))

/obj/item/gun/projectile/scp/attack_self(mob/user)
	if(world.time < last_bolt_cycle + 1 SECOND)
		return
	last_bolt_cycle = world.time
	if(!bolt_open)
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
	bolt_open = TRUE
	if(manual && bolt_back_sound)
		playsound(src, bolt_back_sound, 70)
	ejectCasing(manual)
	cocked = TRUE


/obj/item/gun/projectile/scp/proc/bolt_forward(manual)
	if(manual && bolt_forward_sound)
		playsound(src, bolt_forward_sound, 70)
	load_round_from_magazine()
	bolt_open = FALSE

/obj/item/gun/projectile/scp/proc/check_magazine_empty()
	if(ammo_magazine && length(ammo_magazine.stored_ammo))
		return FALSE
	return TRUE

/obj/item/gun/projectile/scp/proc/load_round_from_magazine()
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
			to_chat(user, SPAN_WARNING("[src] is not ready to fire again!"))
		return FALSE
	if(!user || !target)
		return FALSE
	if(target.z != user.z)
		return FALSE
	if(!waterproof && submerged())
		return FALSE
	if(bolt_open)
		return FALSE
	return TRUE

/obj/item/gun/projectile/scp/handle_click_empty(mob/user)
	if (user)
		user.visible_message("*click click*", SPAN_DANGER("*click*"))
	else
		src.visible_message("*click click*")
	playsound(src.loc, 'sound/weapons/empty.ogg', 100, 1)
	show_sound_effect(get_turf(src), user, SFX_ICON_SMALL)

/obj/item/gun/projectile/scp/toggle_safety(mob/user)
	if (user?.is_physically_disabled())
		return

	safety_state = !safety_state
	update_icon()
	if(user)
		user.visible_message(SPAN_WARNING("[user] switches the safety of \the [src] [safety_state ? "on" : "off"]."), SPAN_NOTICE("You switch the safety of \the [src] [safety_state ? "on" : "off"]."), range = 3)
		last_safety_check = world.time
		playsound(src, selector_sound, 25, 1)

/obj/item/gun/projectile/scp/Fire(atom/target, mob/living/user, clickparams, pointblank=0, reflex=0, set_click_cooldown = TRUE)
	if(!can_fire(user, target))
		return

	add_fingerprint(user)

	if(safety())
		if(user.a_intent == I_HURT && !user.skill_fail_prob(SKILL_WEAPONS, 100, SKILL_EXPERIENCED, 0.5)) //reflex un-safeying
			toggle_safety(user)
		else
			handle_click_safety(user)
			return

	if(!special_check(user))
		return

	if(!cocked && action_type == GUN_SINGLE_ACTION)
		return
	cocked = FALSE

	last_safety_check = world.time

	if(set_click_cooldown)
		var/shoot_time = (burst - 1) * burst_delay
		user.setClickCooldown(shoot_time) //no clicking on things while shooting
		next_fire_time = world.time + shoot_time

	var/held_twohanded = (user.can_wield_item(src) && is_held_twohanded(user))

	//actually attempt to shoot
	var/turf/targloc = get_turf(target) //cache this in case target gets deleted during shooting, e.g. if it was a securitron that got destroyed.
	for(var/i in 1 to burst)
		var/obj/projectile = consume_next_projectile(user)
		if(bolt_open)
			return
		if(!projectile)
			handle_click_empty(user)
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
	user.SetMoveCooldown(move_delay)
	next_fire_time = world.time + delay


/obj/item/gun/projectile/scp/consume_next_projectile()
	if(is_jammed)
		return

	if(chambered)
		return chambered.expend()

/obj/item/gun/projectile/scp/handle_post_fire(mob/user, atom/target, pointblank=0, reflex=0)
	if(combustion)
		var/turf/curloc = get_turf(src)
		if(curloc)
			curloc.hotspot_expose(700, 5)

	if(istype(user,/mob/living/carbon/human) && user.is_cloaked()) //shooting will disable a rig cloaking device
		var/mob/living/carbon/human/H = user
		if(istype(H.back,/obj/item/rig))
			var/obj/item/rig/R = H.back
			for(var/obj/item/rig_module/stealth_field/S in R.installed_modules)
				S.deactivate()

	if(!user)
		return

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

	// If your skill in weapons is higher than/equal to (screen_shake + 2) - it won't shake at all.
	if(screen_shake)
		var/shake_mult = 3 / user.get_skill_value(SKILL_WEAPONS)
		INVOKE_ASYNC(GLOBAL_PROC, /proc/directional_recoil, user, shake_mult * (screen_shake+1), Get_Angle(user, target))

	if(chambered)
		cycle_bolt()

	update_icon()

/obj/item/gun/projectile/scp/proc/ejectCasing(manual)
	chambered.forceMove(get_turf(src))
	var/hor_eject_vel = rand(45, 55) / 10
	var/vert_eject_vel = rand(40, 45) / 10
	var/angle_of_movement = rand(-20, 20)

	if(istype(chambered, /obj/item/ammo_casing/shotgun) || manual)
		hor_eject_vel /= 2
		vert_eject_vel /= 2

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
		add_overlay(image(icon, "bolt_[bolt_open ? "open" : "closed"]"))


/obj/item/gun/projectile/scp/proc/generate_mag_icon_state()
	return ammo_magazine.gun_mag_icon

/obj/item/gun/projectile/scp/play_fire_sound(mob/user, obj/item/projectile/P)
	var/shot_sound = fire_sound? fire_sound : P.fire_sound
	if(!shot_sound)
		return
	if(silenced)
		playsound(user, shot_sound, 15, 1)
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
		to_chat(user, "Has [get_ammo_count()] round\s remaining.")











/*
	Automatic
*/

/obj/item/gun/projectile/scp/automatic
	bulk = -1
	load_method = MAGAZINE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 3)
	slot_flags = SLOT_BACK
	multi_aim = 1
	burst_delay = 2
	mag_insert_sound = 'sound/weapons/guns/interaction/smg_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/smg_magout.ogg'

	//machine pistol, easier to one-hand with
	firemodes = list(
		list(mode_name="3-round bursts", burst=3, fire_delay=null, one_hand_penalty=4, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 1.6, 2.4, 2.4)),
		list(mode_name="short bursts",   burst=5, fire_delay=null, one_hand_penalty=5, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(1.6, 1.6, 2.0, 2.0, 2.4)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=5, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(1.0, 1.0, 1.2, 1.4, 1.6), autofire_enabled=1)
	)

/*
	Rifles
*/
/obj/item/gun/projectile/scp/automatic/m4a1
	name = "M4A1"
	desc = "A Foundation-standard service carbine that takes 5.56x45mm magazines."
	icon = 'icons/SCP/guns/rifles/m4carbine.dmi'
	icon_state = "m4carbine"
	item_state = "m4"
	force = 13
	slot_flags = SLOT_BACK
	caliber = "5.56x45mm"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/m16_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/m16_mag
	stock_icon = "stock"
	foreend_icon = "fore-end"

	bolt_back_sound = 'sound/weapons/guns/m4a1/m4a1_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/m4a1/m4a1_forward.ogg'
	mag_insert_sound = 'sound/weapons/guns/m4a1/m4a1_load.ogg'
	mag_remove_sound = 'sound/weapons/guns/m4a1/m4a1_unload.ogg'
	fire_sound = 'sound/weapons/guns/m4a1/shoot.ogg'
	has_bolt_icon = TRUE
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=1, one_hand_penalty=3, burst_accuracy=list(0,-1,-2), dispersion=list(0.0, 0.5, 0.8)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/projectile/scp/automatic/t12
	name = "T12 rifle"
	desc = "An assault rifle produced and used by the Global Occult Coalition, rarely seen loaned to high-intensity Foundation units. Highly lethal and capable of holding up to 50 rounds in its standard magazines."
	icon = 'icons/SCP/guns/rifles/g36c.dmi'
	icon_state = "g36c"
	item_state = "t12"
	force = 14
	caliber = CALIBER_T12
	origin_tech = list(TECH_COMBAT = 7, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	slot_flags = SLOT_BACK
	handle_casings = CLEAR_CASINGS
	magazine_type = /obj/item/ammo_magazine/t12
	allowed_magazines = /obj/item/ammo_magazine/t12
	one_hand_penalty = 6
	accuracy_power = 7
	accuracy = 2
	bulk = GUN_BULK_RIFLE
	wielded_item_state = "t12-wielded"
	stock_icon = "stock"
	foreend_icon = "fore-end"
	has_bolt_icon = TRUE
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE
	bolt_back_sound = 'sound/weapons/guns/t12/bolt_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/t12/bolt_forward.ogg'
	mag_insert_sound = 'sound/weapons/guns/t12/m4a1_load.ogg'
	mag_remove_sound = 'sound/weapons/guns/t12/m4a1_unload.ogg'
	fire_sound = 'sound/weapons/guns/t12/fire1.ogg'

	firemodes = list(
		list(mode_name="semi auto",      burst=1,    fire_delay=null, one_hand_penalty=8,  burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3,    fire_delay=null, burst_delay=1.4,     one_hand_penalty=9,  burst_accuracy=list(0,-1),    dispersion=list(0.0, 0.4, 0.8)),
		list(mode_name="full auto",      burst=1,    fire_delay=0,    burst_delay=0.5,     one_hand_penalty=11, burst_accuracy=list(0,-1,-2), dispersion=list(0.1, 0.5, 0.9), autofire_enabled=1)
		)

/obj/item/gun/projectile/scp/automatic/ak12
	name = "AK-12"
	desc = "A 5.45x39mm modernized variant of the AK-74M, exported from Russia."
	icon = 'icons/SCP/guns/rifles/ak12.dmi'
	icon_state = "ak12"
	item_state = "ak74"
	force = 10
	slot_flags = SLOT_BACK
	caliber = "5.45x39mm"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/ak
	allowed_magazines = /obj/item/ammo_magazine/scp/ak
	stock_icon = "stock"
	foreend_icon = "fore-end"
	foreend_offset = 17
	bolt_hold = FALSE
	bolt_hold_on_empty_mag = FALSE
	has_bolt_icon = TRUE
	mag_insert_sound = 'sound/weapons/guns/ak12/mag_in.ogg'
	mag_remove_sound = 'sound/weapons/guns/ak12/mag_out.ogg'
	fire_sound = 'sound/weapons/guns/ak12/shoot.ogg'
	bolt_back_sound = 'sound/weapons/guns/ak12/ak74_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/ak12/ak74_forward.ogg'

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.1, 0.7, 1.1), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/galil
	name = "IWI Galil ACE"
	desc = "An intermediate cartridge infantry assault rifle first produced by and for Israeli Forces. The Foundation found a use for these reliable rifles in the hands of Foundation operatives and guards."
	icon_state = "galil"
	item_state = "galil-empty"
	icon = 'icons/obj/gun.dmi'
	force = 10
	slot_flags = SLOT_BACK
	caliber = "5.56x45mm"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/m16_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/m16_mag

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=1, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.5, 0.8)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/galil/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "galil"
	else
		icon_state = "galil-empty"
	return

/obj/item/gun/projectile/automatic/svd
	name = "SVD"
	desc = "Yet another spin on the AK platform, this SVD is a scoped sniper rifle with far greater range thanks to it's longer barrel and updated rifling and profile."
	icon_state = "svd"
	item_state = "svd"
	icon = 'icons/obj/gun.dmi'
	force = 10
	slot_flags = SLOT_BACK
	caliber = "7.62x54mmR"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/svd
	allowed_magazines = /obj/item/ammo_magazine/scp/svd

	firemodes = list(
		list(mode_name="semiauto", burst=1, fire_delay=0, move_delay=null, one_hand_penalty=5, burst_accuracy=null, dispersion=null)
		)

/obj/item/gun/projectile/automatic/svd/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "svd"
	else
		icon_state = "svd-empty"
	return

/obj/item/gun/projectile/automatic/fnfal
	name = "FN FAL"
	desc = "'The Right Arm Of Freedom', the standard issue firearm for the UNGOC and some other countries. This weapon has seen mutliple big conflicts."
	icon_state = "fnfal"
	item_state = "fnfal"
	icon = 'icons/obj/gun.dmi'
	force = 10
	slot_flags = SLOT_BACK
	caliber = "a762nato"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/fnfal
	allowed_magazines = /obj/item/ammo_magazine/scp/fnfal

	firemodes = list(
		list(mode_name="semiauto",       burst=1,    fire_delay=0,    move_delay=null, one_hand_penalty=5, burst_accuracy=null, dispersion=null),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/fnfal/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "fnfal"
	else
		icon_state = "fnfal-empty"
	return

/*
	SMGs
*/

/obj/item/gun/projectile/scp/automatic/p90
	name = "P90 SMG"
	desc = "A submachine gun sample of the 2010s, with a scope mounted on top"
	icon = 'icons/SCP/guns/smgs/p90.dmi'
	icon_state = "p90"
	item_state = "p90"
	force = 10
	caliber = "5.7x28mm"
	slot_flags = SLOT_BELT|SLOT_BACK
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/p90_mag/rubber
	allowed_magazines = /obj/item/ammo_magazine/scp/p90_mag
	has_bolt_icon = FALSE
	ejection_side = GUN_CASING_EJECTION_DOWN
	fire_sound = 'sound/weapons/guns/p90/shoot.ogg'

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.5, 0.7)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.0, 0.5, 0.7), autofire_enabled=1),
		)

/obj/item/gun/projectile/scp/automatic/p90/generate_mag_icon_state()
	return "[ammo_magazine.gun_mag_icon]-[round(length(ammo_magazine.stored_ammo), 10)]"

/obj/item/gun/projectile/scp/automatic/mp5
	name = "MP5 SMG"
	desc = "A submachine gun sample of the 2010s"
	icon = 'icons/SCP/guns/smgs/mp5.dmi'
	icon_state = "mp5"
	item_state = "mp5"
	force = 10
	caliber = "9mm"
	fire_sound = 'sound/weapons/guns/mp5/shoot.ogg'
	slot_flags = SLOT_BELT|SLOT_BACK
	magazine_type = /obj/item/ammo_magazine/scp/mp5_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/mp5_mag
	has_bolt_icon = TRUE
	bolt_hold = TRUE

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=0, move_delay=4, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.3, 0.5)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.0, 0.3, 0.5), autofire_enabled=1),
		)

/obj/item/ammo_magazine/scp/mp5_mag
	name = "mp5 magazine (9mm)"
	icon = 'icons/SCP/guns/smgs/mp5.dmi'
	icon_state = "mp5-mag"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "9mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol/c9mm
	max_ammo = 30
	multiple_sprites = 1

/obj/item/gun/projectile/automatic/vector
	name = "Kriss Vector"
	desc = "A powerful, high stopping power SMG assigned to MTF operatives and certain SD agents."
	icon = 'icons/obj/gun.dmi'
	icon_state = "vector-45"
	item_state = "vector-45"
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = ".45"
	slot_flags = SLOT_BELT|SLOT_BACK
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/vectormag
	allowed_magazines = /obj/item/ammo_magazine/scp/vectormag
	wielded_item_state = "p90-wielded"

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=0, one_hand_penalty=3, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.5, 0.7)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.2, 0.6, 0.8), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/vector/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "vector-45"
	else
		icon_state = "vector-45-empty"
	return

//WHO THE FUCK ADDED A KNIFE HERE WTF
/obj/item/material/hatchet/tacknife
	name = "tactical knife"
	desc = "You'd be killing loads of people if this was 'Medal of Honor'."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "tacknife"
	item_state = "knife"
	attack_verb = list("stabbed", "chopped", "cut")
	applies_material_colour = 1
//	drawsound = 'sound/items/unholster_knife.ogg'
