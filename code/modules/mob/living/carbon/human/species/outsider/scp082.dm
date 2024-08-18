/datum/species/scp082
	name = "SCP-082"
	name_plural = "SCP-082s"

	has_organ = list()

	spawn_flags = SPECIES_IS_RESTRICTED
	species_flags = SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_MINOR_CUT
	total_health = 2000
	blood_volume = 1500
	genders = list(MALE)

	hud_type = /datum/hud_data/scp082

	// Far more reinforced limbs
	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest/scp082),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin/scp082),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/scp082),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm/scp082),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/scp082),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/scp082),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/scp082),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/scp082),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/scp082),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/scp082),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/scp082),
	)

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_STOMACH =  /obj/item/organ/internal/stomach,
		BP_LUNGS =    /obj/item/organ/internal/lungs,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain/scp082,
		BP_APPENDIX = /obj/item/organ/internal/appendix,
		BP_EYES =     /obj/item/organ/internal/eyes
	)

/datum/species/scp082/handle_npc(mob/living/carbon/human/scp082/target)
	if(!target?.client)
		return

	if(prob(25))
		target.Move(get_dir(target, step_rand(target)))
