/datum/scp/scp_3349
	name = "SCP-3349"
	designation = "3349"
	classification = KETER

/datum/scp/scp_3349/New(atom/creation)
	. = ..()

	// this is shitcode but if it works, it works
	// group A should be common medicines, group B should be pure minerals
	var/list/groupA = list(
		/datum/reagent/medicine/inaprovaline,
		/datum/reagent/medicine/bicaridine,
		/datum/reagent/medicine/kelotane,
		/datum/reagent/medicine/dylovene,
		/datum/reagent/medicine/dexalin
	)

	var/list/groupB = list(
		/datum/reagent/aluminium,
		/datum/reagent/copper,
		/datum/reagent/iron,
		/datum/reagent/tungsten
	)

	GLOB.scp3349_precedentA = pick_n_take(groupA)
	GLOB.scp3349_precedentB = pick_n_take(groupB)

	GLOB.scp3349_fake_precedentA = pick_n_take(groupA)
	GLOB.scp3349_fake_precedentB = pick_n_take(groupB)

// REAGENT ACTIVATOR

/datum/reagent/scp_3349_activator
	flags = IGNORE_MOB_SIZE
	overdose = 5
	reagent_state = LIQUID
	name = "SCP-3349 Activation mixture"
	description = "A mixture of basic chemicals that causes anomalous effects when applied correctly."
	taste_description = "cat urine"

/datum/reagent/scp_3349_activator/affect_blood(mob/living/carbon/M, alien, removed)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if((H.chem_doses[GLOB.scp3349_precedentA] > 4.8) && (H.chem_doses[GLOB.scp3349_precedentB] > 0.8))
			if(prob(40))
				H.RegisterSignal(H, COMSIG_CARBON_LIFE, /mob/living/carbon/human/proc/handle_3349)

// ACTIVITY

/mob/living/carbon/human/proc/handle_3349()
	var/obj/item/organ/internal/heart/heart = internal_organs_by_name[BP_HEART]
	if(stat == DEAD)
		heart.scp3349_induced = FALSE
		UnregisterSignal(src, COMSIG_CARBON_LIFE)
	else
		if(heart.scp3349_induced)
			if(prob(2))		// about 1-3 minutes after starting, it ends.
				heart.scp3349_induced = FALSE
				to_chat(src, SPAN_INFO("The euphoric sensation ends."))
			if(prob(20))
				adjustSanityLoss(-1)	// the sensation is comforting
			if(prob(10))
				adjust_stamina(-1)		// little harder to run though
		else
			if(prob(0.15))	// happens about once every 30 minutes, give or take
				heart.scp3349_induced = TRUE
				to_chat(src, SPAN_INFO("You feel a sudden euphoric sensation!"))

// SETUP

GLOBAL_VAR_INIT(scp3349_precedentA, null)
GLOBAL_VAR_INIT(scp3349_precedentB, null)

GLOBAL_VAR_INIT(scp3349_fake_precedentA, null)
GLOBAL_VAR_INIT(scp3349_fake_precedentB, null)
