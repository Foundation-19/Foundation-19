/datum/design/cryobeaker
	name = "Cryostasis Beaker"
	desc = "A beaker that allows for chemical storage without reactions. Can hold up to 50 units."
	id = "cryobeaker"
	build_type = PROTOLATHE
	materials = list(MATERIAL_STEEL = 3000)
	build_path = /obj/item/reagent_containers/glass/beaker/noreact
	departmental_flags = SCI | MED

/datum/design/bluespacebeaker
	name = "Bluespace Beaker"
	desc = "An experimental beaker that can store much more than expected. Can hold up to 300 units."
	id = "bluespacebeaker"
	build_type = PROTOLATHE
	materials = list(MATERIAL_STEEL = 3000, MATERIAL_PHORON = 3000, MATERIAL_DIAMOND = 500)
	build_path = /obj/item/reagent_containers/glass/beaker/bluespace
	departmental_flags = SCI | MED
