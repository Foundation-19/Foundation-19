/mob/living/carbon/human/scp912
	name = "mysterious SWAT armor"
	desc = "A set of sentient SWAT armor, usually known to be local Special Weapons and Tactics standard-issue equipment, if a little outdated. They don't seem to respond when talked to, and only acknowledge those who are dressed as local police officers."

	status_flags = NO_ANTAG

	var/spawn_area
	var/crime_detection_range = 10
	var/last_containment_alert = 0
	var/containment_alert_cooldown = 60 SECONDS

/mob/living/carbon/human/scp912/Initialize(mapload, new_species = "SCP-912")
	. = ..()
	SCP = new /datum/scp(
		src,
		"SCP-912",
		SCP_SAFE,
		"912",
		SCP_ROLEPLAY
	)

	init_skills()

	var/decl/hierarchy/outfit/scp912/outfit = outfit_by_type(/decl/hierarchy/outfit/scp912)
	outfit.equip(src)
	spawn_area = get_area(src)

/mob/living/carbon/human/scp912/Life()
	. = ..()
	if(spawn_area)
		var/area/current = get_area(src)
		if(current != spawn_area && SCP && SCP.research && SCP.research.containment_status != SCP_BREACHED)
			SCP.research.set_containment_status(SCP_BREACHED)
			if(world.time > last_containment_alert + containment_alert_cooldown)
				last_containment_alert = world.time
				for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
					var/datum/job/job = SSjobs.get_by_title(H.job)
					if(job && (job.department_flag & (COM|SCI|SEC)))
						to_chat(H, SPAN_WARNING("<b>ALERT:</b> SCP-912 has left its containment area. It may be responding to perceived criminal activity."))
		else if(current == spawn_area && SCP && SCP.research && SCP.research.containment_status == SCP_BREACHED)
			SCP.research.set_containment_status(SCP_CONTAINED)

/mob/living/carbon/human/scp912/proc/init_skills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/S in GLOB.skills)
		skillset.skill_list[S.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_COMBAT] = SKILL_MASTER
	skillset.skill_list[SKILL_WEAPONS] = SKILL_MASTER
	skillset.skill_list[SKILL_FORENSICS] = SKILL_TRAINED
	skillset.skill_list[SKILL_HAULING] = SKILL_TRAINED
	skillset.on_levels_change()

/mob/living/carbon/human/scp912/Login()
	. = ..()
	if(client)
		add_language(LANGUAGE_ENGLISH)
