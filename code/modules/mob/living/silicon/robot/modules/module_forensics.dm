/obj/item/robot_module/forensics
	name = "forensic robot module"
	display_name = "Forensics"
	channels = list("Security" = TRUE, "ECZ-Security" = TRUE, "HCZ-Security" = TRUE, "LCZ-Security" = TRUE)
	networks = list(NETWORK_SECURITY)
	subsystems = list(
		/datum/nano_module/crew_monitor,
		/datum/nano_module/program/digitalwarrant,
		/datum/nano_module/records
	)
	sprites = list(
		"Android - Detective" = "detectiverobot"
	)
	equipment = list(
		/obj/item/swabber,
		/obj/item/storage/evidence,
		/obj/item/forensics/sample_kit,
		/obj/item/forensics/sample_kit/powder,
		/obj/item/gripper/forensics,
		/obj/item/device/flash,
		/obj/item/borg/sight/hud/sec,
		/obj/item/taperoll/police,
		/obj/item/scalpel/laser1,
		/obj/item/autopsy_scanner,
		/obj/item/device/scanner/reagent,
		/obj/item/reagent_containers/spray/luminol,
		/obj/item/device/uv_light,
		/obj/item/crowbar
	)
	emag = /obj/item/gun/energy/laser/mounted
	skills = list(
		SKILL_COMPUTER            = SKILL_EXPERIENCED,
		SKILL_FORENSICS           = SKILL_MASTER,
		SKILL_WEAPONS             = SKILL_EXPERIENCED,
		SKILL_CONSTRUCTION        = SKILL_TRAINED,
		SKILL_ANATOMY             = SKILL_TRAINED
	)

/obj/item/robot_module/forensics/respawn_consumable(mob/living/silicon/robot/R, amount)
	var/obj/item/reagent_containers/spray/luminol/luminol = locate() in equipment
	if(!luminol)
		luminol = new(src)
		equipment += luminol
	if(luminol.reagents.total_volume < luminol.volume)
		var/adding = min(luminol.volume-luminol.reagents.total_volume, 2*amount)
		if(adding > 0)
			luminol.reagents.add_reagent(/datum/reagent/luminol, adding)
	..()
