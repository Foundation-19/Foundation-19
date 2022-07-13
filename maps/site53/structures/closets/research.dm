/*
 * Torch Science
 */

/obj/structure/closet/secure_closet/RD_torch
	name = "research director's locker"
	req_access = list(access_sciencelvl5)
	icon_state = "rdsecure1"
	icon_closed = "rdsecure"
	icon_locked = "rdsecure1"
	icon_opened = "rdsecureopen"
	icon_off = "rdsecureoff"

/obj/structure/closet/secure_closet/RD_torch/WillContain()
	return list(
		/obj/item/clothing/suit/bio_suit/scientist,
		/obj/item/clothing/head/bio_hood/scientist,
		/obj/item/clothing/under/rank/research_director,
		/obj/item/clothing/under/rank/research_director/rdalt,
		/obj/item/clothing/under/rank/research_director/dress_rd,
//		/obj/item/clothing/under/suit_jacket/nt,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/suit/storage/toggle/labcoat/science,
		/obj/item/clothing/suit/storage/toggle/labcoat/rd,
//		/obj/item/cartridge/rd,
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/gloves/latex,
		/obj/item/clothing/glasses/science,
		/obj/item/device/radio/headset/heads/torchntcommand,
		/obj/item/tank/emergency/oxygen/engi,
		/obj/item/clothing/mask/gas,
		/obj/item/device/flash,
		/obj/item/device/megaphone,
		/obj/item/material/clipboard,
		/obj/item/folder,
		/obj/item/device/taperecorder,
		/obj/item/device/tape/random = 3,
		/obj/item/device/camera,
		/obj/item/taperoll/research,
		/obj/item/clothing/glasses/welding/superior,
		/obj/item/device/holowarrant,
		/obj/item/clothing/suit/armor/pcarrier/light,
		/obj/item/storage/box/secret_project_disks/science,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/toxins)),
		new /datum/atom_creator/simple(/obj/item/storage/backpack/messenger/tox, 50)
	)

/obj/structure/closet/secure_closet/secure_closet/xenoarchaeologist_torch
	name = "xenoarchaeologist's locker"
	req_access = list(access_sciencelvl3)
	icon_state = "secureres1"
	icon_closed = "secureres"
	icon_locked = "secureres1"
	icon_opened = "secureresopen"
	icon_off = "secureresoff"

/obj/structure/closet/secure_closet/secure_closet/xenoarchaeologist_torch/WillContain()
	return list(
		/obj/item/clothing/under/rank/scientist,
		/obj/item/clothing/suit/storage/toggle/labcoat/science,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/shoes/white,
//		/obj/item/cartridge/signal/science,
		/obj/item/device/radio/headset/torchnanotrasen,
		/obj/item/clothing/mask/gas,
		/obj/item/material/clipboard,
		/obj/item/folder,
		/obj/item/device/taperecorder,
		/obj/item/device/tape/random = 3,
		/obj/item/device/camera,
//		/obj/item/device/analyzer,
		/obj/item/taperoll/research,
		/obj/item/clothing/gloves/latex,
		/obj/item/clothing/glasses/science,
		/obj/item/clothing/glasses/meson,
		/obj/item/device/radio,
		/obj/item/device/flashlight/lantern,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/toxins)),
		new /datum/atom_creator/simple(/obj/item/storage/backpack/dufflebag, 50)
	)

/obj/structure/closet/secure_closet/scientist_torch
	name = "researcher's locker"
//	req_one_access = list(access_sciencelvl2)
	icon_state = "secureres1"
	icon_closed = "secureres"
	icon_locked = "secureres1"
	icon_opened = "secureresopen"
	icon_off = "secureresoff"

/obj/structure/closet/secure_closet/scientist_torch/WillContain()
	return list(
		/obj/item/clothing/under/rank/scientist,
		/obj/item/clothing/suit/storage/toggle/labcoat/science,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/shoes/white,
//		/obj/item/cartridge/signal/science,
		/obj/item/device/radio/headset/torchnanotrasen,
		/obj/item/clothing/mask/gas/half,
		/obj/item/tank/emergency/oxygen/engi,
		/obj/item/material/clipboard,
		/obj/item/folder,
		/obj/item/device/taperecorder,
		/obj/item/device/tape/random = 3,
		/obj/item/device/camera,
//		/obj/item/device/analyzer,
		/obj/item/taperoll/research,
		/obj/item/clothing/gloves/latex,
		/obj/item/clothing/glasses/science,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/toxins)),
		new /datum/atom_creator/simple(/obj/item/storage/backpack/messenger/tox, 50)
	)

/obj/structure/closet/secure_closet/prospector
	name = "prospector's locker"
	req_access = list(access_sciencelvl2)
	icon_state = "miningsec1"
	icon_closed = "miningsec"
	icon_locked = "miningsec1"
	icon_opened = "miningsecopen"
	icon_off = "miningsecoff"

/obj/structure/closet/secure_closet/prospector/WillContain()
	return list(
		/obj/item/device/radio/headset/torchnanotrasen,
		/obj/item/clothing/under/rank/miner,
		/obj/item/clothing/accessory/storage/webbing,
		/obj/item/clothing/gloves/thick,
		/obj/item/clothing/shoes/workboots,
//		/obj/item/device/analyzer,
		/obj/item/storage/ore,
		/obj/item/device/flashlight/lantern,
		/obj/item/shovel,
		/obj/item/pickaxe,
		/obj/item/crowbar,
		/obj/item/clothing/glasses/material,
		/obj/item/clothing/glasses/meson,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/industrial)),
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/dufflebag/eng, /obj/item/storage/backpack/messenger/engi))
	)

/obj/structure/closet/secure_closet/guard
	name = "security guard's locker"
	req_access = list(access_securitylvl2)
	icon_state = "guard1"
	icon_closed = "guard"
	icon_locked = "guard1"
	icon_opened = "guardopen"
	icon_off = "guardoff"

/obj/structure/closet/secure_closet/guard/WillContain()
	return list(
		/obj/item/clothing/under/rank/guard,
		/obj/item/clothing/suit/armor/pcarrier/medium/nt,
		/obj/item/clothing/head/helmet/nt/guard,
		/obj/item/clothing/head/soft/sec/corp/guard,
		/obj/item/clothing/head/beret/guard,
		/obj/item/clothing/accessory/armband/whitered,
		/obj/item/device/radio/headset/torchnanotrasen,
		/obj/item/clothing/mask/gas/half,
		/obj/item/material/clipboard,
		/obj/item/folder,
		/obj/item/device/taperecorder,
		/obj/item/device/tape/random = 3,
		/obj/item/storage/belt/security,
		/obj/item/device/flash,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/melee/baton/loaded,
		/obj/item/handcuffs = 2,
		/obj/item/device/flashlight/maglight,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/clothing/glasses/tacgoggles,
		/obj/item/clothing/mask/balaclava,
		/obj/item/taperoll/research,
		/obj/item/device/hailer,
		/obj/item/clothing/accessory/storage/black_vest,
//		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/clothing/accessory/badge/holo/NT,
		/obj/item/device/megaphone,
		/obj/item/gun/energy/stunrevolver,
		/obj/item/clothing/shoes/jackboots,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/security)),
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/dufflebag/sec, /obj/item/storage/backpack/messenger/sec))
	)

/obj/structure/closet/secure_closet/scpscience/directorofscience
	name = "Research Director's Locker"
	req_access = list(access_sciencelvl5)
	icon_state = "dslocked"
	icon_closed = "dsunlocked"
	icon_locked = "dslocked"
	icon_opened = "dsopen"
	icon_broken = "dsbroken"
	icon_off = "dsoff"

/obj/structure/closet/secure_closet/scpscience/directorofscience/WillContain()
	return list(
		/obj/item/storage/backpack/dufflebag,
//		/obj/item/clothing/under/scp/suittie,
		/obj/item/clothing/suit/storage/toggle/labcoat/rd,
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/mask/gas,
		/obj/item/material/clipboard
	)



/obj/structure/closet/secure_closet/scientist
	name = "scientist's locker"
	req_access = list(access_sciencelvl2)
	icon_state = "secureres1"
	icon_closed = "secureres"
	icon_locked = "secureres1"
	icon_opened = "secureresopen"
	icon_off = "secureresoff"

/obj/structure/closet/secure_closet/scientist/WillContain()
	return list(
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/messenger/tox)),
		/obj/item/clothing/under/rank/scientist,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/shoes/white,
		/obj/item/device/radio/headset/headset_sci,
		/obj/item/clothing/mask/gas,
		/obj/item/material/clipboard
	)
