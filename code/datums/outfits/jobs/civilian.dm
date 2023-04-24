
/decl/hierarchy/outfit/job/civ/classd
	name = OUTFIT_JOB_NAME("Class D")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	l_ear = null
	l_pocket = /obj/item/paper/dclass_orientation
	id_type = /obj/item/card/id/classd

/decl/hierarchy/outfit/job/civ/classd/post_equip(mob/living/carbon/human/H)
	..()
	if(prob(15))
		var/path = pick( /obj/item/wrench, /obj/item/screwdriver)
		H.equip_to_slot_or_store_or_drop(new path (H), slot_l_store)

/decl/hierarchy/outfit/job/civ/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	uniform = /obj/item/clothing/under/rank/janitor
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/card/id/sciencelvl1
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/civ/chef
	name = OUTFIT_JOB_NAME("Chef")
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/white
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/card/id/chef
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/civ/bartender
	name = OUTFIT_JOB_NAME("Bartender")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/card/id/bartender
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/civ/archivist
	name = OUTFIT_JOB_NAME("Archivist")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/card/id/archivist
	l_ear = /obj/item/device/radio/headset/headset_arch

/decl/hierarchy/outfit/job/civ/gocrep
	name = OUTFIT_JOB_NAME("Global Occult Coalition Representative")
	uniform = /obj/item/clothing/under/rank/head_of_security/navyblue
	suit = /obj/item/clothing/suit/security/navyhos
	head = /obj/item/clothing/head/beret/scp/goc
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/thick/combat
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/card/id/adminlvl3
	l_ear = /obj/item/device/radio/headset/heads/goc
	backpack_contents = list(/obj/item/ammo_magazine/scp/usp45 = 1)
	belt = /obj/item/gun/projectile/pistol/usp45

/decl/hierarchy/outfit/job/civ/uiu
	name = OUTFIT_JOB_NAME("Unusual Incidents Unit Relations Agent")
	uniform = /obj/item/clothing/under/suit_jacket/charcoal
	shoes = /obj/item/clothing/shoes/dress
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/thick/combat
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/card/id/adminlvl3
	l_ear = /obj/item/device/radio/headset/heads/uiu
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)
	belt = /obj/item/gun/projectile/pistol/m1911

/decl/hierarchy/outfit/job/civ/thirep
	name = OUTFIT_JOB_NAME("thirep")
	uniform = /obj/item/clothing/under/rank/chaplain
	l_hand = /obj/item/storage/bible
	id_type = /obj/item/card/id/adminlvl3
	pda_type = /obj/item/modular_computer/pda/medical
	l_ear = /obj/item/device/radio/headset/heads/thi
	belt = /obj/item/gun/projectile/pistol/m1911
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)

/decl/hierarchy/outfit/job/civ/MCDRep
	name = OUTFIT_JOB_NAME("Marshall, Carter, and Dark Corporate Liaison")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	glasses = /obj/item/clothing/glasses/monocle
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/card/id/adminlvl3
	r_hand = /obj/item/storage/secure/briefcase/money
	l_hand = /obj/item/cane
	l_ear = /obj/item/device/radio/headset/heads/mcd
	backpack_contents = list(/obj/item/ammo_magazine/c45m = 1)
	belt = /obj/item/gun/projectile/silenced

/decl/hierarchy/outfit/job/civ/o5rep
	name = OUTFIT_JOB_NAME("O5 Representative")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/card/id/adminlvl5
	l_ear = /obj/item/device/radio/headset/heads/hop
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)
	belt = /obj/item/gun/projectile/pistol/m1911

/decl/hierarchy/outfit/job/civ/tribunal
	name = OUTFIT_JOB_NAME("Tribunal Officer")
	uniform = /obj/item/clothing/under/lawyer/black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/card/id/adminlvl5
	l_ear = /obj/item/device/radio/headset/heads/hop
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)
	belt = /obj/item/gun/projectile/pistol/m1911

/decl/hierarchy/outfit/job/chaplain
	name = OUTFIT_JOB_NAME("Chaplain")
	uniform = /obj/item/clothing/under/rank/chaplain
	l_hand = /obj/item/storage/bible
	id_type = /obj/item/card/id/civilian/chaplain
	pda_type = /obj/item/modular_computer/pda/medical

/decl/hierarchy/outfit/job/civ/officeworker
	name = OUTFIT_JOB_NAME("Office Worker")
	uniform = /obj/item/clothing/under/scp/suittie
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/card/id/officeworker
	backpack_contents = list(/obj/item/paper_bin = 1,/obj/item/device/radio =1,/obj/item/pen = 1)
	l_ear = /obj/item/device/radio/headset/headset_service
	r_ear = /obj/item/pen
	l_pocket = /obj/item/material/clipboard
	r_pocket = /obj/item/folder
	l_hand = null
	r_hand = null
