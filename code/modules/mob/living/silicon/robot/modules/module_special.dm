/mob/living/silicon/robot/tall
	desc = "A utility robot with it's superior size would be underestimated by staff."
	icon = 'icons/mob/robots_custom.dmi'
	icon_state = "isdrobot"
	module_category = ROBOT_MODULE_TYPE_GROUNDED
	speed = -1 // nyoom

/obj/item/robot_module/special
	channels = list(
		"Security" = TRUE,
		"Service" = TRUE,
		"Response Team" = TRUE
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

/obj/item/robot_module/special/respawn_consumable(mob/living/silicon/robot/R, amount)
	..()
	for(var/obj/item/gun/energy/T in equipment)
		if(T?.power_supply)
			if(T.power_supply.charge < T.power_supply.maxcharge)
				T.power_supply.give(T.charge_cost * amount)
				T.update_icon()
			else
				T.charge_tick = 0
	var/obj/item/melee/baton/robot/B = locate() in equipment
	if(B?.bcell)
		B.bcell.give(amount)

/obj/item/robot_module/tall/special/general
	name = "internal security borg module"
	display_name = "DATA EXPUNGED"
	crisis_locked = TRUE
	sprites = list(
		"Basic" = "isdrobot"
	)
	equipment = list(
		/obj/item/device/flash,
		/obj/item/pen/robopen,
		/obj/item/form_printer,
		/obj/item/borg/sight/hud/sec,
		/obj/item/handcuffs/cyborg,
		/obj/item/melee/baton/robot,
		/obj/item/gun/energy/gun/secure/mounted,
		/obj/item/device/megaphone,
		/obj/item/crowbar,
		/obj/item/device/hailer,
		/obj/item/hand_labeler,
		/obj/item/stamp,
		/obj/item/stamp/denied,
		/obj/item/weldingtool/electric,
		/obj/item/reagent_containers/borghypo/crisis,
		/obj/item/material/sword/sabre
	)
	emag = list(
		/obj/item/gun/energy/pulse_rifle/destroyer,
		/obj/item/melee/energy/sword
	)
	skills = list(
		SKILL_COMBAT      = SKILL_EXPERIENCED,
		SKILL_WEAPONS     = SKILL_EXPERIENCED,
		SKILL_FORENSICS   = SKILL_EXPERIENCED,
		SKILL_COMPUTER            = SKILL_EXPERIENCED,
		SKILL_FINANCE             = SKILL_MASTER,
		SKILL_SCIENCE             = SKILL_EXPERIENCED,
		SKILL_DEVICES             = SKILL_EXPERIENCED
	)

/obj/item/robot_module/tall/special/general/yawet
	name = "internal security borg module"
	display_name = "DATA EXPUNGED"
	crisis_locked = TRUE
	sprites = list(
		"Basic" = "isdyrobot"
	)
