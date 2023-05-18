/decl/hierarchy/outfit/job/medical/New()
	..()
	BACKPACK_OVERRIDE_MEDICAL

/decl/hierarchy/outfit/job/medical/chemist/New()
	..()
	BACKPACK_OVERRIDE_CHEMISTRY

/decl/hierarchy/outfit/job/command/cmo
	name = OUTFIT_JOB_NAME("Chief Medical Officer")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/purple
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	id_type = /obj/item/card/id/chiefmedicalofficer
	l_pocket = /obj/item/device/radio
	r_pocket = /obj/item/device/flashlight/pen
	l_ear = /obj/item/device/radio/headset/heads/cmo

/decl/hierarchy/outfit/job/medical/psychiatrist
	name = OUTFIT_JOB_NAME("Psychiatrist")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/card/id/psychiatrist
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med

/decl/hierarchy/outfit/job/medical/chemist
	name = OUTFIT_JOB_NAME("Chemist")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/navyblue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/card/id/chemist
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med

/decl/hierarchy/outfit/job/medical/medicaldoctor
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/card/id/doctor
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med

/decl/hierarchy/outfit/job/medical/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/green
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/card/id/doctor
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med

/decl/hierarchy/outfit/job/medical/emt
	name = OUTFIT_JOB_NAME("Emergency Medical Technician")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/black
	shoes = /obj/item/clothing/shoes/white
	id_type = /obj/item/card/id/emt
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
