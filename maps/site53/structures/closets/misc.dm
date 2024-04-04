/* DEPRECATED AND UNUSED!

/obj/structure/closet/secure_closet/liaison
	name = "\improper NanoTrasen liaison's locker"
	req_access = list(access_liaison)
	icon_state = "nanottwo1"
	icon_closed = "nanottwo"
	icon_locked = "nanottwo1"
	icon_opened = "nanottwoopen"
	icon_off = "nanottwooff"

/obj/structure/closet/secure_closet/liaison/WillContain()
	return list(
		/obj/item/device/flash,
		/obj/item/hand_labeler,
		/obj/item/device/camera,
		/obj/item/device/camera_film = 2,
		/obj/item/material/clipboard,
		/obj/item/folder,
		/obj/item/device/taperecorder,
		/obj/item/device/tape/random = 3,
		/obj/item/storage/secure/briefcase,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/under/rank/internalaffairs/plain/nt,
		/obj/item/clothing/suit/storage/toggle/suit/black,
		/obj/item/clothing/glasses/sunglasses/big,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack, /obj/item/storage/backpack/satchel)),
		new /datum/atom_creator/simple(/obj/item/storage/backpack/messenger, 50)
	)

/obj/structure/closet/secure_closet/representative
	name = "\improper Sol Central Government representative's locker"
	req_access = list(access_representative)
	icon_state = "solsecure1"
	icon_closed = "solsecure"
	icon_locked = "solsecure1"
	icon_opened = "solsecureopen"
	icon_off = "solsecureoff"

/obj/structure/closet/secure_closet/representative/WillContain()
	return list(
		/obj/item/device/flash,
		/obj/item/hand_labeler,
		/obj/item/device/camera,
		/obj/item/device/camera_film = 2,
		/obj/item/material/clipboard,
		/obj/item/folder,
		/obj/item/device/taperecorder,
		/obj/item/device/tape/random = 3,
		/obj/item/storage/secure/briefcase,
		/obj/item/device/radio/headset/headset_com,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/under/rank/internalaffairs/plain/solgov,
		/obj/item/clothing/suit/storage/toggle/suit/black,
		/obj/item/clothing/glasses/sunglasses/big,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack, /obj/item/storage/backpack/satchel)),
		new /datum/atom_creator/simple(/obj/item/storage/backpack/messenger, 50)
	)

//equipment closets that everyone on the crew or in research can access, for storing things securely

/obj/structure/closet/secure_closet/crew
	name = "crew equipment locker"
	req_access = list(access_solgov_crew)
	icon_state = "sol1"
	icon_closed = "sol"
	icon_locked = "sol1"
	icon_opened = "solopen"
	icon_off = "soloff"

/obj/structure/closet/secure_closet/crew/WillContain()
	return list(
		/obj/item/device/radio,
		/obj/item/crowbar,
		/obj/item/device/flashlight,
		/obj/item/storage/box
	)

/obj/structure/closet/secure_closet/crew/research
	name = "research equipment locker"
	req_access = list(access_nanotrasen)
	icon_state = "nanot1"
	icon_closed = "nanot"
	icon_locked = "nanot1"
	icon_opened = "nanotopen"
	icon_off = "nanotoff"

/obj/structure/closet/secure_closet/guncabinet/sidearm
	name = "sidearm cabinet"
	req_access = list()
	req_one_access = list(access_armory,access_emergency_armory,access_hos,access_hop,access_ce,access_cmo,access_rd,access_senadv)

/obj/structure/closet/secure_closet/guncabinet/sidearm/WillContain()
	return list(
			/obj/item/clothing/accessory/holster/thigh = 2,
			/obj/item/gun/energy/gun = 3,
	)

/obj/structure/closet/secure_closet/guncabinet/sidearm/small
	name = "personal sidearm cabinet"

/obj/structure/closet/secure_closet/guncabinet/sidearm/small/WillContain()
	return list(/obj/item/gun/energy/gun/small = 4)

/obj/structure/closet/secure_closet/guncabinet/sidearm/combined
	name = "combined sidearm cabinet"

/obj/structure/closet/secure_closet/guncabinet/sidearm/combined/WillContain()
	return list(
		/obj/item/gun/energy/gun/small = 2,
		/obj/item/clothing/accessory/holster/thigh = 2,
		/obj/item/gun/energy/gun = 2,
		new /datum/atom_creator/weighted(list(/obj/item/gun/energy/gun, /obj/item/gun/energy/gun/small))
	)

*/
// D-CLASS JANITORIAL

/obj/structure/closet/djcloset
	name = "custodial closet"
	desc = "It's a storage unit for janitorial clothes and gear."
	icon_state = "mixed"
	icon_closed = "mixed"
/obj/structure/closet/djcloset/WillContain()
	return list(
		/obj/item/mop,
		/obj/item/reagent_containers/glass/bucket,
		/obj/item/clothing/gloves/thick,
		/obj/item/clothing/head/soft/purple,
		/obj/item/clothing/head/beret/purple,
		/obj/item/caution = 4,
		/obj/item/device/lightreplacer,
		/obj/item/storage/bag/trash,
		/obj/item/clothing/shoes/galoshes,
		/obj/item/soap)

// D-CLASS MINING

/obj/structure/closet/secure_closet/site53/dmining
	name = "miner's equipment"
	icon_state = "miningsec1"
	icon_closed = "miningsec"
	icon_locked = "miningsec1"
	icon_opened = "miningsecopen"
	icon_broken = "miningsecbroken"
	icon_off = "miningsecoff"
	req_access = list(ACCESS_DCLASS_MINING)

/obj/structure/closet/secure_closet/site53/dmining/WillContain()
	return list(
		/obj/item/clothing/gloves/thick,
//		/obj/item/device/analyzer,
		/obj/item/storage/ore,
		/obj/item/device/flashlight/lantern,
		/obj/item/shovel,
		/obj/item/pickaxe/silver,
		/obj/item/clothing/glasses/meson,
		/obj/item/device/measuring_tape,
		/obj/item/storage/bag/fossils,
		/obj/item/device/ano_scanner,
		/obj/item/device/depth_scanner,
		/obj/item/storage/excavation)
