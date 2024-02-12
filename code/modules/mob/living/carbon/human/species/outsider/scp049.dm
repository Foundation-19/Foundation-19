/datum/species/scp049
	name = "SCP-049"
	name_plural = "SCP-049s"
	icon_template = 'icons/SCP/scp-049.dmi'
	has_organ = list()
	siemens_coefficient = 0
	species_flags = SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_POISON | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NO_TANGLE | SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_MINOR_CUT | SPECIES_FLAG_NO_DISEASE
	show_ssd = null
	show_coma = null
	blood_color = "#622a37"
	flesh_color = "#442A37"

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


/datum/species/scp049/handle_vision(mob/living/carbon/human/scp049/H)
	var/list/vision = H.get_accumulated_vision_handlers()
	H.update_sight()
	H.set_sight(H.sight|get_vision_flags(H)|H.equipment_vision_flags|vision[1])
	H.change_light_colour(H.getDarkvisionTint())

/datum/species/scp049/attempt_grab(mob/living/carbon/human/user, mob/living/target)
	return ..(user, target, GRAB_PLAGUE_DOCTOR)
