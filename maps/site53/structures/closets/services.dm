/*
 * Torch Service
 */

/obj/structure/closet/chefcloset_torch
	name = "chef's closet"
	desc = "It's a storage unit for foodservice equipment."
	icon_state = "black"

/obj/structure/closet/chefcloset_torch/WillContain()
	return list(
		/obj/item/device/radio/headset/headset_service,
		/obj/item/storage/box/mousetraps = 2,
		/obj/item/clothing/under/rank/chef,
		/obj/item/clothing/head/chefhat,
		/obj/item/clothing/suit/chef/classic
	)

/obj/structure/closet/secure_closet/hydroponics_torch //done so that it has no access reqs
	name = "hydroponics locker"
	req_access = list()
	icon_state = "hydrosecure1"

/obj/structure/closet/secure_closet/hydroponics_torch/WillContain()
	return list(
		/obj/item/storage/plants,
//		/obj/item/device/analyzer/plant_analyzer,
		/obj/item/material/minihoe,
		/obj/item/material/hatchet,
		/obj/item/wirecutters/clippers,
		/obj/item/reagent_containers/spray/plantbgone,
		new /datum/atom_creator/weighted(list(/obj/item/clothing/suit/apron, /obj/item/clothing/suit/apron/overalls)),
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/hydroponics)),
		new /datum/atom_creator/simple(/obj/item/storage/backpack/messenger/hyd, 50)
	)

/obj/structure/closet/secure_closet/hydroponics_dclass //done so that it has no access reqs
	name = "hydroponics locker"
	req_access = list()
	icon_state = "hydrosecure1"

/obj/structure/closet/secure_closet/hydroponics_dclass/WillContain()
	return list(
		/obj/item/clothing/suit/apron,
		/obj/item/clothing/suit/apron/overalls,
		/obj/item/storage/plants,
//		/obj/item/device/analyzer/plant_analyzer,
		/obj/item/clothing/mask/bandana/botany,
		/obj/item/clothing/head/bandana/green,
//		/obj/item/reagent_containers/spray/plantbgone,
		new /datum/atom_creator/weighted(list(/obj/item/clothing/suit/apron, /obj/item/clothing/suit/apron/overalls)),
	)


/obj/structure/closet/jcloset_torch
	name = "custodial closet"
	desc = "It's a storage unit for janitorial equipment."
	icon_state = "mixed"

/obj/structure/closet/jcloset_torch/WillContain()
	return list(
		/obj/item/device/radio/headset/headset_service,
//		/obj/item/cartridge/janitor,
		/obj/item/clothing/gloves/thick,
		/obj/item/device/flashlight,
		/obj/item/caution = 4,
		/obj/item/device/lightreplacer,
		/obj/item/storage/bag/trash,
		/obj/item/clothing/shoes/galoshes,
//		/obj/item/soap/nanotrasen
	)

/obj/structure/closet/secure_closet/bar_torch
	name = "bar locker"
	desc = "It's a storage unit for bar equipment."
	req_access = list()

/obj/structure/closet/secure_closet/bar_torch/WillContain()
	return list(
//		/obj/item/reagent_containers/food/drinks/shaker,
//		/obj/item/book/manual/barman_recipes,
		/obj/item/clothing/under/rank/bartender,
		/obj/item/clothing/shoes/laceup
	)

