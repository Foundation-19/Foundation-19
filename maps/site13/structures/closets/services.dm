/*
 * Site13 Service
 */

/obj/structure/closet/secure_closet/hydroponics/site13
	name = "hydroponics locker"
	req_access = list(access_dclassbotany)
	icon_state = "hydrosecure1"
	icon_closed = "hydrosecure"
	icon_locked = "hydrosecure1"
	icon_opened = "hydrosecureopen"
	icon_off = "hydrosecureoff"

/obj/structure/closet/secure_closet/hydroponics/site13/WillContain()
	return list(
		/obj/item/clothing/suit/apron,
		/obj/item/clothing/suit/apron/overalls,
		/obj/item/weapon/storage/plants,
		/obj/item/device/analyzer/plant_analyzer,
		/obj/item/clothing/mask/bandana/botany,
		/obj/item/clothing/head/bandana/green,
		/obj/item/weapon/reagent_containers/spray/plantbgone,
		/obj/item/clothing/suit/apron,
	)


/obj/structure/closet/jcloset/site13
	name = "custodial closet"
	desc = "It's a storage unit for janitorial equipment."
	icon_state = "mixed"
	icon_closed = "mixed"

/obj/structure/closet/jcloset/site13/WillContain()
	return list(
		/obj/item/clothing/suit/apron/overalls,
		/obj/item/clothing/gloves/thick,
		/obj/item/device/flashlight,
		/obj/item/weapon/caution = 4,
		/obj/item/device/lightreplacer,
		/obj/item/weapon/storage/bag/trash,
		/obj/item/clothing/shoes/galoshes,
		/obj/item/weapon/soap/nanotrasen
	)
