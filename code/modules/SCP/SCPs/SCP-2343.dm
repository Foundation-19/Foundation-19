/mob/living/carbon/human/scp343/scp2343
	name = "strange american man"
	desc = "A brusk and wiley man of american decent."
	icon = 'icons/SCP/scp_2343.dmi'
	icon_state = "americangod"
	status_flags = NO_ANTAG
	var/spawn_area

	roundstart_traits = list(TRAIT_ADVANCED_TOOL_USER)

/mob/living/carbon/human/scp343/scp2343/Initialize(mapload, new_species = "SCP-2343")
	. = ..()
	SCP = new /datum/scp(
		src,
		"strange american man",
		SCP_SAFE,
		"2343",
		SCP_PLAYABLE|SCP_ROLEPLAY
	)
	spawn_area = get_area(src)
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_CONTAINED)

/mob/living/carbon/human/scp343/scp2343/Life()
	. = ..()
	if(!.)
		return
	check_containment_status()

/mob/living/carbon/human/scp343/scp2343/proc/check_containment_status()
	if(!SCP || !SCP.research)
		return
	var/area/current = get_area(src)
	var/in_containment = (current == spawn_area)
	if(in_containment && SCP.research.containment_status == SCP_BREACHED)
		SCP.research.set_containment_status(SCP_CONTAINED)
	else if(!in_containment && SCP.research.containment_status != SCP_BREACHED)
		SCP.research.set_containment_status(SCP_BREACHED)
