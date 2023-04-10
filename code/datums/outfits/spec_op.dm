/decl/hierarchy/outfit/mercenary
	name = "Spec Ops - Mercenary"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	l_ear = /obj/item/device/radio/headset/syndicate/alt
	belt = /obj/item/storage/belt/holster/security
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/thick/swat
	l_pocket = /obj/item/reagent_containers/pill/cyanide

	id_slot = slot_wear_id
	id_types = list(/obj/item/card/id/syndicate)
	id_pda_assignment = "Mercenary"

	backpack_contents = list(/obj/item/clothing/suit/space/void/merc/prepared = 1, /obj/item/clothing/mask/gas/syndicate = 1)

	flags = OUTFIT_HAS_BACKPACK|OUTFIT_RESET_EQUIPMENT

/decl/hierarchy/outfit/mercenary/syndicate
	name = "Spec Ops - Syndicate"
	suit = /obj/item/clothing/suit/armor/vest
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/swat
	shoes = /obj/item/clothing/shoes/swat
	id_desc = "Syndicate Operative"

/decl/hierarchy/outfit/mercenary/syndicate/commando
	name = "Spec Ops - Syndicate Commando"
	suit = /obj/item/clothing/suit/space/void/merc
	mask = /obj/item/clothing/mask/gas/syndicate
	head = /obj/item/clothing/head/helmet/space/void/merc
	back = /obj/item/tank/jetpack/oxygen
	l_pocket = /obj/item/tank/emergency/oxygen

/decl/hierarchy/outfit/foundation
	name = "Cuchulain Foundation Agent"
	glasses =  /obj/item/clothing/glasses/sunglasses
	uniform =  /obj/item/clothing/under/suit_jacket/charcoal
	shoes =    /obj/item/clothing/shoes/black
	l_hand =   /obj/item/storage/briefcase/foundation/revolver
	l_ear =    /obj/item/device/radio/headset/foundation
	holster =  /obj/item/clothing/accessory/storage/holster/armpit
	id_slot =  slot_wear_id
