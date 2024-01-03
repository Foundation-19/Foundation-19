GLOBAL_LIST_EMPTY(possible_420j)

/datum/scp/scp_420_j
	name = "SCP-420-J"
	designation = "420-J"
	classification = "Radical"

/obj/item/clothing/mask/smokable/cigarette/scp_420_j
	name = "SCP-420-J"
	desc = "<i>Totally radical blunt, dude</i>"
	smoketime = INFINITY
	icon_state = "420off"
	item_state = "420off"
	icon_on = "420on"
	brand = "\improper Radical SCP Foundation"
	chem_volume = 100
	filling = list()
	SCP = /datum/scp/scp_420_j

/obj/item/clothing/mask/smokable/cigarette/scp_420_j/Process()
	. = ..()
	if(!reagents.has_reagent(/datum/reagent/space_drugs))
		reagents.add_reagent(/datum/reagent/space_drugs, 10) // Totally never runs out of snoop!
//	if(!reagents.has_reagent(/datum/reagent/nicotine))
//		reagents.add_reagent(/datum/reagent/nicotine, 10)
