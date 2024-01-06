/obj/item/reagent_containers/pill/scp500
	name = "red pill"
	desc = "A strange red pill."
	icon_state = "pill9"

/obj/item/reagent_containers/pill/scp500/New()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"red pill", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"500" //Numerical Designation
	)

	reagents.add_reagent(/datum/reagent/scp500, 1)

/datum/reagent/scp500
	name = "SCP-500"
	description = "A strange liquid obtained from inside the pills of SCP-500."
	taste_description = "vanilla"
	reagent_state = LIQUID
	color = "#f3eaf8"
	flags = AFFECTS_DEAD //This can even heal dead people.

	glass_name = "SCP-500"
	glass_desc = "A strange ethereal like liquid"

/datum/reagent/scp500/affect_blood(mob/living/carbon/M, alien, removed)
	//TODO: Implement proper effects (reverting 008 or 049 infection, clearing stage handlers, reseting to origin species)
	if(M.chem_doses[type] >= 1)
		M.rejuvenate()
		remove_self(volume)

/obj/item/storage/pill_bottle/scp500
	name = "pill bottle (SCP-500)"
	desc = "This Pill Bottle has \'SCP-500\' written on its label. The label also notes, \'Storage of more than 10 instances of SCP-500 is limited to secure Sites only. Contact a RAISA official for more details.\'."
	max_storage_space = 10 // gotta store those pills

	startswith = list(
		/obj/item/reagent_containers/pill/scp500 = 10
	)
