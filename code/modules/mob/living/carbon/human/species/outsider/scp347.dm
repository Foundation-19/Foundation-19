/datum/species/scp347
	name = "SCP-347"
	name_plural = "SCP-347s"
	show_ssd = null
	show_coma = null

	spawn_flags = SPECIES_IS_RESTRICTED

	genders = list(FEMALE)

	//organ override
	override_organ_types = list(BP_EYES = /obj/item/organ/internal/eyes/scp347)

	// icon overrides
	icobase = 'icons/SCP/scp347/scp-347.dmi'
	deform = null

	// damage icon overrides
	damage_overlays = null
	damage_mask = null
	blood_mask = null
