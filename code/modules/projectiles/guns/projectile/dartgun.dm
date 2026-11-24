/obj/item/projectile/bullet/chemdart
	name = "dart"
	icon_state = "dart"
	damage = 5
	sharp = TRUE
	var/reagent_amount = 15
	life_span = 15 //shorter range
	acid_resistance = -1

	muzzle_type = null

/obj/item/projectile/bullet/chemdart/New()
	create_reagents(reagent_amount)
	..()

/obj/item/projectile/bullet/chemdart/on_hit(atom/target, blocked = 0, def_zone = null)
	if(blocked < 100 && isliving(target))
		var/mob/living/L = target
		if(L.can_inject(null, def_zone) == CAN_INJECT)
			reagents.trans_to_mob(L, reagent_amount, CHEM_BLOOD)

/obj/item/ammo_casing/chemdart
	name = "chemical dart"
	desc = "A small hardened, hollow dart."
	icon_state = "dart"
	caliber = CALIBER_DART
	projectile_type = /obj/item/projectile/bullet/chemdart
	leaves_residue = FALSE

/obj/item/ammo_casing/chemdart/expend()
	. = ..()
	qdel(src)

/obj/item/ammo_magazine/chemdart
	name = "dart cartridge"
	desc = "A rack of hollow darts."
	icon_state = "darts"
	item_state = "rcdammo"
	origin_tech = list(TECH_MATERIAL = 2)
	mag_type = MAGAZINE
	caliber = CALIBER_DART
	ammo_type = /obj/item/ammo_casing/chemdart
	max_ammo = 5
	multiple_sprites = 1

/obj/item/gun/projectile/dartgun
	name = "dart gun"
	desc = "Zeng-Hu Pharmaceutical's entry into the arms market, the Z-H P Artemis is a gas-powered dart gun capable of delivering chemical cocktails swiftly across short distances."
	icon = 'icons/obj/guns/dartgun.dmi'
	icon_state = "dartgun-empty"
	item_state = null

	caliber = CALIBER_DART
	fire_sound = 'sounds/weapons/empty.ogg'
	fire_sound_text = "a metallic click"
	screen_shake = 0
	silenced = TRUE
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/chemdart
	allowed_magazines = /obj/item/ammo_magazine/chemdart
	auto_eject = 0
	handle_casings = CLEAR_CASINGS //delete casings instead of dropping them

	var/list/beakers = list() //All containers inside the gun.
	var/list/mixing = list() //Containers being used for mixing.
	var/max_beakers = 3
	var/dart_reagent_amount = 15
	var/container_type = /obj/item/reagent_containers/glass/beaker
	var/list/starting_chems = null

/obj/item/gun/projectile/dartgun/Initialize()
	if(starting_chems)
		for(var/chem in starting_chems)
			var/obj/B = new container_type(src)
			B.reagents.add_reagent(chem, 60)
			beakers += B
	. = ..()
	update_icon()

/obj/item/gun/projectile/dartgun/on_update_icon()
	if(!ammo_magazine)
		icon_state = "dartgun-empty"
		return 1

	if(!ammo_magazine.stored_ammo || ammo_magazine.stored_ammo.len)
		icon_state = "dartgun-0"
	else if(ammo_magazine.stored_ammo.len > 5)
		icon_state = "dartgun-5"
	else
		icon_state = "dartgun-[ammo_magazine.stored_ammo.len]"
	return 1

/obj/item/gun/projectile/dartgun/consume_next_projectile()
	. = ..()
	var/obj/item/projectile/bullet/chemdart/dart = .
	if(istype(dart))
		fill_dart(dart)

/obj/item/gun/projectile/dartgun/examine(mob/user)
	. = ..()
	if (beakers.len)
		to_chat(user, SPAN_NOTICE("\The [src] contains:"))
		for(var/obj/item/reagent_containers/glass/beaker/B in beakers)
			if(B.reagents && B.reagents.reagent_list.len)
				for(var/datum/reagent/R in B.reagents.reagent_list)
					to_chat(user, SPAN_NOTICE("[R.volume] units of [R.name]"))

/obj/item/gun/projectile/dartgun/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/reagent_containers/glass))
		add_beaker(I, user)
		return 1
	..()

/obj/item/gun/projectile/dartgun/proc/add_beaker(obj/item/reagent_containers/glass/B, mob/user)
	if(!istype(B, container_type))
		to_chat(user, SPAN_WARNING("[B] doesn't seem to fit into [src]."))
		return
	if(beakers.len >= max_beakers)
		to_chat(user, SPAN_WARNING("[src] already has [max_beakers] beakers in it - another one isn't going to fit!"))
		return
	if(!user.unEquip(B, src))
		return
	beakers |= B
	user.visible_message("\The [user] inserts \a [B] into [src].", SPAN_NOTICE("You slot [B] into [src]."))

/obj/item/gun/projectile/dartgun/proc/remove_beaker(obj/item/reagent_containers/glass/B, mob/user)
	mixing -= B
	beakers -= B
	user.put_in_hands(B)
	user.visible_message("\The [user] removes \a [B] from [src].", SPAN_NOTICE("You remove [B] from [src]."))

//fills the given dart with reagents
/obj/item/gun/projectile/dartgun/proc/fill_dart(obj/item/projectile/bullet/chemdart/dart)
	if(mixing.len)
		var/mix_amount = dart.reagent_amount/mixing.len
		for(var/obj/item/reagent_containers/glass/beaker/B in mixing)
			B.reagents.trans_to_obj(dart, mix_amount)

/obj/item/gun/projectile/dartgun/attack_self(mob/user)
	tgui_interact(user)

/obj/item/gun/projectile/dartgun/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "DartGun", "[src] mixing control")
		ui.open()

/obj/item/gun/projectile/dartgun/tgui_data(mob/user)
	var/list/data = list()
	var/list/beaker_list = list()
	for(var/i in 1 to beakers.len)
		var/obj/item/reagent_containers/glass/beaker/B = beakers[i]
		if(!istype(B))
			continue
		var/list/entry = list(
			"index" = i,
			"name" = B.name,
			"mixing" = (B in mixing),
			"reagents" = list()
		)
		if(B.reagents && B.reagents.reagent_list.len)
			var/list/reagent_list = list()
			for(var/datum/reagent/R in B.reagents.reagent_list)
				reagent_list += list(list("name" = R.name, "volume" = R.volume))
			entry["reagents"] = reagent_list
		beaker_list += list(entry)
	data["beakers"] = beaker_list
	data["has_magazine"] = ammo_magazine ? TRUE : FALSE
	if(ammo_magazine)
		data["magazine_rounds"] = ammo_magazine.stored_ammo ? ammo_magazine.stored_ammo.len : 0
	return data

/obj/item/gun/projectile/dartgun/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("stop_mix")
			var/index = text2num(params["index"])
			mixing -= beakers[index]
			return TRUE
		if("mix")
			var/index = text2num(params["index"])
			mixing |= beakers[index]
			return TRUE
		if("eject")
			var/index = text2num(params["index"])
			if(beakers[index])
				remove_beaker(beakers[index], usr)
			return TRUE
		if("eject_cart")
			unload_ammo(usr)
			return TRUE
	return FALSE

/obj/item/gun/projectile/dartgun/vox
	name = "alien dart gun"
	desc = "A small gas-powered dartgun, fitted for nonhuman hands."

/obj/item/gun/projectile/dartgun/vox/medical
	starting_chems = list(/datum/reagent/medicine/kelotane,/datum/reagent/medicine/bicaridine,/datum/reagent/medicine/dylovene)

/obj/item/gun/projectile/dartgun/vox/raider
	starting_chems = list(/datum/reagent/space_drugs,/datum/reagent/soporific,/datum/reagent/impedrezene)
