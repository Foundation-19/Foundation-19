/datum/species/scp049
	name = "SCP-049"
	name_plural = "SCP-049s"
	icon_template = 'icons/SCP/scp-049.dmi'
	has_organ = list()
	siemens_coefficient = 0
	species_flags = SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_POISON | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NO_TANGLE | SPECIES_FLAG_NO_PAIN
	show_ssd = null
	show_coma = null
	blood_color = "#622a37"
	flesh_color = "#442A37"

	spawn_flags = SPECIES_IS_RESTRICTED

	genders = list(MALE)

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

/datum/species/scp049/handle_vision(var/mob/living/carbon/human/scp049/H)
	var/list/vision = H.get_accumulated_vision_handlers()
	H.update_sight()
	H.set_sight(H.sight|get_vision_flags(H)|H.equipment_vision_flags|vision[1])
	H.change_light_colour(H.getDarkvisionTint())

/datum/species/scp049/handle_post_spawn(mob/living/carbon/human/H)
	. = ..()
	H.mind_initialize()
	var/datum/spell/spl = new /datum/spell/targeted/curepestillence
	H.add_spell(spl)
	//mind.learned_spells += spl
	spl = new /datum/spell/aimed/stopheart
	H.add_spell(spl)
	H.add_language(LANGUAGE_ENGLISH, TRUE)
	H.add_language(LANGUAGE_HUMAN_FRENCH, TRUE)
	H.add_language(LANGUAGE_HUMAN_GERMAN, TRUE)
	H.add_language(LANGUAGE_HUMAN_SPANISH, TRUE)
	H.update_languages()
	H.set_default_language(all_languages[LANGUAGE_ENGLISH])
	//mind.learned_spells += spl
