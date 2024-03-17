/mob/living/silicon/robot/tall
	desc = "A utility robot with it's superior size would be underestimated by staff."
	icon = 'icons/mob/robots_custom.dmi'
	icon_state = "isdrobot"
	speed = -1 // nyoom

/obj/item/robot_module/special
	channels = list(
		"Security" = TRUE
		"Service" = TRUE,
		"Supply" = TRUE
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
		SKILL_FORENSICS   = SKILL_EXPERIENCED,
		SKILL_COMPUTER            = SKILL_EXPERIENCED,
		SKILL_FINANCE             = SKILL_MASTER,
		SKILL_SCIENCE             = SKILL_EXPERIENCED,
		SKILL_DEVICES             = SKILL_EXPERIENCED
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

/obj/item/robot_module/special/general
	name = "internal security borg module"
	display_name = "Internal Security"
	crisis_locked = TRUE
	sprites = list(
		"Basic" = "isdrobot",
	)
	equipment = list(
		/obj/item/device/flash,
		/obj/item/borg/sight/hud/sec,
		/obj/item/handcuffs/cyborg,
		/obj/item/melee/baton/robot,
		/obj/item/gun/energy/gun/secure/mounted,
		/obj/item/taperoll/police,
		/obj/item/device/megaphone,
		/obj/item/device/holowarrant,
		/obj/item/crowbar,
		/obj/item/device/hailer
		/obj/item/gun/energy/laser/mounted
		/obj/item/pen/robopen,
		/obj/item/form_printer,
		/obj/item/gripper/clerical,
		/obj/item/hand_labeler,
		/obj/item/stamp,
		/obj/item/stamp/denied,
		/obj/item/device/destTagger,
		/obj/item/stack/package_wrap/cyborg
	)
