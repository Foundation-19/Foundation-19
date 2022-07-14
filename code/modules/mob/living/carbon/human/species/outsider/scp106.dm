/datum/species/scp106
	name = "SCP-106"
	name_plural = "SCP-106s"

//	darksight = 8
	has_organ = list()
	siemens_coefficient = 0

	blood_color = "#622a37"
	flesh_color = "#442A37"

	species_flags = SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_POISON | SPECIES_FLAG_NO_PAIN
	spawn_flags = SPECIES_IS_RESTRICTED

	genders = list(MALE)

	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest/unbreakable/scp106),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin/unbreakable/scp106),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/unbreakable/scp106),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm/unbreakable/scp106),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/unbreakable/scp106),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/unbreakable/scp106),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/unbreakable/scp106),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/unbreakable/scp106),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/unbreakable/scp106),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/unbreakable/scp106),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/unbreakable/scp106)
		)

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

// #define 106AI
/datum/species/scp106/handle_npc(mob/living/carbon/human/scp106/H)
	// sanity check, apparently its needed
	if(!H || H.client)
		return
	// walk around randomly if we don't have a target
	if(!H.pursueTarget())
		var/turf/T = step_rand(H)
		H.Move(get_dir(H, T))

	if(prob(25))
		var/turf/T = step_rand(H)
		H.Move(get_dir(H, T))

/obj/item/organ/external/chest/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = 0

/obj/item/organ/external/groin/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = 0

/obj/item/organ/external/arm/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = 0

/obj/item/organ/external/arm/right/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = 0

/obj/item/organ/external/leg/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = 0

/obj/item/organ/external/leg/right/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = 0

/obj/item/organ/external/foot/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = ORGAN_FLAG_CAN_STAND

/obj/item/organ/external/foot/right/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = 0

/obj/item/organ/external/hand/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags =  ORGAN_FLAG_CAN_GRASP

/obj/item/organ/external/hand/right/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = 0

/obj/item/organ/external/head/unbreakable/scp106
	dislocated = -1
	arterial_bleed_severity = 0
	limb_flags = 0
