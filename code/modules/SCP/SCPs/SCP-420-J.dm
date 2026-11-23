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
	hidden_from_codex = TRUE

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
		src,
		"radical blunt",
		SCP_SAFE,
		"420-J",
	)
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_CONTAINED)

/obj/item/clothing/mask/smokable/cigarette/scp420J/forceMove(atom/dest)
	var/atom/old_loc = loc
	. = ..()
	if(old_loc && istype(old_loc, /obj/structure/scp_containment_safe) && !(istype(loc, /obj/structure/scp_containment_safe)))
		if(SCP && SCP.research)
			SCP.research.set_containment_status(SCP_BREACHED)
	else if(istype(loc, /obj/structure/scp_containment_safe) && SCP && SCP.research)
		SCP.research.set_containment_status(SCP_CONTAINED)

/obj/item/clothing/mask/smokable/cigarette/scp420J/Process()
	. = ..()
	for(var/reagent_type in refill_reagents)
		if(!reagents.has_reagent(reagent_type))
			reagents.add_reagent(reagent_type, 10) // Totally never runs out of snoop!

// Fine - Adds random drug to the refill list
// Very Fine - Deletes itself and gives everyone in a large area the reagents from refill list and plays funny music
/obj/item/clothing/mask/smokable/cigarette/scp420J/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_FINE)
			var/list/available_reagents = potential_refill_reagents - refill_reagents
			if(LAZYLEN(available_reagents))
				refill_reagents |= pick(available_reagents)
				switch(length(refill_reagents))
					if(2)
						color = "#d1ffd1"
						desc = "<i>Absolutely radical blunt, dude</i>"
					if(3)
						color = "#bfffbf"
						desc = "<i><b>Absolutely radical blunt, dude</b></i>"
					if(4)
						color = "#88fc88"
						desc = "<i><b><u>Absolutely radical blunt, dude</u></b></i>"
					if(5 to INFINITY)
						color = "#51fc51"
						desc = SPAN_GOOD("<i><b><u>Absolutelly f$*#ing radical blunt, dude</u></b></i>")
			return src
		if(MODE_VERY_FINE)
			log_and_message_admins("put [src] through SCP-914 on \"Very Fine\" mode.", user, src)
			for(var/mob/living/carbon/human/H in range(32, src))
				for(var/reagent_type in refill_reagents)
					H.reagents.add_reagent(reagent_type, 5)
				to_chat(H, SPAN_GOOD("<i>Holy shit, dude</i>"))
				H.playsound_local(get_turf(H), 'sounds/music/420J.ogg', 50, FALSE)
				flash_color(H, flash_color = "#bfffbf", flash_time = 100)
			return null
	return ..()
