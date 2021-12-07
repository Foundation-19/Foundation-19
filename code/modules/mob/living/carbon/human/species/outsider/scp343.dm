/datum/species/scp343
	name = "SCP-343"
	name_plural = "SCP-343s"

//	darksight = 8
	has_organ = list()
	siemens_coefficient = 0

	blood_color = COLOR_BLOOD_HUMAN
	flesh_color = "#ffc896"

	species_flags = SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_POISON | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NO_TANGLE | SPECIES_FLAG_NO_PAIN
	spawn_flags = SPECIES_IS_RESTRICTED

	genders = list(MALE)

	// immune to viruses
//	virus_immune = TRUE

	// icon overrides
	icobase = null
	deform = null

	// damage icon overrides
	damage_overlays = 'icons/mob/human_races/masks/dam_human.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_human.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_human.dmi'

	// damage overrides
	brute_mod =      0.0                    // 50% physical damage
	burn_mod =       0.0                    // 50% burn damage
	oxy_mod =        0.0                    // No oxygen damage
	toxins_mod =     0.0                    // No toxin damage
	radiation_mod =  0.0                    // No radiation damage
	flash_mod =      0.0                    // Unflashable

	hud_type = /datum/hud_data/scp343

// #define 049AI
/datum/species/scp343/handle_npc(var/mob/living/carbon/human/scp343/H)
	// sanity check, apparently its needed
	if (!H || H.client)
		return
	// walk around randomly if we don't have a target

	if (prob(25))
		var/turf/T = step_rand(H)
		H.Move(get_dir(H, T))
