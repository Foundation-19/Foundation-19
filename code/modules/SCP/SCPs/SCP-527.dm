/mob/living/carbon/human/scp_527
	SCP = /datum/scp/scp_527
	status_flags = NO_ANTAG

/datum/scp/scp_527
	name = "SCP-527"
	designation = "527"
	classification = EUCLID

/mob/living/carbon/human/scp_527/New(new_loc, new_species)
	new_species = "SCP-527"
	return ..()

/mob/living/carbon/human/scp_527/Initialize()
	fully_replace_character_name("Mr. Fish")
	. = ..()

	init_skills()

	var/decl/hierarchy/outfit/scp_527/outfit = new /decl/hierarchy/outfit/scp_527
	outfit.equip(src)

/mob/living/carbon/human/scp_527/proc/init_skills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/S in GLOB.skills)
		skillset.skill_list[S.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_FINANCE] = SKILL_TRAINED
	skillset.skill_list[SKILL_COMPUTER] = SKILL_TRAINED
	skillset.skill_list[SKILL_HAULING] = SKILL_TRAINED
	skillset.skill_list[SKILL_COOKING] = SKILL_TRAINED
	skillset.skill_list[SKILL_BOTANY] = SKILL_EXPERIENCED
	skillset.on_levels_change()

/mob/living/carbon/human/scp_527/Login()
	. = ..()
	if(client)
		add_language(LANGUAGE_ENGLISH)
		add_language(LANGUAGE_HUMAN_FRENCH)
