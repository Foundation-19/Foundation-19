/datum/species/966
	name = "SCP-966"
	name_plural = "SCP-966s"
	icobase = 'icons/mob/simple_animal/animal.dmi'
	icon_state = "forgotten"
  
  darksight = 8
	has_organ = list()
	siemens_coefficient = 0
  invisibility = INVISIBILITY_HUNTER

	blood_color = "#622a37"
	flesh_color = "#442A37"

	species_flags = SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_POISON
	spawn_flags = SPECIES_IS_RESTRICTED
	language = LANGUAGE_UNATHI_YEOSA 
	genders = list(MALE)
  unarmed_types = list(/datum/unarmed_attack/claws, /datum/unarmed_attack/bite/strong)
  
  brute_mod =      2           //They're physically fragile
  
  // AI movement
/datum/species/scp966/handle_npc(var/mob/living/carbon/human/scp966/H)
	// sanity check, apparently its needed
	if (!H || H.client)
		return
	// walk around randomly if we don't have a target
	if (!H.pursueTarget())
		var/turf/T = step_rand(H)
		H.Move(get_dir(H, T))

	if (prob(25))
		var/turf/T = step_rand(H)
		H.Move(get_dir(H, T))
