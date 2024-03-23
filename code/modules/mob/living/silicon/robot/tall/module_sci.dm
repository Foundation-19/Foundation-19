/obj/item/robot_module/tall/sci
	name = "Scientific Department module"
	display_name = "Research"
	sprites = list(
		"Basic" = "scirobot"
	)
	channels = list(
		"Science" = TRUE
	)
	networks = list(
		NETWORK_RESEARCH
	)
	can_be_pushed = FALSE
	equipment = list(
		/obj/item/device/flash,
		/obj/item/portable_destructive_analyzer,
		/obj/item/gripper/research,
		/obj/item/gripper/no_use/loader,
		/obj/item/device/robotanalyzer,
		/obj/item/card/robot,
		/obj/item/wrench,
		/obj/item/screwdriver,
		/obj/item/weldingtool/mini,
		/obj/item/wirecutters,
		/obj/item/crowbar,
		/obj/item/scalpel/laser3,
		/obj/item/circular_saw,
		/obj/item/extinguisher/mini,
		/obj/item/reagent_containers/syringe,
		/obj/item/gripper/chemistry,
		/obj/item/stack/nanopaste
	)
	synths = list(
		/datum/matter_synth/nanite = 10000
	)
	emag = /obj/prefab/hand_teleporter
	skills = list(
		SKILL_COMPUTER            = SKILL_MASTER,
		SKILL_FINANCE             = SKILL_EXPERIENCED,
		SKILL_SCIENCE             = SKILL_MASTER,
		SKILL_DEVICES             = SKILL_MASTER,
		SKILL_ANATOMY             = SKILL_TRAINED,
		SKILL_CHEMISTRY           = SKILL_TRAINED,
		SKILL_ELECTRICAL          = SKILL_EXPERIENCED
	)
/obj/item/robot_module/tall/sci/finalize_equipment()
	. = ..()
	var/obj/item/stack/nanopaste/N = locate() in equipment
	N.uses_charge = 1
	N.charge_costs = list(1000)

/obj/item/robot_module/tall/sci/finalize_synths()
	. = ..()
	var/datum/matter_synth/nanite/nanite = locate() in synths
	var/obj/item/stack/nanopaste/N = locate() in equipment
	N.synths = list(nanite)

/obj/item/robot_module/tall/sci/officer
	name = "Scientific Department Officer module"
	display_name = "Research"
	sprites = list(
		"Basic" = "sciorobot"
	)
	channels = list(
		"Science" = TRUE,
		"Command" = TRUE
	)
	equipment = list(
		/obj/item/device/flash,
		/obj/item/portable_destructive_analyzer,
		/obj/item/gripper/research,
		/obj/item/gripper/no_use/loader,
		/obj/item/device/robotanalyzer,
		/obj/item/card/robot,
		/obj/item/wrench,
		/obj/item/screwdriver,
		/obj/item/weldingtool/mini,
		/obj/item/wirecutters,
		/obj/item/crowbar,
		/obj/item/scalpel/laser3,
		/obj/item/circular_saw,
		/obj/item/extinguisher/mini,
		/obj/item/reagent_containers/syringe,
		/obj/item/gripper/chemistry,
		/obj/item/stack/nanopaste
	)
	synths = list(
		/datum/matter_synth/nanite = 10000
	)
	emag = /obj/prefab/hand_teleporter