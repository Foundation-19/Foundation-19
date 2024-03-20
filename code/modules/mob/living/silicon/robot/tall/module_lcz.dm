/obj/item/robot_module/tall/lcz
	name = "LCZ security module"
	display_name = "Security"
	crisis_locked = TRUE
	sprites = list(
		"Basic" = "lczrobot"
	)
	channels = list(
		"Security" = TRUE,
		"LCZ-Security" = TRUE
	)
	networks = list(
		NETWORK_SECURITY
	)
	subsystems = list(
		/datum/nano_module/crew_monitor,
		/datum/nano_module/program/digitalwarrant
	)
	can_be_pushed = FALSE
	supported_upgrades = list(
		/obj/item/borg/upgrade/weaponcooler
	)
	skills = list(
		SKILL_COMBAT      = SKILL_EXPERIENCED,
		SKILL_WEAPONS     = SKILL_EXPERIENCED,
		SKILL_FORENSICS   = SKILL_EXPERIENCED
	)
	equipment = list(
		/obj/item/device/flash,
		/obj/item/pen/robopen,
		/obj/item/form_printer,
		/obj/item/borg/sight/hud/sec,
		/obj/item/handcuffs/cyborg,
		/obj/item/melee/baton/robot,
		/obj/item/gun/energy/gun/mounted/mk9/mounted/rubber,
		/obj/item/gun/energy/taser/mounted,
		/obj/item/device/megaphone,
		/obj/item/crowbar,
		/obj/item/device/hailer,
		/obj/item/device/holowarrant,
		/obj/item/taperoll/police,
		/obj/item/hand_labeler,
		/obj/item/stamp,
		/obj/item/stamp/denied,
	)
	emag = /obj/item/gun/energy/gun/mounted/p90/mounted

/obj/item/robot_module/tall/lcz/respawn_consumable(mob/living/silicon/robot/R, amount)
	..()
	for(var/obj/item/gun/energy/T in equipment)
		if(T?.power_supply)
			if(T.power_supply.charge < T.power_supply.maxcharge)
				T.power_supply.give(T.charge_cost * amount)
			else
				T.charge_tick = 0
	var/obj/item/melee/baton/robot/B = locate() in equipment
	if(B?.bcell)
		B.bcell.give(amount)

/obj/item/robot_module/tall/lcz/captain
	name = "LCZ security captain module"
	display_name = "Security"
	crisis_locked = TRUE
	sprites = list(
		"Basic" = "lczcrobot"
	)
	equipment = list(
		/obj/item/device/flash,
		/obj/item/pen/robopen,
		/obj/item/form_printer,
		/obj/item/borg/sight/hud/sec,
		/obj/item/handcuffs/cyborg,
		/obj/item/melee/baton/robot,
		/obj/item/gun/energy/gun/mounted/mk9/mounted,
		/obj/item/gun/energy/taser/carbine/mounted,
		/obj/item/device/megaphone,
		/obj/item/crowbar,
		/obj/item/device/hailer,
		/obj/item/device/holowarrant,
		/obj/item/taperoll/police,
		/obj/item/hand_labeler,
		/obj/item/stamp,
		/obj/item/stamp/denied,
	)
	emag = /obj/item/gun/energy/gun/mounted/p90/mounted
