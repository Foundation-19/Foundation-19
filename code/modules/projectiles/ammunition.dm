/obj/item/ammo_casing
	name = "bullet casing"
	desc = "A bullet casing."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "pistolcasing"
	randpixel = 10
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BELT | SLOT_EARS
	throwforce = 1
	w_class = ITEM_SIZE_TINY

	var/leaves_residue = TRUE
	var/caliber = ""					//Which kind of guns it can be loaded into
	var/projectile_type					//The bullet type to create when New() is called
	var/is_spent = FALSE
	var/spent_icon = "pistolcasing-spent"
	var/fall_sounds = list('sound/weapons/guns/casing_drop1.ogg','sound/weapons/guns/casing_drop2.ogg','sound/weapons/guns/casing_drop3.ogg','sound/weapons/guns/casing_drop4.ogg','sound/weapons/guns/casing_drop5.ogg','sound/weapons/guns/casing_drop6.ogg','sound/weapons/guns/casing_drop7.ogg',)
	var/projectile_label

/obj/item/ammo_casing/Initialize()
	if(!ispath(projectile_type))
		is_spent = TRUE

	if(randpixel)
		pixel_x = rand(-randpixel, randpixel)
		pixel_y = rand(-randpixel, randpixel)
	. = ..()

//removes the projectile from the ammo casing
/obj/item/ammo_casing/proc/expend()
	if(!ispath(projectile_type))
		return
	if(is_spent)
		return

	var/obj/item/projectile/proj = new projectile_type(src)
	is_spent = TRUE
	if(projectile_label)
		proj.SetName("[initial(proj.name)] (\"[projectile_label]\")")
	set_dir(pick(GLOB.alldirs)) //spin spent casings

	// Aurora forensics port, gunpowder residue.
	if(leaves_residue)
		leave_residue()

	update_icon()

	return proj

/obj/item/ammo_casing/proc/leave_residue()
	var/mob/living/carbon/human/H = get_holder_of_type(src, /mob/living/carbon/human)
	var/obj/item/gun/G = get_holder_of_type(src, /obj/item/gun)
	put_residue_on(G)
	if(H)
		var/zone
		if(H.l_hand == G)
			zone = BP_L_HAND
		else if(H.r_hand == G)
			zone = BP_R_HAND
		if(zone)
			var/target = H.get_covering_equipped_item_by_zone(zone)
			if(!target)
				target = H.get_organ(zone)
			put_residue_on(target)
	if(prob(30))
		put_residue_on(get_turf(src))

/obj/item/ammo_casing/proc/put_residue_on(atom/A)
	if(A)
		LAZYDISTINCTADD(A.gunshot_residue, caliber)

/obj/item/ammo_casing/attackby(obj/item/W as obj, mob/user as mob)
	if(!isScrewdriver(W))
		return ..()

	if(is_spent)
		to_chat(user, SPAN_NOTICE("There is no bullet in the casing to inscribe anything into."))
		return

	var/tmp_label = ""
	var/label_text = sanitizeSafe(input(user, "Inscribe some text into \the [initial(projectile_type["name"])]","Inscription",tmp_label), MAX_NAME_LEN)
	if(length(label_text) > 20)
		to_chat(user, SPAN_WARNING("The inscription can be at most 20 characters long."))
	else if(!label_text)
		to_chat(user, SPAN_NOTICE("You scratch the inscription off of [initial(projectile_type["name"])]."))
		projectile_label = null
	else
		to_chat(user, SPAN_NOTICE("You inscribe \"[label_text]\" into \the [initial(projectile_type["name"])]."))
		projectile_label = label_text

/obj/item/ammo_casing/on_update_icon()
	if(spent_icon && is_spent)
		icon_state = spent_icon

/obj/item/ammo_casing/examine(mob/user)
	. = ..()
	if(caliber)
		to_chat(user, "Its caliber is [caliber].")
	if(is_spent)
		to_chat(user, "This one is spent.")

// 1:1 - Gives random casing of same caliber
// Fine - Refills the casing if it's spent, otherwise gives absolutely random casing
// Very Fine - Shoots the loaded projectile at random people nearby
/obj/item/ammo_casing/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_ONE_TO_ONE)
			var/list/potential_return = list()
			for(var/thing in subtypesof(/obj/item/ammo_casing))
				var/obj/item/ammo_casing/A = thing
				if(A.caliber != caliber)
					continue
				potential_return += A
			if(!LAZYLEN(potential_return))
				return src
			var/casing_type = pick(potential_return)
			var/obj/item/ammo_casing/new_casing = new casing_type(get_turf(src))
			new_casing.is_spent = is_spent
			return new_casing
		if(MODE_FINE)
			if(ispath(projectile_type) && is_spent)
				is_spent = FALSE
				return src
			return pick(subtypesof(/obj/item/ammo_casing))
		if(MODE_VERY_FINE)
			if(!ispath(projectile_type) || is_spent)
				return src
			var/turf/my_turf = get_turf(src)
			var/list/potential_targets = list()
			for(var/mob/living/L in view(9, my_turf))
				if(L.stat == DEAD)
					continue
				potential_targets += L
			if(!LAZYLEN(potential_targets))
				for(var/turf/T in view(2, my_turf))
					if(T.density)
						continue
					potential_targets += T
			var/obj/item/projectile/P = new projectile_type(my_turf)
			var/target = pick(potential_targets)
			playsound(my_turf, P.fire_sound, 50, TRUE)
			P.firer = user
			P.launch(target, pick(BP_ALL_LIMBS))
			return null
	return ..()

//An item that holds casings and can be used to put them inside guns
/obj/item/ammo_magazine
	name = "magazine"
	desc = "A magazine for some kind of gun."
	icon_state = "357"
	icon = 'icons/obj/ammo.dmi'
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BELT
	item_state = "syringe_kit"
	matter = list(MATERIAL_STEEL = 500)
	throwforce = 5
	w_class = ITEM_SIZE_SMALL
	throw_speed = 4
	throw_range = 10

	var/list/stored_ammo = list()
	var/mag_type = SPEEDLOADER //ammo_magazines can only be used with compatible guns. This is not a bitflag, the load_method var on guns is.
	var/caliber = ".357"
	var/max_ammo = 7

	var/ammo_type = /obj/item/ammo_casing //ammo type that is initially loaded
	var/initial_ammo = null

	var/multiple_sprites = 0
	var/list/labels						//If something should be added to name on spawn aside from caliber
	//because BYOND doesn't support numbers as keys in associative lists
	var/list/icon_keys = list()		//keys
	var/list/ammo_states = list()	//values

	var/gun_mag_icon = "mag"
	var/multiple_gun_mag_icons = FALSE
/obj/item/ammo_magazine/box
	w_class = ITEM_SIZE_NORMAL

/obj/item/ammo_magazine/Initialize()
	. = ..()
	if(multiple_sprites)
		initialize_magazine_icondata(src)

	if(isnull(initial_ammo))
		initial_ammo = max_ammo

	if(initial_ammo)
		for(var/i in 1 to initial_ammo)
			stored_ammo += new ammo_type(src)
	update_icon()

/obj/item/ammo_magazine/Destroy()
	QDEL_NULL_LIST(stored_ammo)
	return ..()

/obj/item/ammo_magazine/handle_atom_del(atom/A)
	stored_ammo -= A
	update_icon()

/obj/item/ammo_magazine/afterattack(atom/target, mob/living/user, proximity_flag)
	if(!proximity_flag || (!istype(target, /turf) && !istype(target, /obj/item/ammo_casing)))
		return ..()

	var/turf/T = istype(target, /turf) ? target : get_turf(target)
	if(istype(target, /turf))
		if(!locate(/obj/item/ammo_casing) in T)
			return ..()

	var/curr_ammo = length(stored_ammo)
	if(curr_ammo >= max_ammo)
		to_chat(user, "<span class='warning'>[src] is full!</span>")
		return

	to_chat(user, SPAN_NOTICE("You begin inserting casings into \the [src]..."))
	if(!do_after(user, (max_ammo - curr_ammo) * 2, src))
		return

	for(var/obj/item/ammo_casing/C in T)
		if(stored_ammo.len >= max_ammo)
			break
		if(C.caliber != caliber)
			continue
		stored_ammo.Add(C)
		C.forceMove(src)

	if(length(stored_ammo) - curr_ammo)
		to_chat(user, SPAN_NOTICE("You insert [length(stored_ammo) - curr_ammo] casings into \the [src]."))
		update_icon()
	else
		to_chat(user, SPAN_WARNING("You fail to collect any casings!"))

/obj/item/ammo_magazine/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/C = W
		if(C.caliber != caliber)
			to_chat(user, SPAN_WARNING("[C] does not fit into [src]."))
			return
		if(stored_ammo.len >= max_ammo)
			to_chat(user, SPAN_WARNING("[src] is full!"))
			return
		if(!user.unEquip(C, src))
			return
		stored_ammo.Add(C)
		playsound(user, "sfx_bullet_insert", rand(45, 60), FALSE)
		update_icon()
	else ..()

	if(istype(W, /obj/item/ammo_magazine/box))
		var/obj/item/ammo_magazine/box/L = W
		if(L.caliber != caliber)
			user << SPAN_WARNING("The ammo in [L] does not fit into [src].")
			return
		if(!L.stored_ammo.len)
			user << SPAN_WARNING("There's no more ammo [L]!")
			return
		if(stored_ammo.len >= max_ammo)
			user << SPAN_WARNING("[src] is full!")
			return
		var/obj/item/ammo_casing/AC = L.stored_ammo[1] //select the next casing.
		L.stored_ammo -= AC //Remove this casing from loaded list of the clip.
		AC.loc = src
		stored_ammo.Insert(1, AC) //add it to the head of our magazine's list
		L.update_icon()
		update_icon()
		playsound(src.loc, 'sound/weapons/bulletin_mag.wav', 80, 1)
	update_icon()

/obj/item/ammo_magazine/attack_self(mob/user)
	if(!stored_ammo.len)
		to_chat(user, SPAN_NOTICE("[src] is already empty!"))
		return
	if(!do_after(user, 10, src))
		return
	to_chat(user, SPAN_NOTICE("You empty [src]."))
	var/curr_sounds = 0
	var/max_sounds = clamp(round(length(stored_ammo) * 0.2), 1, 10)
	for(var/obj/item/ammo_casing/C in stored_ammo)
		C.forceMove(user.loc)
		C.set_dir(pick(GLOB.alldirs))
		if(LAZYLEN(C.fall_sounds) && curr_sounds < max_sounds)
			playsound(user.loc, pick(C.fall_sounds), 20, TRUE)
			curr_sounds += 1
	stored_ammo.Cut()
	update_icon()

/obj/item/ammo_magazine/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		if(!stored_ammo.len)
			to_chat(user, SPAN_NOTICE("[src] is already empty!"))
		else
			var/obj/item/ammo_casing/C = stored_ammo[stored_ammo.len]
			stored_ammo-=C
			user.put_in_hands(C)
			user.visible_message("\The [user] removes \a [C] from [src].", SPAN_NOTICE("You remove \a [C] from [src]."))
			update_icon()
	else
		..()
		return

/obj/item/ammo_magazine/on_update_icon()
	if(multiple_sprites)
		//find the lowest key greater than or equal to stored_ammo.len
		var/new_state = null
		for(var/idx in 1 to icon_keys.len)
			var/ammo_count = icon_keys[idx]
			if (ammo_count >= stored_ammo.len)
				new_state = ammo_states[idx]
				break
		icon_state = (new_state)? new_state : initial(icon_state)

/obj/item/ammo_magazine/examine(mob/user)
	. = ..()
	to_chat(user, "There [(stored_ammo.len == 1)? "is" : "are"] [stored_ammo.len] round\s left!")

//magazine icon state caching
/var/global/list/magazine_icondata_keys = list()
/var/global/list/magazine_icondata_states = list()

/proc/initialize_magazine_icondata(obj/item/ammo_magazine/M)
	var/typestr = "[M.type]"
	if(!(typestr in magazine_icondata_keys) || !(typestr in magazine_icondata_states))
		magazine_icondata_cache_add(M)

	M.icon_keys = magazine_icondata_keys[typestr]
	M.ammo_states = magazine_icondata_states[typestr]

/proc/magazine_icondata_cache_add(obj/item/ammo_magazine/M)
	var/list/icon_keys = list()
	var/list/ammo_states = list()
	var/list/states = icon_states(M.icon)
	for(var/i = 0, i <= M.max_ammo, i++)
		var/ammo_state = "[M.icon_state]-[i]"
		if(ammo_state in states)
			icon_keys += i
			ammo_states += ammo_state

	magazine_icondata_keys["[M.type]"] = icon_keys
	magazine_icondata_states["[M.type]"] = ammo_states
