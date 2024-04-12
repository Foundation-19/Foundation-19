/mob/living/carbon/human/scp2020
	name = "Green humanoid"
	desc = "A strange Green humanoid"

	status_flags = NO_ANTAG

/mob/living/carbon/human/scp2020/Initialize(mapload, new_species = "SCP-2020")
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"Artie", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"2020", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 1 MINUTES
	SCP.min_playercount = 0

	init_skills()

	var/decl/hierarchy/outfit/scp2020/outfit = outfit_by_type(/decl/hierarchy/outfit/scp2020)
	outfit.equip(src)

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
