/obj/item/clothing/mask/smokable/cigarette/scp420J
	name = "<i>radical blunt</i>"
	desc = "<i>Totally radical blunt, dude</i>"

	icon_state = "420off"
	item_state = "420off"
	icon_on = "420on"

	brand = "\improper Radical SCP Foundation"

	chem_volume = 200
	smoketime = INFINITY
	filling = list()

	//Config

	var/list/refill_reagents = list(/datum/reagent/space_drugs)
	var/list/potential_refill_reagents = list(
		/datum/reagent/space_drugs,
		/datum/reagent/mindbreaker_toxin,
		/datum/reagent/serotrotium,
		/datum/reagent/psilocybin,
		/datum/reagent/cryptobiolin,
		)

/obj/item/clothing/mask/smokable/cigarette/scp420J/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"<i>radical blunt</i>", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SAFE, //Obj Class
		"420-J" //Numerical Designation
	)

/obj/item/clothing/mask/smokable/cigarette/scp420J/Process()
	. = ..()
	for(var/reagent_type in refill_reagents)
		if(!reagents.has_reagent(reagent_type))
			reagents.add_reagent(reagent_type, 10) // Totally never runs out of snoop!
