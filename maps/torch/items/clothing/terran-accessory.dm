/************
ranks - TCC
************/

/obj/item/clothing/accessory/terran/rank/navy
	name = "naval ranks"
	desc = "Insignia denoting naval rank of some kind. These appear blank."
	icon = 'maps/torch/icons/obj/obj_accessories_terran.dmi'
	accessory_icons = list(slot_w_uniform_str = 'maps/torch/icons/mob/onmob_accessories_terran.dmi', slot_wear_suit_str = 'maps/torch/icons/mob/onmob_accessories_terran.dmi')
	icon_state = "terranrank"
	on_rolled = list("down" = "none")
	slot = ACCESSORY_SLOT_RANK
	gender = PLURAL
	high_visibility = 1

/obj/item/clothing/accessory/terran/rank/navy/enlisted
	name = "ranks (E-1 crewman recruit)"
	desc = "Insignia denoting the rank of Crewman Recruit."
	icon_state = "terranrank_enlisted"

/obj/item/clothing/accessory/terran/rank/navy/enlisted/e3
	name = "ranks (E-3 crewman)"
	desc = "Insignia denoting the rank of Crewman."

/obj/item/clothing/accessory/terran/rank/navy/enlisted/e4
	name = "ranks (E-4 petty officer second class)"
	desc = "Insignia denoting the rank of Petty Officer Second Class."

/obj/item/clothing/accessory/terran/rank/navy/enlisted/e6
	name = "ranks (E-6 petty officer first class)"
	desc = "Insignia denoting the rank of Petty Officer First Class."

/obj/item/clothing/accessory/terran/rank/navy/enlisted/e7
	name = "ranks (E-7 petty officer first class)"
	desc = "Insignia denoting the rank of Chief Petty Officer."

/obj/item/clothing/accessory/terran/rank/navy/enlisted/e9
	name = "ranks (E-9 senior chief petty officer)"
	desc = "Insignia denoting the rank of Senior Chief Petty Officer."

/obj/item/clothing/accessory/terran/rank/navy/officer
	name = "ranks (O-1 ensign)"
	desc = "Insignia denoting the rank of Ensign."
	icon_state = "terranrank_officer"

/obj/item/clothing/accessory/terran/rank/navy/officer/o2
	name = "ranks (O-2 lieutenant)"
	desc = "Insignia denoting the rank of Lieutenant."

/obj/item/clothing/accessory/terran/rank/navy/officer/o3
	name = "ranks (O-3 senior lieutenant)"
	desc = "Insignia denoting the rank of Senior Lieutenant."

/obj/item/clothing/accessory/terran/rank/navy/officer/o4
	name = "ranks (O-4 corvette commander)"
	desc = "Insignia denoting the rank of Corvette Commander."

/obj/item/clothing/accessory/terran/rank/navy/officer/o5
	name = "ranks (O-5 commander)"
	desc = "Insignia denoting the rank of Commander."

/obj/item/clothing/accessory/terran/rank/navy/officer/o6
	name = "ranks (O-6 captain)"
	desc = "Insignia denoting the rank of Captain."
	icon_state = "terranrank_command"

/obj/item/clothing/accessory/terran/rank/navy/flag
	name = "ranks (O-7 rear admiral)"
	desc = "Insignia denoting the rank of Rear Admiral."
	icon_state = "terranrank_command"

/obj/item/clothing/accessory/terran/rank/navy/flag/o8
	name = "ranks (O-8 vice admiral)"
	desc = "Insignia denoting the rank of Vice Admiral."

/obj/item/clothing/accessory/terran/rank/navy/flag/o9
	name = "ranks (O-9 admiral)"
	desc = "Insignia denoting the rank of Admiral."

/obj/item/clothing/accessory/terran/rank/navy/flag/o10
	name = "ranks (O-10 master admiral of humanity)"
	desc = "Insignia denoting the rank of Master Admiral of Humanity."
