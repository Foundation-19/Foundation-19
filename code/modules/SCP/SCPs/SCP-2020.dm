/mob/living/carbon/human/scp2020
	name = "Green humanoid"
	desc = "A strange Green humanoid"

	status_flags = NO_ANTAG
	var/spawn_area

/mob/living/carbon/human/scp2020/Initialize(mapload, new_species = "SCP-2020")
	. = ..()
	SCP = new /datum/scp(
		src,
		"Artie",
		SCP_EUCLID,
		"2020",
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 1 MINUTES
	SCP.min_playercount = 0
	spawn_area = get_area(src)
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_CONTAINED)

	init_skills()

	var/decl/hierarchy/outfit/scp2020/outfit = outfit_by_type(/decl/hierarchy/outfit/scp2020)
	outfit.equip(src)

/mob/living/carbon/human/scp2020/Life()
	. = ..()
	if(!.)
		return
	check_containment_status()

/mob/living/carbon/human/scp2020/proc/check_containment_status()
	if(!SCP || !SCP.research)
		return
	var/area/current = get_area(src)
	var/in_containment = (current == spawn_area)
	if(in_containment && SCP.research.containment_status == SCP_BREACHED)
		SCP.research.set_containment_status(SCP_CONTAINED)
	else if(!in_containment && SCP.research.containment_status != SCP_BREACHED)
		SCP.research.set_containment_status(SCP_BREACHED)

/mob/living/carbon/human/scp2020/proc/init_skills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/S in GLOB.skills)
		skillset.skill_list[S.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_COMPUTER] = SKILL_TRAINED
	skillset.skill_list[SKILL_ELECTRICAL] = SKILL_TRAINED
	skillset.skill_list[SKILL_DEVICES] = SKILL_TRAINED
	skillset.skill_list[SKILL_ATMOS] = SKILL_TRAINED
	skillset.on_levels_change()

/mob/living/carbon/human/scp2020/Login()
	. = ..()
	if(client)
		add_language(LANGUAGE_ENGLISH)
