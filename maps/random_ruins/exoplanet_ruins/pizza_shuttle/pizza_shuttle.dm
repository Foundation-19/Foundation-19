/datum/map_template/ruin/exoplanet/pizza_shuttle
	name = "Crashed Pizza Shuttle"
	id = "awaysite_pizza_shuttle"
	description = "An abandoned pizza delivery shuttle. I wonder if there's any margherita left."
	suffixes = list("pizza_shuttle/pizza_shuttle.dmm")
	spawn_cost = 0.5
	template_flags = TEMPLATE_FLAG_CLEAR_CONTENTS | TEMPLATE_FLAG_NO_RUINS
	ruin_tags = RUIN_HUMAN|RUIN_WRECK
	apc_test_exempt_areas = list(
		/area/map_template/pizza_shuttle =  NO_SCRUBBER|NO_VENT|NO_APC
	)

/area/map_template/pizza_shuttle
	name = "\improper Crashed Pizza Delivery Shuttle"
	icon_state = "blue"

/obj/effect/landmark/corpse/mbill_pizza_pilot
	corpse_outfits = list(/decl/hierarchy/outfit/mbill_pizza_pilot)
	spawn_flags = CORPSE_SPAWNER_RANDOM_NAME|CORPSE_SPAWNER_RANDOM_GENDER|CORPSE_SPAWNER_RANDOM_HAIR_COLOR|CORPSE_SPAWNER_RANDOM_SKIN_TONE|CORPSE_SPAWNER_RANDOM_HAIR_STYLE|CORPSE_SPAWNER_RANDOM_EYE_COLOR

/decl/hierarchy/outfit/mbill_pizza_pilot
	name = "Major Bill's pizza delivery pilot"
	uniform = /obj/item/clothing/under/mbill
	suit = /obj/item/clothing/suit/storage/mbill
	shoes = /obj/item/clothing/shoes/black
	head = /obj/item/clothing/head/soft/mbill
