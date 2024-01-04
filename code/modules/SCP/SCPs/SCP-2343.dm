/mob/living/carbon/human/scp343/scp2343
	name = "strange american man"
	desc = "A brusk and wiley man of american decent."
	icon = 'icons/SCP/scp_2343.dmi'
	icon_state = "americangod"
	status_flags = NO_ANTAG

	roundstart_traits = list(TRAIT_ADVANCED_TOOL_USER)

/mob/living/carbon/human/scp343/scp2343/Initialize(mapload, new_species = "SCP-2343")
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"strange american man", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"2343", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)
