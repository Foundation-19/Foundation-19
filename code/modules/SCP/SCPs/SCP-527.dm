/mob/living/carbon/human/scp527
	name = "Mr.Fish"
	desc = "A strange fish like man"

	status_flags = NO_ANTAG

	var/spawn_area
	var/comfort = 100
	var/comfort_decay_rate = 0.03

/mob/living/carbon/human/scp527/Initialize(mapload, new_species = "SCP-527")
	. = ..()
	SCP = new /datum/scp(
		src,
		"Mr.Fish",
		SCP_SAFE,
		"527",
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 15 MINUTES
	SCP.min_playercount = 5

	init_skills()

	var/decl/hierarchy/outfit/scp527/outfit = outfit_by_type(/decl/hierarchy/outfit/scp527)
	outfit.equip(src)
	spawn_area = get_area(src)

/mob/living/carbon/human/scp527/Life()
	. = ..()
	comfort = max(0, comfort - comfort_decay_rate)
	if(spawn_area)
		var/area/current = get_area(src)
		if(current != spawn_area && SCP && SCP.research && SCP.research.containment_status != SCP_BREACHED)
			SCP.research.set_containment_status(SCP_BREACHED)
		else if(current == spawn_area && SCP && SCP.research && SCP.research.containment_status == SCP_BREACHED)
			SCP.research.set_containment_status(SCP_CONTAINED)

/mob/living/carbon/human/scp527/hear_say(message, verb = "says", datum/language/language = null, alt_name = "", italics = 0, mob/speaker = null)
	. = ..()
	if(speaker && speaker != src)
		comfort = min(100, comfort + 1)

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
