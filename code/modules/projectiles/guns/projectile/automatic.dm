/obj/item/gun/projectile/automatic
	name = "prototype SMG"
	desc = "A protoype lightweight, fast firing submachine gun."
	icon = 'icons/obj/guns/prototype_smg.dmi'
	icon_state = "prototype"
	item_state = "saber"
	w_class = ITEM_SIZE_NORMAL
	bulk = -1
	load_method = MAGAZINE
	caliber = CALIBER_PISTOL_FLECHETTE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 3)
	slot_flags = SLOT_BELT
	ammo_type = /obj/item/ammo_casing/flechette
	magazine_type = /obj/item/ammo_magazine/proto_smg
	allowed_magazines = /obj/item/ammo_magazine/proto_smg
	multi_aim = 1
	burst_delay = 2
	mag_insert_sound = 'sounds/weapons/guns/interaction/smg_magin.ogg'
	mag_remove_sound = 'sounds/weapons/guns/interaction/smg_magout.ogg'

	//machine pistol, easier to one-hand with
	firemodes = list(
		list(mode_name="3-round bursts", burst=3, fire_delay=null, one_hand_penalty=4, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 1.6, 2.4, 2.4)),
		list(mode_name="short bursts",   burst=5, fire_delay=null, one_hand_penalty=5, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(1.6, 1.6, 2.0, 2.0, 2.4)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=5, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(1.0, 1.0, 1.2, 1.4, 1.6), autofire_enabled=1)
	)

/obj/item/gun/projectile/automatic/machine_pistol
	name = "machine pistol"
	desc = "The Hephaestus Industries MP6 Vesper, A fairly common machine pistol. Sometimes refered to as an 'uzi' by the backwater spacers it is often associated with."
	icon = 'icons/obj/guns/machine_pistol.dmi'
	icon_state = "mpistolen"
	safety_icon = "safety"
	item_state = "mpistolen"
	caliber = CALIBER_PISTOL
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2, TECH_ESOTERIC = 3)
	ammo_type = /obj/item/ammo_casing/pistol
	magazine_type = /obj/item/ammo_magazine/machine_pistol
	allowed_magazines = /obj/item/ammo_magazine/machine_pistol //more damage compared to the wt550, smaller mag size
	one_hand_penalty = 2

	firemodes = list(
		list(mode_name="semi auto",      burst=1, fire_delay=null, one_hand_penalty=0, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, one_hand_penalty=1, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="short bursts",   burst=5, fire_delay=null, one_hand_penalty=2, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(0.6, 0.6, 1.0, 1.0, 1.2)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.4, 0.8, 1.2), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/machine_pistol/on_update_icon()
	..()
	icon_state = "mpistolen"
	if(ammo_magazine)
		add_overlay(image(icon, "mag"))

	if(!ammo_magazine || !LAZYLEN(ammo_magazine.stored_ammo))
		icon_state = "mpistolen-empty"
		add_overlay(image(icon, "ammo_bad"))
	else if(LAZYLEN(ammo_magazine.stored_ammo) <= 0.5 * ammo_magazine.max_ammo)
		add_overlay(image(icon, "ammo_warn"))
		return
	else
		add_overlay(image(icon, "ammo_ok"))

/obj/item/gun/projectile/automatic/merc_smg
	name = "submachine gun"
	desc = "The NanoTrasen C-20r is a lightweight and rapid firing SMG, for when you REALLY need someone dead. Has a 'Per falcis, per pravitas' buttstamp."
	icon = 'icons/obj/guns/merc_smg.dmi'
	icon_state = "c20r"
	item_state = "c20r"
	safety_icon = "safety"
	w_class = ITEM_SIZE_LARGE
	force = 10
	caliber = CALIBER_PISTOL
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2, TECH_ESOTERIC = 8)
	slot_flags = SLOT_BELT|SLOT_BACK
	magazine_type = /obj/item/ammo_magazine/smg
	allowed_magazines = /obj/item/ammo_magazine/smg
	auto_eject = 1
	auto_eject_sound = 'sounds/weapons/smg_empty_alarm.ogg'
	bulk = -1
	accuracy = 1
	one_hand_penalty = 4

	//SMG
	firemodes = list(
		list(mode_name="semi auto",       burst=1, fire_delay=null, one_hand_penalty=4, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null,  one_hand_penalty=5, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="short bursts",   burst=5, fire_delay=null,  one_hand_penalty=6, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(0.6, 0.6, 1.0, 1.0, 1.2)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=7, burst_accuracy=list(0,-1,-2), dispersion=list(0.4, 0.8, 1.2), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/merc_smg/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "c20r-[round(ammo_magazine.stored_ammo.len,4)]"
	else
		icon_state = "c20r"

/obj/item/gun/projectile/automatic/assault_rifle
	name = "assault rifle"
	desc = "The rugged STS-35 is a durable automatic weapon of a make popular on the frontier worlds. Originally produced by Hephaestus. The serial number has been scratched off."
	icon = 'icons/obj/guns/assault_rifle.dmi'
	icon_state = "arifle"
	item_state = null
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = CALIBER_RIFLE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/rifle
	allowed_magazines = /obj/item/ammo_magazine/rifle
	one_hand_penalty = 8
	accuracy_power = 7
	accuracy = 2
	bulk = GUN_BULK_RIFLE + 1
	wielded_item_state = "arifle-wielded"
	mag_insert_sound = 'sounds/weapons/guns/interaction/ltrifle_magin.ogg'
	mag_remove_sound = 'sounds/weapons/guns/interaction/ltrifle_magout.ogg'

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	firemodes = list(
		list(mode_name="semi auto",      burst=1,    fire_delay=null, one_hand_penalty=8,  burst_accuracy=null,                dispersion=null),
		list(mode_name="3-round bursts", burst=3,    fire_delay=null, one_hand_penalty=9,  burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="short bursts",   burst=5,    fire_delay=null, one_hand_penalty=11, burst_accuracy=list(0,-1,-1,-2),    dispersion=list(0.2, 0.6, 1.0, 1.2)),
		list(mode_name="full auto",      burst=1,    fire_delay=0,    burst_delay=1,     one_hand_penalty=7,  burst_accuracy=list(0,-1,-1),       dispersion=list(0.2, 0.6, 1.0), autofire_enabled=1)
		)

/obj/item/gun/projectile/automatic/assault_rifle/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "arifle"
		wielded_item_state = "arifle-wielded"
	else
		icon_state = "arifle-empty"
		wielded_item_state = "arifle-wielded-empty"

/obj/item/gun/projectile/automatic/sec_smg
	name = "submachine gun"
	desc = "The WT-550 Saber is a cheap self-defense weapon, mass-produced by Ward-Takahashi for paramilitary and private use."
	icon = 'icons/obj/guns/sec_smg.dmi'
	icon_state = "smg"
	item_state = "wt550"
	safety_icon = "safety"
	w_class = ITEM_SIZE_NORMAL
	caliber = CALIBER_PISTOL_SMALL
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2)
	slot_flags = SLOT_BELT
	ammo_type = /obj/item/ammo_casing/pistol/small
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/smg_top/rubber
	allowed_magazines = /obj/item/ammo_magazine/smg_top
	accuracy_power = 7
	one_hand_penalty = 3

	//machine pistol, like SMG but easier to one-hand with
	firemodes = list(
		list(mode_name="semi auto",      burst=1, fire_delay=null, one_hand_penalty=3, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, one_hand_penalty=4, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="short bursts",   burst=5, fire_delay=null, one_hand_penalty=5, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(0.6, 0.6, 1.0, 1.0, 1.2)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=6, burst_accuracy=list(0,-1,-2), dispersion=list(0.4, 0.8, 1.2), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/sec_smg/on_update_icon()
	..()
	if(ammo_magazine)
		add_overlay(image(icon, "mag-[round(ammo_magazine.stored_ammo.len,5)]"))
	if(ammo_magazine && LAZYLEN(ammo_magazine.stored_ammo))
		add_overlay(image(icon, "ammo-ok"))
	else
		add_overlay(image(icon, "ammo-bad"))

/obj/item/gun/projectile/automatic/bullpup_rifle
	name = "bullpup assault rifle"
	desc = "The Hephaestus Industries Z8 Bulldog is an older model bullpup carbine. Makes you feel like a space marine when you hold it."
	icon = 'icons/obj/guns/bullpup_rifle.dmi'
	icon_state = "carbine"
	item_state = "z8carbine"
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = CALIBER_RIFLE_MILITARY
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 3)
	ammo_type = /obj/item/ammo_casing/rifle/military
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/mil_rifle
	allowed_magazines = /obj/item/ammo_magazine/mil_rifle
	auto_eject = 1
	auto_eject_sound = 'sounds/weapons/smg_empty_alarm.ogg'
	accuracy = 2
	accuracy_power = 7
	one_hand_penalty = 8
	bulk = GUN_BULK_RIFLE
	burst_delay = 2
	wielded_item_state = "z8carbine-wielded"
	mag_insert_sound = 'sounds/weapons/guns/interaction/batrifle_magin.ogg'
	mag_remove_sound = 'sounds/weapons/guns/interaction/batrifle_magout.ogg'
	firemodes = list(
		list(mode_name="semi auto",      burst=1,    fire_delay=null, use_launcher=null, one_hand_penalty=8,  burst_accuracy=null,            dispersion=null),
		list(mode_name="3-round bursts", burst=3,    fire_delay=null, use_launcher=null, one_hand_penalty=9,  burst_accuracy=list(0,-1,-1),   dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="fire grenades",  burst=null, fire_delay=null, use_launcher=1,    one_hand_penalty=10, burst_accuracy=null,            dispersion=null),
		list(mode_name="full auto",      burst=1,    fire_delay=0,    burst_delay=1.5,     use_launcher=null,   one_hand_penalty=10,            burst_accuracy = list(0,-1,-1), dispersion=list(0.2, 0.6, 1.2), autofire_enabled=1),
	)

	var/use_launcher = 0
	var/obj/item/gun/launcher/grenade/underslung/launcher

/obj/item/gun/projectile/automatic/bullpup_rifle/Initialize()
	. = ..()
	launcher = new(src)

/obj/item/gun/projectile/automatic/bullpup_rifle/attackby(obj/item/I, mob/user)
	if((istype(I, /obj/item/grenade)))
		launcher.load(I, user)
	else
		..()

/obj/item/gun/projectile/automatic/bullpup_rifle/attack_hand(mob/user)
	if(user.get_inactive_hand() == src && use_launcher)
		launcher.unload(user)
	else
		..()

/obj/item/gun/projectile/automatic/bullpup_rifle/Fire(atom/target, mob/living/user, params, pointblank=0, reflex=0)
	if(use_launcher)
		launcher.Fire(target, user, params, pointblank, reflex)
		if(!launcher.chambered)
			switch_firemodes() //switch back automatically
	else
		..()

/obj/item/gun/projectile/automatic/bullpup_rifle/on_update_icon()
	..()
	if(ammo_magazine)
		if(ammo_magazine.stored_ammo.len)
			icon_state = "carbine-loaded"
		else
			icon_state = "carbine-empty"
	else
		icon_state = "carbine"

/obj/item/gun/projectile/automatic/bullpup_rifle/examine(mob/user)
	. = ..()
	if(launcher.chambered)
		to_chat(user, "\The [launcher] has \a [launcher.chambered] loaded.")
	else
		to_chat(user, "\The [launcher] is empty.")

/obj/item/gun/projectile/automatic/l6_saw
	name = "light machine gun"
	desc = "A rather traditionally made L6 SAW with a pleasantly lacquered wooden pistol grip. Has 'Aussec Armoury- 2281' engraved on the reciever." //probably should refluff this
	icon = 'icons/obj/guns/saw.dmi'
	icon_state = "l6closed50"
	item_state = "l6closedmag"
	w_class = ITEM_SIZE_HUGE
	bulk = 10
	force = 10
	slot_flags = 0
	max_shells = 50
	caliber = CALIBER_RIFLE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 2)
	slot_flags = 0 //need sprites for SLOT_BACK
	ammo_type = /obj/item/ammo_casing/rifle
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/box/machinegun
	allowed_magazines = list(/obj/item/ammo_magazine/box/machinegun, /obj/item/ammo_magazine/rifle)
	one_hand_penalty = 10
	burst_delay = 1.5
	wielded_item_state = "gun_wielded"
	mag_insert_sound = 'sounds/weapons/guns/interaction/lmg_magin.ogg'
	mag_remove_sound = 'sounds/weapons/guns/interaction/lmg_magout.ogg'
	can_special_reload = FALSE

	//LMG, better sustained fire accuracy than assault rifles (comparable to SMG), higer move delay and one-handing penalty
	//No single-shot or 3-round-burst modes since using this weapon should come at a cost to flexibility.
	firemodes = list(
		list(mode_name="short bursts", burst=5, fire_delay=5, one_hand_penalty=8,  burst_accuracy = list(0,-1,-1,-2,-2),          dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(mode_name="long bursts",  burst=8, fire_delay=5, one_hand_penalty=12, burst_accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2)),
		list(mode_name="full auto",    burst=1, burst_delay=0.6, fire_delay=0, one_hand_penalty=16, burst_accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2), autofire_enabled=1),
		)

	var/cover_open = 0

/obj/item/gun/projectile/automatic/l6_saw/mag
	magazine_type = /obj/item/ammo_magazine/box/machinegun

/obj/item/gun/projectile/automatic/l6_saw/special_check(mob/user)
	if(cover_open)
		to_chat(user, SPAN_WARNING("[src]'s cover is open! Close it before firing!"))
		return 0
	return ..()

/obj/item/gun/projectile/automatic/l6_saw/proc/toggle_cover(mob/user)
	cover_open = !cover_open
	to_chat(user, SPAN_NOTICE("You [cover_open ? "open" : "close"] [src]'s cover."))
	update_icon()

/obj/item/gun/projectile/automatic/l6_saw/attack_self(mob/user as mob)
	if(cover_open)
		toggle_cover(user) //close the cover
	else
		return ..() //once closed, behave like normal

/obj/item/gun/projectile/automatic/l6_saw/attack_hand(mob/user as mob)
	if(!cover_open && user.get_inactive_hand() == src)
		toggle_cover(user) //open the cover
	else
		return ..() //once open, behave like normal

/obj/item/gun/projectile/automatic/l6_saw/on_update_icon()
	..()
	if(istype(ammo_magazine, /obj/item/ammo_magazine/box))
		icon_state = "l6[cover_open ? "open" : "closed"][round(ammo_magazine.stored_ammo.len, 20)]"
		item_state = "l6[cover_open ? "open" : "closed"]"
	else if(ammo_magazine)
		icon_state = "l6[cover_open ? "open" : "closed"]mag"
		item_state = "l6[cover_open ? "open" : "closed"]mag"
	else
		icon_state = "l6[cover_open ? "open" : "closed"]-empty"
		item_state = "l6[cover_open ? "open" : "closed"]-empty"

/obj/item/gun/projectile/automatic/l6_saw/load_ammo(obj/item/A, mob/user)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("You need to open the cover to load that into [src]."))
		return
	..()

/obj/item/gun/projectile/automatic/l6_saw/unload_ammo(mob/user, allow_dump=1)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("You need to open the cover to unload [src]."))
		return
	..()

/obj/item/gun/projectile/automatic/battlerifle
	name = "battle rifle"
	desc = "The battle rifle hasn't changed much since its inception in the mid 20th century. Built to last in the toughest conditions, you can't tell if this one was even made this century."
	icon = 'icons/obj/guns/battlerifle.dmi'
	icon_state = "battlerifle"
	item_state = null
	w_class = ITEM_SIZE_HUGE
	force = 12
	caliber = CALIBER_RIFLE_MILITARY
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/mil_rifle
	allowed_magazines = /obj/item/ammo_magazine/mil_rifle
	one_hand_penalty = 10
	accuracy_power = 9
	accuracy = 4
	bulk = GUN_BULK_RIFLE + 1
	wielded_item_state = "battlerifle-wielded"
	mag_insert_sound = 'sounds/weapons/guns/interaction/ltrifle_magin.ogg'
	mag_remove_sound = 'sounds/weapons/guns/interaction/ltrifle_magout.ogg'

	//Battle Rifle is only accurate in semi-automatic fire.
	firemodes = list(
		list(mode_name="semi auto", burst=1, fire_delay=null, one_hand_penalty=8, burst_accuracy=null, dispersion=null),
		list(mode_name="full auto", burst=1, fire_delay=0, burst_delay=2, one_hand_penalty=12, burst_accuracy = list(0,-1,-2), dispersion = list(0.0, 0.6, 1.0, 1.2, 1.4), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/battlerifle/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "battlerifle"
		wielded_item_state = "battlerifle-wielded"
	else
		icon_state = "battlerifle-empty"
		wielded_item_state = "battlerifle-wielded-empty"

/obj/item/gun/projectile/automatic/semistrip
	name = "Carbine Rifle"
	desc = "An old semi-automatic carbine chambered in large pistol rounds, this thing looks older than the SCG."
	icon = 'icons/obj/guns/semistrip.dmi'
	icon_state = "semistrip"
	item_state = "semistrip"
	w_class = ITEM_SIZE_LARGE
	force = 10
	origin_tech = list(TECH_COMBAT = 2)
	slot_flags = SLOT_BACK
	caliber = CALIBER_PISTOL_MAGNUM
	ammo_type = /obj/item/ammo_casing/pistol/magnum
	load_method = SINGLE_CASING|SPEEDLOADER
	max_shells = 10
	accuracy = 5
	scope_zoom = 2
	scoped_accuracy = 20
	wielded_item_state = "semistrip-wielded"

	firemodes = list(
		list(mode_name="semi auto", burst=1, fire_delay=null, one_hand_penalty=8, burst_accuracy=null, dispersion=null),
		list(mode_name="full auto", burst=1, fire_delay=0, burst_delay=2, one_hand_penalty=12, burst_accuracy=list(0,-1,-2), dispersion=list(0.2, 0.6, 1.0), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/g36
	name = "G36 rifle"
	desc = "An assault rifle used by the Global Occult Coalition, rarely seen loaned to high-intensity MTF units. Highly lethal and capable of holding up to 30 rounds in its standard magazines."
	icon = 'icons/obj/gun_wide.dmi'
	icon_state = "g36"
	item_state = "g36"
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = CALIBER_T12
	origin_tech = list(TECH_COMBAT = 7, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	handle_casings = CLEAR_CASINGS
	magazine_type = /obj/item/ammo_magazine/scp/m16_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/m16_mag
	one_hand_penalty = 6
	accuracy_power = 7
	accuracy = 2
	bulk = GUN_BULK_RIFLE
	mag_insert_sound = 'sounds/weapons/guns/interaction/ltrifle_magin.ogg'
	mag_remove_sound = 'sounds/weapons/guns/interaction/ltrifle_magout.ogg'

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=1, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.5, 0.8)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1)
		)

/obj/item/gun/projectile/automatic/g36/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "g36"
	else
		icon_state = "g36-empty"
	return
