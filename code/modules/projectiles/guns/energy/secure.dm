/obj/item/gun/energy/gun/small/secure
	name = "compact smartgun"
	desc = "Combining the two LAEP90 variants, the secure and compact LAEP90-CS is the next best thing to keeping your security forces on a literal leash."
	icon = 'icons/obj/guns/small_egun_secure.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_guns_secure.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_guns_secure.dmi',
		)
	req_access = list(list(ACCESS_BRIG, ACCESS_BRIDGE))
	authorized_modes = list(ALWAYS_AUTHORIZED, AUTHORIZED)

/obj/item/gun/energy/stunrevolver/secure
	name = "smart stun revolver"
	desc = "This A&M X6 is fitted with an NT1019 chip which allows remote authorization of weapon functionality. It has an SCG emblem on the grip."
	icon = 'icons/obj/guns/stunrevolver_secure.dmi'
	icon_state = "revolverstun100"
	modifystate= "revolverstun"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_guns_secure.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_guns_secure.dmi',
		)
	item_state = null
	req_access = list(list(ACCESS_BRIG, ACCESS_BRIDGE))

/obj/item/gun/energy/gun/secure
	name = "smartgun"
	desc = "A more secure LAEP90, the LAEP90-S is designed to please paranoid constituents. Body cam not included."
	icon = 'icons/obj/guns/energy_gun_secure.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_guns_secure.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_guns_secure.dmi',
		)
	item_state = null	//so the human update icon uses the icon_state instead.
	req_access = list(list(ACCESS_BRIG, ACCESS_BRIDGE))
	authorized_modes = list(ALWAYS_AUTHORIZED, AUTHORIZED)

/obj/item/gun/energy/gun/secure/preauthorized
	authorized_modes = list(ALWAYS_AUTHORIZED, AUTHORIZED, AUTHORIZED)

/obj/item/gun/energy/revolver/secure
	name = "smart service revolver"
	desc = "The LAER680-S, a standard issue service revolver commonly used by higher ranking offcers among the SCG. Fitted with an NT1019 chip which allows remote authorization of the weapon's functionality."
	icon = 'icons/obj/guns/energy_revolver.dmi'
	icon_state = "energyrevolverstun100"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_guns_secure.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_guns_secure.dmi',
		)
	modifystate = "energyrevolverstun"
	item_state = null
	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, modifystate="energyrevolverstun"),
		list(mode_name="shock", projectile_type=/obj/item/projectile/beam/stun/shock, modifystate="energyrevolvershock"),
		list(mode_name="kill", projectile_type=/obj/item/projectile/beam, modifystate="energyrevolverkill"),
		)
	req_access = list(list(ACCESS_BRIG, ACCESS_HEADS))
	authorized_modes = list(ALWAYS_AUTHORIZED, AUTHORIZED)

/obj/item/gun/energy/gun/secure/mounted
	name = "robot energy gun"
	desc = "A robot-mounted equivalent of the LAEP90-S, which is always registered to its owner."
	self_recharge = 1
	use_external_power = 1
	one_hand_penalty = 0
	has_safety = FALSE
	item_flags = ITEM_FLAG_INVALID_FOR_CHAMELEON

/obj/item/gun/energy/gun/secure/mounted/Initialize()
	var/mob/borg = get_holder_of_type(src, /mob/living/silicon/robot)
	if(!borg)
		CRASH("Invalid spawn location.")
	registered_owner = borg.name
	GLOB.secure_weapons |= src
	. = ..()

/obj/item/gun/energy/gun/mounted/mk9
	name = "Mounted MK9 Foundation Pistol"
	desc = "Standard issue 9mm pistol of the SCP Foundation. Based on the HK VP9. This one is shaped for cyborgs. Chambered in lethal bullets."
	icon = 'icons/obj/gun.dmi'
	icon_state = "MK9"
	modifystate = null
	charge_meter = 0
	projectile_type = /obj/item/projectile/bullet/pistol
	fire_delay = 2
	self_recharge = 1
	use_external_power = 1
	has_safety = FALSE
	firemodes = null

/obj/item/gun/energy/gun/mounted/mk9/on_update_icon()
	..()

/obj/item/gun/energy/gun/mounted/mk9/rubber
	projectile_type = /obj/item/projectile/bullet/pistol/rubber

/obj/item/gun/energy/gun/mounted/p90
	name = "Mounted FN P90"
	desc = "The FN P90 is a submachine gun chambered in 5.7x28mm, also classified as a personal defense weapon, designed and manufactured by FN Herstal in Belgium. Created in response to NATO requests for a replacement for 9x19mm Parabellum firearms, the P90 was designed as a compact but powerful firearm for vehicle crews, operators of crew-served weapons, support personnel, special forces, and counter-terrorist groups. This one has a scope, and is issued to specifically LCZ Security, and or MTF. This one is shaped for cyborgs."
	icon = 'icons/obj/gun.dmi'
	icon_state = "p90"
	modifystate = null
	charge_meter = 0
	projectile_type = /obj/item/projectile/bullet/a57
	force = 10
	one_hand_penalty = 1
	self_recharge = 1
	use_external_power = 1
	has_safety = FALSE

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.5, 0.8)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.1, 0.7, 1.1), autofire_enabled=1),
		)

/obj/item/gun/energy/gun/mounted/m16/mounted
	name = "M16A2"
	desc = "A Foundation-standard service rifle that takes 5.56x45mm straight magazines. Like many reliable firearms of old, the Foundation has found a use for them in the hands of Security Department operatives. This one is shaped for cyborgs."
	icon = 'icons/obj/gun.dmi'
	icon_state = "m16"
	modifystate = null
	charge_meter = 0
	projectile_type = /obj/item/projectile/bullet/rifle/m16
	force = 10
	one_hand_penalty = 1
	self_recharge = 1
	use_external_power = 1
	has_safety = FALSE

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=1, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.5, 0.8)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/energy/laser/secure
	name = "laser carbine"
	desc = "A Hephaestus Industries G40E carbine, designed to kill with concentrated energy blasts. Fitted with an NT1019 chip to make sure killcount is tracked appropriately."
	icon_state = "lasersec"
	req_access = list(list(ACCESS_BRIG, ACCESS_BRIDGE))
