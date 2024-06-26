/obj/structure/closet/crate/med_crate
	name = "\improper medical crate"
	desc = "A medical gear crate."
	icon_state = "medicalcrate"
	icon_opened = "medicalcrateopen"
	icon_closed = "medicalcrate"

/obj/structure/closet/crate/med_crate/trauma
	name = "\improper Trauma crate"
	desc = "A crate with trauma equipment."

/obj/structure/closet/crate/med_crate/trauma/WillContain()
	return list(
		/obj/item/stack/medical/splint = 2,
		/obj/item/stack/medical/advanced/bruise_pack = 10,
		/obj/item/reagent_containers/pill/sugariron = 6,
		/obj/item/storage/pill_bottle/paracetamol = 2,
		/obj/item/storage/pill_bottle/inaprovaline
		)

/obj/structure/closet/crate/med_crate/burn
	name = "\improper Burn crate"
	desc = "A crate with burn equipment."

/obj/structure/closet/crate/med_crate/burn/WillContain()
	return list(
		/obj/item/defibrillator/loaded,
		/obj/item/stack/medical/advanced/ointment = 10,
		/obj/item/storage/pill_bottle/kelotane,
		/obj/item/storage/pill_bottle/tramadol = 2,
		/obj/item/storage/pill_bottle/penicillin
	)

/obj/structure/closet/crate/med_crate/oxyloss
	name = "\improper Low oxygen crate"
	desc = "A crate with low oxygen equipment."

/obj/structure/closet/crate/med_crate/oxyloss/WillContain()
	return list(
		/obj/item/device/scanner/health = 2,
		/obj/item/storage/pill_bottle/dexalin = 2,
		/obj/item/storage/pill_bottle/inaprovaline
	)
/obj/structure/closet/crate/med_crate/toxin
	name = "\improper Toxin crate"
	desc = "A crate with toxin equipment."

/obj/structure/closet/crate/med_crate/toxin/WillContain()
	return list(
		/obj/item/storage/firstaid/surgery,
		/obj/item/storage/pill_bottle/dylovene = 2,
		/obj/item/reagent_containers/pill/hyronalin = 12
			)
