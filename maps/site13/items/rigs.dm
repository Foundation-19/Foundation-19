/*
 * SITE13
 */

/obj/item/weapon/rig/ce/site13

	name = "Advanced Hazardous EnViroment Suit"
	suit_type = "engineering hardsuit"
	desc = "An advanced suit that protects against hazardous, low pressure environments. Shines with a high polish."
	icon_state = "ce_rig"
	armor = list(melee = 40, bullet = 25, laser = 30, energy = 25, bomb = 40, bio = 100, rad = 100)
	online_slowdown = 0
	offline_slowdown = 0
	offline_vision_restriction = TINT_HEAVY

	helm_type = /obj/item/clothing/head/helmet/space/rig/ce/site13
	glove_type = /obj/item/clothing/gloves/rig/ce/site13

	allowed = list(/obj/item/weapon/gun,/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/weapon/storage/ore,/obj/item/weapon/storage/toolbox,/obj/item/weapon/storage/briefcase/inflatable,/obj/item/weapon/inflatable_dispenser,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe,/obj/item/weapon/rcd)

	req_access = list()
	req_one_access = list()

/obj/item/weapon/rig/ce/site13/equipped/

	req_access = list(access_mtflvl4)

	initial_modules = list(
		/obj/item/rig_module/mounted/plasmacutter,
		/obj/item/rig_module/device/rcd,
		/obj/item/rig_module/device/flash,
		/obj/item/rig_module/vision/meson,
		/obj/item/rig_module/grenade_launcher/mfoam,
		/obj/item/rig_module/cooling_unit
		)

/obj/item/clothing/head/helmet/space/rig/ce/site13
	camera = /obj/machinery/camera/network/engineering

/obj/item/clothing/gloves/rig/ce/site13
	siemens_coefficient = 0

/obj/item/weapon/rig/eva/site13
	name = "Hazardous EnViroment Suit"
	suit_type = "EVA hardsuit"
	desc = "A light suit for repairs and maintenance in hazardous enviroments."
	icon_state = "eva_rig"
	armor = list(melee = 30, bullet = 10, laser = 20,energy = 25, bomb = 20, bio = 100, rad = 100)
	online_slowdown = 0
	offline_slowdown = 1
	offline_vision_restriction = TINT_HEAVY

	chest_type = /obj/item/clothing/suit/space/rig/eva/site13
	helm_type = /obj/item/clothing/head/helmet/space/rig/eva/site13
	glove_type = /obj/item/clothing/gloves/rig/eva/site13

	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/weapon/storage/toolbox,/obj/item/weapon/storage/briefcase/inflatable,/obj/item/weapon/inflatable_dispenser,/obj/item/device/t_scanner,/obj/item/weapon/rcd)

	req_access = list(access_mtflvl3)
	req_one_access = list()

/obj/item/clothing/head/helmet/space/rig/eva/site13
	light_overlay = "helmet_light_dual"
	camera = /obj/machinery/camera/network/engineering

/obj/item/clothing/suit/space/rig/eva/site13

/obj/item/clothing/gloves/rig/eva/site13
	siemens_coefficient = 0

/obj/item/weapon/rig/eva/site13/equipped

	req_access = list(access_mtflvl3)

	initial_modules = list(
		/obj/item/rig_module/mounted/plasmacutter,
		/obj/item/rig_module/device/rcd,
		/obj/item/rig_module/vision/meson,
		/obj/item/rig_module/cooling_unit
		)
