/obj/structure/closet/secure_closet/scientist
	name = "scientist's locker"
	req_access = list(list(ACCESS_TOX,ACCESS_TOX_STORAGE))
	closet_appearance = /decl/closet_appearance/secure_closet/expedition/science

/obj/structure/closet/secure_closet/scientist/WillContain()
	return list(
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/messenger/tox, /obj/item/storage/backpack/satchel/tox)),
		/obj/item/clothing/under/rank/scientist,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/shoes/white,
		/obj/item/device/radio/headset/headset_sci,
		/obj/item/clothing/mask/gas,
		/obj/item/material/clipboard
	)

/obj/structure/closet/secure_closet/xenobio
	name = "xenobiologist's locker"
	req_access = list(ACCESS_XENOBIOLOGY)
	closet_appearance = /decl/closet_appearance/secure_closet/expedition/science

/obj/structure/closet/secure_closet/xenobio/WillContain()
	return list(
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/messenger/tox, /obj/item/storage/backpack/satchel/tox)),
		/obj/item/clothing/under/rank/scientist,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/shoes/white,
		/obj/item/device/radio/headset/headset_sci,
		/obj/item/clothing/mask/gas,
		/obj/item/clothing/gloves/latex,
		/obj/item/material/clipboard,
		/obj/item/storage/belt/general
	)

/obj/structure/closet/secure_closet/RD
	name = "chief science officer's locker"
	req_access = list(ACCESS_RD)
	closet_appearance = /decl/closet_appearance/secure_closet/rd

/obj/structure/closet/secure_closet/RD/WillContain()
	return list(
		/obj/item/clothing/suit/bio_suit/scientist = 2,
		/obj/item/clothing/head/bio_hood/scientist = 2,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/gloves/latex,
		/obj/item/device/radio/headset/heads/rd,
		/obj/item/clothing/mask/gas,
		/obj/item/device/flash,
		/obj/item/material/clipboard,
	)

/obj/structure/closet/secure_closet/animal
	name = "animal control closet"
	req_access = list(ACCESS_RESEARCH)

/obj/structure/closet/secure_closet/animal/WillContain()
	return list(
		/obj/item/device/assembly/signaller,
		/obj/item/device/radio/electropack = 3,
		/obj/item/gun/launcher/syringe/rapid,
		/obj/item/storage/box/syringegun,
		/obj/item/storage/box/syringes,
		/obj/item/reagent_containers/glass/bottle/chloralhydrate,
		/obj/item/reagent_containers/glass/bottle/stoxin
	)
