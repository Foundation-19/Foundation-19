/datum/species/scp049
	name = "SCP-049"
	name_plural = "SCP-049s"

//	darksight = 8
	has_organ = list()
	siemens_coefficient = 0

	blood_color = "#622a37"
	flesh_color = "#442A37"

	species_flags = SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_POISON | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NO_TANGLE | SPECIES_FLAG_NO_PAIN
	spawn_flags = SPECIES_IS_RESTRICTED

	genders = list(MALE)

	// immune to viruses
//	virus_immune = TRUE

	// icon overrides
	icobase = null
	deform = null

	// damage icon overrides
	damage_overlays = null
	damage_mask = null
	blood_mask = null

	// damage overrides
	brute_mod =      0.5                    // 50% physical damage
	burn_mod =       0.5                    // 50% burn damage
	oxy_mod =        0.0                    // No oxygen damage
	toxins_mod =     0.0                    // No toxin damage
	radiation_mod =  0.0                    // No radiation damage
	flash_mod =      0.0                    // Unflashable

	hud_type = /datum/hud_data/scp049

// #define AI_049
/datum/species/scp049/handle_npc(var/mob/living/carbon/human/scp049/H)
	// sanity check, apparently its needed
	if (!H || H.client)
		return
	// walk around randomly if we don't have a target
	#ifdef AI_049
	if (!H.pursueTarget())
		var/turf/T = step_rand(H)
		H.Move(get_dir(H, T))
	#else
	if (prob(25))
		var/turf/T = step_rand(H)
		H.Move(get_dir(H, T))
	#endif
