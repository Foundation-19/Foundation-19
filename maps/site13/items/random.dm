
/obj/random/trash/site13 //Mostly remains and cleanable decals. Stuff a janitor could clean up
	name = "random trash"
	desc = "This is some random trash."
	icon = 'icons/effects/effects.dmi'
	icon_state = "greenglow"

/obj/random/trash/site13/spawn_choices()
	return list(
				/obj/effect/decal/cleanable/blood/oil,
				/obj/effect/decal/cleanable/blood/oil/streak,
				/obj/effect/decal/cleanable/spiderling_remains,
				/obj/item/remains/mouse,
				/obj/effect/decal/cleanable/vomit,
				/obj/effect/decal/cleanable/blood/splatter,
				/obj/effect/decal/cleanable/ash,
				/obj/effect/decal/cleanable/generic,
				/obj/effect/decal/cleanable/flour,
				/obj/effect/decal/cleanable/dirt)

/obj/random/masks/site13
	name = "random mask"
	desc = "This is a random face mask."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "gas_mask"

/obj/random/masks/site13/spawn_choices()
	return list(/obj/item/clothing/mask/gas = 4,
				/obj/item/clothing/mask/gas/half = 5,
				/obj/item/clothing/mask/breath = 6,
				/obj/item/clothing/mask/breath/medical = 4,
				/obj/item/clothing/mask/balaclava = 3,
				/obj/item/clothing/mask/balaclava/tactical = 2,
				/obj/item/clothing/mask/surgical = 4)

/obj/random/snack/site13
	name = "random snack"
	desc = "This is a random snack item."
	icon = 'icons/obj/food.dmi'
	icon_state = "sosjerky"

/obj/random/snack/site13/spawn_choices()
	return list(/obj/item/weapon/reagent_containers/food/snacks/liquidfood,
				/obj/item/weapon/reagent_containers/food/snacks/candy,
				/obj/item/weapon/reagent_containers/food/drinks/dry_ramen,
				/obj/item/weapon/reagent_containers/food/snacks/chips,
				/obj/item/weapon/reagent_containers/food/snacks/sosjerky,
				/obj/item/weapon/reagent_containers/food/snacks/no_raisin,
				/obj/item/weapon/reagent_containers/food/snacks/spacetwinkie,
				/obj/item/weapon/reagent_containers/food/snacks/cheesiehonkers,
				/obj/item/weapon/reagent_containers/food/snacks/tastybread,
				/obj/item/weapon/reagent_containers/food/snacks/candy/proteinbar,
				/obj/item/weapon/reagent_containers/food/snacks/syndicake,
				/obj/item/weapon/reagent_containers/food/snacks/donut,
				/obj/item/weapon/reagent_containers/food/snacks/donut/cherryjelly,
				/obj/item/weapon/reagent_containers/food/snacks/donut/jelly,
				/obj/item/pizzabox/meat,
				/obj/item/pizzabox/vegetable,
				/obj/item/pizzabox/margherita,
				/obj/item/pizzabox/mushroom,
				/obj/item/weapon/reagent_containers/food/snacks/plumphelmetbiscuit)

/obj/random/shoes/site13
	name = "random footwear"
	desc = "This is a random pair of shoes."
	icon = 'icons/obj/clothing/shoes.dmi'
	icon_state = "boots"

/obj/random/shoes/site13/spawn_choices()
	return list(/obj/item/clothing/shoes/workboots = 3,
				/obj/item/clothing/shoes/jackboots = 3,,
				/obj/item/clothing/shoes/galoshes = 2,
				/obj/item/clothing/shoes/syndigaloshes = 1,
				/obj/item/clothing/shoes/laceup = 4,
				/obj/item/clothing/shoes/black = 4,
				/obj/item/clothing/shoes/jungleboots = 3,
				/obj/item/clothing/shoes/desertboots = 3,
				/obj/item/clothing/shoes/dutyboots = 3,
				/obj/item/clothing/shoes/tactical = 1,
				/obj/item/clothing/shoes/dress = 3,
				/obj/item/clothing/shoes/dress/white = 3,
				/obj/item/clothing/shoes/sandal = 3,
				/obj/item/clothing/shoes/brown = 4,
				/obj/item/clothing/shoes/red = 4,
				/obj/item/clothing/shoes/blue = 4,
				/obj/item/clothing/shoes/leather = 4)

/obj/random/glasses/site13
	name = "random eyewear"
	desc = "This is a random pair of glasses."
	icon = 'icons/obj/clothing/glasses.dmi'
	icon_state = "leforge"

/obj/random/glasses/site13/spawn_choices()
	return list(/obj/item/clothing/glasses/sunglasses = 3,
				/obj/item/clothing/glasses/regular = 7,
				/obj/item/clothing/glasses/welding = 3,
				/obj/item/clothing/glasses/tacgoggles = 1)

/obj/random/hat/site13
	name = "random headgear"
	desc = "This is a random hat of some kind."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "tophat"

/obj/random/hat/site13/spawn_choices()
	return list(/obj/item/clothing/head/helmet = 2,
				/obj/item/clothing/head/helmet/tactical = 1,
				/obj/item/clothing/head/bio_hood/general = 1,
				/obj/item/clothing/head/hardhat = 4,
				/obj/item/clothing/head/hardhat/orange = 4,
				/obj/item/clothing/head/hardhat/red = 4,
				/obj/item/clothing/head/hardhat/dblue = 4,
				/obj/item/clothing/head/ushanka = 3,
				/obj/item/clothing/head/welding = 2)

/obj/random/suit/site13
	name = "random suit"
	desc = "This is a random piece of outerwear."
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "fire"

/obj/random/suit/site13/spawn_choices()
	return list(/obj/item/clothing/suit/storage/hazardvest = 4,
				/obj/item/clothing/suit/storage/toggle/labcoat = 4,
				/obj/item/clothing/suit/armor/vest = 4,
				/obj/item/clothing/suit/storage/vest/tactical = 1,
				/obj/item/clothing/suit/storage/vest = 3,
				/obj/item/clothing/suit/storage/toggle/bomber = 3,
				/obj/item/clothing/suit/chef/classic = 3,
				/obj/item/clothing/suit/surgicalapron = 2,
				/obj/item/clothing/suit/apron/overalls = 3,
				/obj/item/clothing/suit/bio_suit/general = 1,
				/obj/item/clothing/suit/storage/toggle/hoodie/black = 3,
				/obj/item/clothing/suit/storage/toggle/brown_jacket = 3,
				/obj/item/clothing/suit/storage/leather_jacket = 3,
				/obj/item/clothing/suit/apron = 4)

/obj/random/clothing/site13
	name = "random clothes"
	desc = "This is a random piece of clothing."
	icon = 'icons/obj/clothing/uniforms.dmi'
	icon_state = "grey"

/obj/random/clothing/site13/spawn_choices()
	return list(/obj/item/clothing/under/syndicate/tacticool = 2,
				/obj/item/clothing/under/syndicate/combat = 1,
				/obj/item/clothing/under/hazard = 4,
				/obj/item/clothing/under/sterile = 4,
				/obj/item/clothing/under/casual_pants/camo = 2,
				/obj/item/clothing/under/frontier = 2,
				/obj/item/clothing/under/harness = 2,
				/obj/item/clothing/under/overalls = 2,
				/obj/item/clothing/ears/earmuffs = 2,
				/obj/item/clothing/under/tactical = 1)

/obj/random/maintenance/site13 //Clutter and loot for maintenance and away missions
	name = "random maintenance item"
	desc = "This is a random maintenance item."
	icon = 'icons/obj/items.dmi'
	icon_state = "gift1"

/obj/random/maintenance/site13/spawn_choices()
	return list(/obj/random/junk = 4,
				/obj/random/trash/site13 = 4,
				/obj/random/maintenance/site13/clean = 5)

/obj/random/maintenance/site13/clean
/*Maintenance loot lists without the trash, for use inside things.
Individual items to add to the maintenance list should go here, if you add
something, make sure it's not in one of the other lists.*/
	name = "random clean maintenance item"
	desc = "This is a random clean maintenance item."
	icon = 'icons/obj/items.dmi'
	icon_state = "gift2"

/obj/random/maintenance/site13/clean/spawn_choices()
	return list(/obj/random/tech_supply = 100,
				/obj/random/medical = 40,
				/obj/random/medical/lite = 80,
				/obj/random/firstaid = 20,
				/obj/random/powercell = 50,
				/obj/random/material = 40,
				/obj/random/coin = 5,
				/obj/random/tank = 20,
				/obj/random/soap = 5,
				/obj/random/drinkbottle = 5,
				/obj/random/smokes = 30,
				/obj/random/masks = 10,
				/obj/random/snack = 60,
				/obj/random/storage = 30,
				/obj/random/shoes/site13 = 20,
				/obj/random/gloves = 10,
				/obj/random/glasses/site13 = 20,
				/obj/random/hat/site13 = 10,
				/obj/random/suit/site13 = 20,
				/obj/random/clothing/site13 = 30,
				/obj/random/accessory = 20,
				/obj/random/cash = 10)
