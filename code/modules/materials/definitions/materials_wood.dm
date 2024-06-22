/material/wood
	name = MATERIAL_WOOD
	adjective_name = "wooden"
	stack_type = /obj/item/stack/material/wood
	icon_colour = WOOD_COLOR_GENERIC
	integrity = 75
	icon_base = "wood"
	table_icon_base = "wood"
	explosion_resistance = 2
	shard_type = SHARD_SPLINTER
	shard_can_repair = 0 // you can't weld splinters back into planks
	hardness = MATERIAL_FLEXIBLE + 10
	brute_armor = 1
	weight = 18
	melting_point = T0C+300 //okay, not melting in this case, but hot enough to destroy wood
	ignition_point = T0C+288
	stack_origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 1)
	dooropen_noise = 'sounds/effects/doorcreaky.ogg'
	door_icon_base = "wood"
	destruction_desc = "splinters"
	sheet_singular_name = "plank"
	sheet_plural_name = "planks"
	hitsound = 'sounds/effects/woodhit.ogg'
	conductive = 0
	construction_difficulty = MATERIAL_NORMAL_DIY
	chem_products = list(
				/datum/reagent/carbon = 10,
				/datum/reagent/water = 5
				)
	sale_price = 1
	value = 3

/material/wood/holographic
	name = "holo" + MATERIAL_WOOD
	icon_colour = WOOD_COLOR_CHOCOLATE //the very concept of wood should be brown
	display_name = "wood"
	stack_type = null
	shard_type = SHARD_NONE
	sale_price = 0
	value = 0
	hidden_from_codex = TRUE

/material/wood/mahogany
	name = MATERIAL_MAHOGANY
	adjective_name = MATERIAL_MAHOGANY
	icon_colour = WOOD_COLOR_RICH
	construction_difficulty = MATERIAL_HARD_DIY
	sale_price = 3
	value = 45

/material/wood/maple
	name = MATERIAL_MAPLE
	adjective_name = MATERIAL_MAPLE
	icon_colour = WOOD_COLOR_PALE

/material/wood/ebony
	name = MATERIAL_EBONY
	adjective_name = MATERIAL_EBONY
	icon_colour = WOOD_COLOR_BLACK
	weight = 22
	integrity = 100
	construction_difficulty = MATERIAL_VERY_HARD_DIY
	sale_price = 6
	value = 85

/material/wood/walnut
	name = MATERIAL_WALNUT
	adjective_name = MATERIAL_WALNUT
	icon_colour = WOOD_COLOR_CHOCOLATE
	weight = 20
	construction_difficulty = MATERIAL_HARD_DIY
	sale_price = 2
	value = 21

/material/wood/bamboo
	name = MATERIAL_BAMBOO
	adjective_name = MATERIAL_BAMBOO
	icon_colour = WOOD_COLOR_PALE2
	weight = 16
	hardness = MATERIAL_RIGID

/material/wood/yew
	name = MATERIAL_YEW
	adjective_name = MATERIAL_YEW
	icon_colour = WOOD_COLOR_YELLOW
	chem_products = list(
				/datum/reagent/carbon = 10,
				/datum/reagent/water = 5,
				/datum/reagent/toxin/taxine = 0.05
				)

/material/wood/vox
	name = MATERIAL_VOXRES
	ignition_point = T0C+300
	melting_point = T0C+300
	conductive = 0
	stack_type = /obj/item/stack/material/wood/vox
	icon_colour = "#3a4e1b"
	chem_products = list(
				/datum/reagent/resinpulp = 20
				)
	hidden_from_codex = TRUE
	sheet_singular_name = "slab"
	sheet_plural_name = "slabs"
	construction_difficulty = MATERIAL_NORMAL_DIY
	integrity = 60
	hardness = MATERIAL_FLEXIBLE
	weight = 12
	brute_armor = 1
