/obj/item/clothing/mask/smokable/cigarette/scp_420_j
	name = "<i>radical blunt</i>"
	desc = "<i>Totally radical blunt, dude</i>"

	icon_state = "420off"
	item_state = "420off"
	icon_on = "420on"

	brand = "\improper Radical SCP Foundation"

	chem_volume = 100
	smoketime = INFINITY
	filling = list()

/obj/item/clothing/mask/smokable/cigarette/scp_420_j/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"<i>radical blunt</i>", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SAFE, //Obj Class
		"420-j" //Numerical Designation
	)

/obj/item/clothing/mask/smokable/cigarette/scp_420_j/Process()
	. = ..()
	if(!reagents.has_reagent(/datum/reagent/space_drugs))
		reagents.add_reagent(/datum/reagent/space_drugs, 10) // Totally never runs out of snoop!
//	if(!reagents.has_reagent(/datum/reagent/nicotine))
//		reagents.add_reagent(/datum/reagent/nicotine, 10)
