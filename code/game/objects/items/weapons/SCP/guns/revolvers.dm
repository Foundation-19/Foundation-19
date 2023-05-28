/obj/item/gun/projectile/scp/revolver
	abstract_type = /obj/item/gun/projectile/scp/revolver
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	fire_delay = 4 //Revolvers are naturally slower-firing
	mag_insert_sound = 'sound/weapons/guns/interaction/rev_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/rev_magout.ogg'
	bulk = 3
	accuracy = 2
	accuracy_power = 8
	handle_casings = CYCLE_CASINGS
	load_method = SINGLE_CASING|SPEEDLOADER
	action_type = GUN_DOUBLE_ACTION
	bolt_back_sound = 'sound/weapons/guns/revolvers/revolver_open1.ogg'
	bolt_forward_sound = 'sound/weapons/guns/revolvers/revolver_close1.ogg'
	trigger_click_sound = 'sound/weapons/guns/revolvers/revolver_click.ogg'
	has_bolt_icon = TRUE
	manual_action = TRUE //We cycle action before firing
	ejection_side = GUN_CASING_EJECTION_DOWN


/obj/item/gun/projectile/scp/revolver/Initialize()
	. = ..()
	loaded.len = max_shells

/obj/item/gun/projectile/scp/revolver/consume_next_projectile()
	rotate_cylinder()
	chambered = loaded[max_shells]
	if(chambered)
		return chambered.expend()

/obj/item/gun/projectile/scp/revolver/do_fire()
	..()
	chambered = null

/// We're treating cylinder in revolver as bolt, since it also opens and closes... Hacks!
/obj/item/gun/projectile/scp/revolver/attack_self(mob/user)
	if(world.time < last_bolt_cycle + 1 SECOND)
		return
	last_bolt_cycle = world.time
	if(!is_bolt_open)
		bolt_back(manual = TRUE)
	else
		bolt_forward(manual = TRUE)
	if(has_bolt_icon)
		update_icon()

/obj/item/gun/projectile/scp/revolver/bolt_back(manual)
	is_bolt_open = TRUE
	if(manual && bolt_back_sound)
		playsound(src, bolt_back_sound, 70)


/obj/item/gun/projectile/scp/revolver/bolt_forward(manual)
	if(manual && bolt_forward_sound)
		playsound(src, bolt_forward_sound, 70)
	is_bolt_open = FALSE

/obj/item/gun/projectile/scp/revolver/proc/rotate_cylinder()
	var/b = loaded[1]
	loaded.Cut(1,2)
	loaded.Insert(0, b)

/obj/item/gun/projectile/scp/revolver/proc/spin_cylinder()
	for(var/i in 1 to rand(0, max_shells*2))
		rotate_cylinder()

/obj/item/gun/projectile/scp/revolver/AltClick(mob/user)
	rotate_cylinder()
	to_chat(user, SPAN_NOTICE("You rotate the cylinder counter-clocwise."))
	playsound(src, 'sound/weapons/guns/revolvers/cylinder_click.ogg', 75)
	return TRUE

/obj/item/gun/projectile/scp/revolver/MiddleClick(mob/user)
	rotate_cylinder()
	to_chat(user, SPAN_NOTICE("You rotate the cylinder counter-clocwise."))
	playsound(src, 'sound/weapons/guns/revolvers/cylinder_click.ogg', 75)
	return TRUE

/obj/item/gun/projectile/scp/revolver/handle_casing_insertion(obj/item/ammo_casing/C, mob/user)
	if(caliber != C.caliber)
		return
	if(!(load_method & SINGLE_CASING))
		return
	if(!is_bolt_open)
		return
	for(var/i in 1 to loaded.len)
		var/obj/item/ammo_casing/bullet = loaded[i]
		if(bullet)
			continue
		if(!user.unEquip(C, src))
			return
		loaded[i] = C
		user.visible_message("[user] inserts \a [C] into [src].", SPAN_NOTICE("You insert \a [C] into [src]."))
		playsound(loc, load_sound, 50, 1)
		return

/obj/item/gun/projectile/scp/revolver/handle_speedloader_reload(obj/item/ammo_magazine/AM, mob/user)
	var/count = 0
	for(var/i in 1 to loaded.len)
		var/obj/item/ammo_casing/C = loaded[i]
		if(C)
			continue
		C = AM.stored_ammo[1]
		if(C.caliber != caliber)
			to_chat(user, SPAN_WARNING("Calibers don't match!"))
			return
		loaded[i] = C
		C.forceMove(src)
		AM.stored_ammo -= C
		count++
	if(count)
		user.visible_message("[user] reloads [src].", SPAN_NOTICE("You load [count] round\s into [src]."))
		playsound(src.loc, mag_insert_sound, 50, 1)
		AM.update_icon()
		return
	to_chat(user, SPAN_WARNING("[src] is full!"))

/obj/item/gun/projectile/scp/revolver/unload_ammo(mob/user, allow_dump)
	if(!is_bolt_open)
		return
	if(allow_dump && (load_method & SPEEDLOADER))
		var/count = 0
		for(var/i in 1 to loaded.len)
			var/obj/item/ammo_casing/C = loaded[i]
			if(!C)
				continue
			ejectCasing(FALSE, C)
			loaded[i] = null
			count++
		if(count)
			user.visible_message("[user] unloads [src].", SPAN_NOTICE("You unload [count] round\s from [src]."))
			return
	for(var/i in 1 to loaded.len)
		var/obj/item/ammo_casing/C = loaded[i]
		if(!C)
			continue
		user.put_in_hands(C)
		loaded[i] = null
		user.visible_message("[user] removes \a [C] from [src].", SPAN_NOTICE("You remove \a [C] from [src]."))
		playsound(loc, load_sound, 50, 1)
		return
	to_chat(user, SPAN_WARNING("[src] is empty."))

/obj/item/gun/projectile/scp/revolver/handle_mousedrop_unload(obj/over_object)
	var/mob/living/carbon/human/user = usr
	if (!over_object || !(ishuman(user)))
		return
	if (loc != user)
		return
	if(user.incapacitated())
		return

	switch(over_object.name)
		if("r_hand", "l_hand")
			unload_ammo(user, allow_dump = TRUE)
		else
			return

	update_icon()
	return 1

/obj/item/gun/projectile/scp/revolver/proc/get_live_count()
	var/counter = 0
	for(var/i in 1 to loaded.len)
		var/obj/item/ammo_casing/C = loaded[i]
		if(C && !C.is_spent)
			counter++
	return counter

/obj/item/gun/projectile/scp/revolver/get_ammo_count()
	var/counter = 0
	for(var/i in 1 to loaded.len)
		var/obj/item/ammo_casing/C = loaded[i]
		if(C)
			counter++
	return counter

/obj/item/gun/projectile/scp/revolver/get_ammo_count_text()
	return "It has [get_ammo_count()] round\s remaining, of which [get_live_count()] are live."

/obj/item/gun/projectile/scp/revolver/verb/spin_cylinder_verb()
	set name = "Spin cylinder"
	set desc = "Fun when you're bored out of your skull."
	set category = "Object"

	visible_message(SPAN_WARNING("\The [usr] spins the cylinder of \the [src]!"), \
	SPAN_NOTICE("You hear something metallic spin and click."))
	playsound(src.loc, 'sound/weapons/revolver_spin.ogg', 100, 1)
	show_sound_effect(src.loc, src)
	spin_cylinder()

/obj/item/gun/projectile/scp/revolver/mk27
	name = "\improper MK27 Revolver"
	desc = "The SCPF Mk7 Revolver, reminiscent of the S&W Model 27. This weapon, patented and produced by the SCP Foundation is popular among high-ranking security officers. Uses .357 ammo."
	icon = 'icons/SCP/guns/pistols/sw27.dmi'
	icon_state = "s&w27"
	item_state = "revolver"
	caliber = ".357"
	max_shells = 6
	ammo_type = /obj/item/ammo_casing/pistol/a357
	fire_sound = 'sound/weapons/guns/revolvers/fire_revolver1.ogg'
