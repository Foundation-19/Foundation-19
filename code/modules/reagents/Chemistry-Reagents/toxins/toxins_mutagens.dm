// A mutagen is any chemical that causes heavy changes in a victim's body, whether it be mutations, limb/organ changes, or even species or mob updates.

/datum/reagent/unstable_mutagen
	name = "Unstable Mutagen"
	description = "Might cause unpredictable mutations. Keep away from children."
	taste_description = "slime"
	taste_mult = 0.9
	reagent_state = LIQUID
	color = "#13bc5e"
	value = 3.1

/datum/reagent/unstable_mutagen/affect_touch(mob/living/carbon/M, alien, removed)
	if (prob(33))
		affect_blood(M, alien, removed)

/datum/reagent/unstable_mutagen/affect_ingest(mob/living/carbon/M, alien, removed)
	if (prob(67))
		affect_blood(M, alien, removed)

/datum/reagent/unstable_mutagen/affect_blood(mob/living/carbon/M, alien, removed)

	if (M.isSynthetic())
		return

	var/mob/living/carbon/human/H = M
	if (istype(H) && (H.species.species_flags & SPECIES_FLAG_NO_SCAN))
		return

	if (M.dna)
		if (prob(removed * 0.1)) // Approx. one mutation per 10 injected/20 ingested/30 touching units
			randmuti(M)
			if (prob(98))
				randmutb(M)
			else
				randmutg(M)
			domutcheck(M, null)
			M.UpdateAppearance()
	M.apply_damage(10 * removed, IRRADIATE, armor_pen = 100)



/datum/reagent/mutation_toxin
	name = "Mutation Toxin"
	description = "A corruptive toxin produced by slimes."
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#13bc5e"
	metabolism = REM * 0.2
	value = 2
	should_admin_log = TRUE

/datum/reagent/mutation_toxin/affect_blood(mob/living/carbon/human/H, alien, removed)
	if (!istype(H))
		return
	if (H.species.name == SPECIES_PROMETHEAN)
		return
	H.adjustToxLoss(40 * removed)
	if (H.chem_doses[type] < 1 || prob(30))
		return
	H.chem_doses[type] = 0
	var/list/meatchunks = list()
	for(var/limb_tag in list(BP_R_ARM, BP_L_ARM, BP_R_LEG,BP_L_LEG))
		var/obj/item/organ/external/E = H.get_organ(limb_tag)
		if (E && !E.is_stump() && !BP_IS_ROBOTIC(E) && E.species.name != SPECIES_PROMETHEAN)
			meatchunks += E
	if (!meatchunks.len)
		if (prob(10))
			to_chat(H, SPAN_DANGER("Your flesh rapidly mutates!"))
			H.set_species(SPECIES_PROMETHEAN)
			H.shapeshifter_set_colour("#05ff9b")
			remove_verb(H, /mob/living/carbon/human/proc/shapeshifter_select_colour)
		return
	var/obj/item/organ/external/O = pick(meatchunks)
	to_chat(H, SPAN_DANGER("Your [O.name]'s flesh mutates rapidly!"))
	if (!wrapped_species_by_ref["\ref[H]"])
		wrapped_species_by_ref["\ref[H]"] = H.species.name
	meatchunks = list(O) | O.children
	for(var/obj/item/organ/external/E in meatchunks)
		E.species = all_species[SPECIES_PROMETHEAN]
		E.s_tone = null
		E.s_col = ReadRGB("#05ff9b")
		E.s_col_blend = ICON_ADD
		E.status &= ~ORGAN_BROKEN
		E.status |= ORGAN_MUTATED
		E.limb_flags &= ~ORGAN_FLAG_CAN_BREAK
		E.dislocated = -1
		E.max_damage = 5
		E.update_icon(1)
	O.max_damage = 15
	if (prob(10))
		to_chat(H, SPAN_DANGER("Your slimy [O.name] plops off!"))
		O.droplimb()
	H.update_body()



/datum/reagent/advanced_mutation_toxin
	name = "Advanced Mutation Toxin"
	description = "An advanced corruptive toxin produced by slimes."
	taste_description = "sludge"
	reagent_state = LIQUID
	color = "#13bc5e"

/datum/reagent/advanced_mutation_toxin/affect_blood(mob/living/carbon/M, alien, removed) // TODO: check if there's similar code anywhere else
	if (HAS_TRANSFORMATION_MOVEMENT_HANDLER(M))
		return
	to_chat(M, SPAN_DANGER("Your flesh rapidly mutates!"))
	ADD_TRANSFORMATION_MOVEMENT_HANDLER(M)
	M.icon = null
	M.cut_overlays()
	M.set_invisibility(101)
	for(var/obj/item/W in M)
		if (istype(W, /obj/item/implant)) //TODO: Carn. give implants a dropped() or something
			qdel(W)
			continue
		M.drop_from_inventory(W)
	var/mob/living/carbon/slime/new_mob = new /mob/living/carbon/slime(M.loc)
	new_mob.a_intent = "hurt"
	new_mob.universal_speak = TRUE
	if (M.mind)
		M.mind.transfer_to(new_mob)
	else
		new_mob.key = M.key
	qdel(M)



/datum/reagent/crystallizing_agent
	name = "Crystallizing Agent"
	description = "A silicon-based mutagen that causes crystallization in organisms that it touches. Beneficial to some biologies."
	taste_description = "sharpness"
	reagent_state = LIQUID
	color = "#13bc5e"
	should_admin_log = TRUE

/datum/reagent/crystallizing_agent/affect_blood(mob/living/carbon/M, alien, removed)
	var/result_mat = (M.psi || (M.mind && GLOB.wizards.is_antagonist(M.mind))) ? MATERIAL_NULLGLASS : MATERIAL_CRYSTAL
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		for(var/obj/item/organ/external/E in shuffle(H.organs.Copy()))
			if (E.is_stump() || BP_IS_ROBOTIC(E))
				continue

			if (BP_IS_CRYSTAL(E))
				if ((E.brute_dam + E.burn_dam) > 0)
					if (prob(35))
						to_chat(M, SPAN_NOTICE("You feel a crawling sensation as fresh crystal grows over your [E.name]."))
					E.heal_damage(rand(5,8), rand(5,8))
					break
				if (BP_IS_BRITTLE(E))
					E.status &= ~ORGAN_BRITTLE
					break
			else if (E.organ_tag != BP_CHEST && E.organ_tag != BP_GROIN && prob(15))
				to_chat(H, SPAN_DANGER("Your [E.name] is being lacerated from within!"))
				if (E.can_feel_pain())
					H.emote("scream")
				if (prob(25))
					for(var/i = 1 to rand(3,5))
						new /obj/item/material/shard(get_turf(E), result_mat)
					E.droplimb(0, DROPLIMB_BLUNT)
				else
					E.take_external_damage(rand(20,30), 0)
					E.status |= ORGAN_CRYSTAL
					E.status |= ORGAN_BRITTLE
				break

		for(var/obj/item/organ/internal/I in shuffle(H.internal_organs.Copy()))
			if (BP_IS_ROBOTIC(I) || !BP_IS_CRYSTAL(I) || I.damage <= 0 || I.organ_tag == BP_BRAIN)
				continue
			if (prob(35))
				to_chat(M, SPAN_NOTICE("You feel a deep, sharp tugging sensation as your [I.name] is mended."))
			I.heal_damage(rand(1,3))
			break
	else
		to_chat(M, SPAN_DANGER("Your flesh is being lacerated from within!"))
		M.adjustBruteLoss(rand(3,6))
		if (prob(10))
			new /obj/item/material/shard(get_turf(M), result_mat)
