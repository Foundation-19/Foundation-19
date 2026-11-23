/mob/living/carbon/human/scp347
	name = "Claude Rains"
	desc = "A strange invisible woman"

	status_flags = NO_ANTAG

	var/contentment = 100
	var/contentment_decay_rate = 0.05
	var/contentment_warning_given = FALSE
	var/spawn_area
	var/obj/effect/client_image_holder/thermal_shimmer

/mob/living/carbon/human/scp347/Initialize(mapload, new_species = "SCP-347")
	. = ..()
	SCP = new /datum/scp(
		src,
		"Claude Rains",
		SCP_EUCLID,
		"347",
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 15 MINUTES
	SCP.min_playercount = 5

	init_skills()

	var/decl/hierarchy/outfit/scp347/outfit = outfit_by_type(/decl/hierarchy/outfit/scp347)
	outfit.equip(src)
	spawn_area = get_area(src)

/mob/living/carbon/human/scp347/Life()
	. = ..()
	contentment -= contentment_decay_rate
	contentment = max(0, contentment)
	if(contentment < 30 && !contentment_warning_given)
		contentment_warning_given = TRUE
		to_chat(src, SPAN_WARNING("You're getting restless... Maybe you should find someone to talk to, or sneak out for a while."))
	else if(contentment > 50)
		contentment_warning_given = FALSE
	if(contentment <= 0 && spawn_area)
		var/area/current = get_area(src)
		if(current == spawn_area)
			if(prob(2))
				to_chat(src, SPAN_DANGER("You can't take this isolation anymore! Time to leave!"))
	check_containment_status()
	update_thermal_shimmer()

// Thermal goggles reveal a faint body-heat silhouette (T2 countermeasure for SCP-347).
/mob/living/carbon/human/scp347/proc/update_thermal_shimmer()
	var/seers = list()
	for(var/mob/living/carbon/human/H in view(7, src))
		if(H == src || !H.client)
			continue
		if(istype(H.glasses, /obj/item/clothing/glasses/scp_thermal))
			seers += H
	if(length(seers))
		QDEL_NULL(thermal_shimmer)
		thermal_shimmer = new(null, seers)
		thermal_shimmer.image_icon = 'icons/SCP/scp347/scp-347-eyes.dmi'
		thermal_shimmer.image_color = "#ff6a4a"
		thermal_shimmer.loc = get_turf(src)
		thermal_shimmer.shown_image = thermal_shimmer.generate_image()
		thermal_shimmer.shown_image.alpha = 90
		for(var/mob/seer in seers)
			thermal_shimmer.show_image_to(seer)
	else if(thermal_shimmer)
		QDEL_NULL(thermal_shimmer)

/mob/living/carbon/human/scp347/proc/check_containment_status()
	if(!SCP || !SCP.research)
		return
	if(!spawn_area)
		return
	var/area/current = get_area(src)
	var/in_containment = (current == spawn_area)
	if(in_containment && SCP.research.containment_status == SCP_BREACHED)
		SCP.research.set_containment_status(SCP_CONTAINED)
	else if(!in_containment && SCP.research.containment_status != SCP_BREACHED)
		SCP.research.set_containment_status(SCP_BREACHED)

/mob/living/carbon/human/scp347/hear_say(message, verb = "says", datum/language/language = null, alt_name = "", italics = 0, mob/speaker = null)
	. = ..()
	if(speaker && speaker != src)
		contentment = min(100, contentment + 2)

/mob/living/carbon/human/scp347/attack_hand(mob/M)
	. = ..()
	if(M != src && ishuman(M))
		contentment = min(100, contentment + 5)

/mob/living/carbon/human/scp347/proc/init_skills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/S in GLOB.skills)
		skillset.skill_list[S.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_FINANCE] = SKILL_TRAINED
	skillset.skill_list[SKILL_ELECTRICAL] = SKILL_MASTER
	skillset.skill_list[SKILL_HAULING] = SKILL_TRAINED
	skillset.skill_list[SKILL_COOKING] = SKILL_TRAINED
	skillset.on_levels_change()

/mob/living/carbon/human/scp347/Login()
	. = ..()
	if(client)
		add_language(LANGUAGE_ENGLISH)
