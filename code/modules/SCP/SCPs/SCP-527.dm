/mob/living/carbon/human/scp527
	name = "Mr.Fish"
	desc = "A strange fish like man"

	status_flags = NO_ANTAG

/mob/living/carbon/human/scp527/Initialize(mapload, new_species = "SCP-527")
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"Mr.Fish", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"527", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 15 MINUTES
	SCP.min_playercount = 5

	init_skills()

	var/decl/hierarchy/outfit/scp527/outfit = outfit_by_type(/decl/hierarchy/outfit/scp527)
	outfit.equip(src)

/mob/living/carbon/human/scp527/proc/init_skills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/S in GLOB.skills)
		skillset.skill_list[S.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_FINANCE] = SKILL_TRAINED
	skillset.skill_list[SKILL_COMPUTER] = SKILL_TRAINED
	skillset.skill_list[SKILL_HAULING] = SKILL_TRAINED
	skillset.skill_list[SKILL_COOKING] = SKILL_TRAINED
	skillset.on_levels_change()

/mob/living/carbon/human/scp527/Login()
	. = ..()
	if(client)
		add_language(LANGUAGE_ENGLISH)
		add_language(LANGUAGE_HUMAN_FRENCH)
