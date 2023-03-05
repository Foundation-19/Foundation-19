/obj/item/gun/projectile/revolver
	name = "Mk7 Revolver"
	desc = "The SCPF Mk7 Revolver, reminiscent of the Colt Python. This weapon, patented and produced by the SCP Foundation is popular among high-ranking security officers. Uses .357 ammo."
	icon = 'icons/obj/gun.dmi'
	icon_state = "revolver"
	item_state = "revolver"
	caliber = CALIBER_REVOLVER
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	handle_casings = CYCLE_CASINGS
	max_shells = 6
	fire_delay = 4 //Revolvers are naturally slower-firing
	ammo_type = /obj/item/ammo_casing/revolver
	var/chamber_offset = 0 //how many empty chambers in the cylinder until you hit a round
	mag_insert_sound = 'sounds/weapons/guns/interaction/rev_magin.ogg'
	mag_remove_sound = 'sounds/weapons/guns/interaction/rev_magout.ogg'
	accuracy = 2
	accuracy_power = 8
	one_hand_penalty = 2
	bulk = 3

/obj/item/gun/projectile/revolver/AltClick()
	if(CanPhysicallyInteract(usr))
		spin_cylinder()

/obj/item/gun/projectile/revolver/verb/spin_cylinder()
	set name = "Spin cylinder"
	set desc = "Fun when you're bored out of your skull."
	set category = "Object"

	chamber_offset = 0
	visible_message(SPAN_WARNING("\The [usr] spins the cylinder of \the [src]!"), \
	SPAN_NOTICE("You hear something metallic spin and click."))
	playsound(src.loc, 'sounds/weapons/revolver_spin.ogg', 100, 1)
	show_sound_effect(src.loc, src)
	loaded = shuffle(loaded)
	if(rand(1,max_shells) > loaded.len)
		chamber_offset = rand(0,max_shells - loaded.len)

/obj/item/gun/projectile/revolver/consume_next_projectile()
	if(chamber_offset)
		chamber_offset--
		return
	return ..()

/obj/item/gun/projectile/revolver/load_ammo(obj/item/A, mob/user)
	chamber_offset = 0
	return ..()

/obj/item/gun/projectile/revolver/military
	name = "military revolver"
	desc = "A standard-issue revolver of many militaries in the known human space."
	icon_state = "military"
	fire_delay = 6
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 2)

/obj/item/gun/projectile/revolver/military/heavy
	name = "heavy revolver"
	desc = "A heavy revolver used mostly by officers or special forces of human worlds."
	icon_state = "tp44"
	caliber = CALIBER_REVOLVER_HEAVY
	ammo_type = /obj/item/ammo_casing/revolver/heavy
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3)

/obj/item/gun/projectile/revolver/mateba
	name = "mateba"
	desc = "Standard issue Foundation revolver based off the Mateba Unica. Chambered in .44 Magnum"
	icon_state = "mateba"
	fire_delay = 6
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)

/obj/item/gun/projectile/revolver/medium
	name = "revolver"
	icon_state = "medium"
	safety_icon = "medium_safety"
	caliber = CALIBER_REVOLVER_MEDIUM
	ammo_type = /obj/item/ammo_casing/revolver/medium
	desc = "The Lumoco Arms' Solid is a rugged revolver for people who don't keep their guns well-maintained."
	accuracy = 1
	bulk = 0
	fire_delay = 7

/obj/item/gun/projectile/revolver/holdout
	name = "holdout revolver"
	desc = "The al-Maliki & Mosley Partner is a concealed-carry revolver made for people who do not trust automatic pistols any more than the people they're dealing with."
	icon_state = "holdout"
	item_state = "pen"
	caliber = CALIBER_REVOLVER_SMALL
	ammo_type = /obj/item/ammo_casing/revolver/small
	w_class = ITEM_SIZE_SMALL
	accuracy = 1
	one_hand_penalty = 0
	bulk = 0
	fire_delay = 5

/obj/item/gun/projectile/revolver/capgun
	name = "cap gun"
	desc = "Looks almost like the real thing! Ages 8 and up."
	icon_state = "revolver-toy"
	caliber = CALIBER_CAPS
	origin_tech = list(TECH_COMBAT = 1, TECH_MATERIAL = 1)
	ammo_type = /obj/item/ammo_casing/cap

/obj/item/gun/projectile/revolver/capgun/attackby(obj/item/wirecutters/W, mob/user)
	if(!istype(W) || icon_state == "revolver")
		return ..()
	to_chat(user, SPAN_NOTICE("You snip off the toy markings off the [src]."))
	name = "revolver"
	icon_state = "revolver"
	desc += " Someone snipped off the barrel's toy mark. How dastardly."
	return 1
