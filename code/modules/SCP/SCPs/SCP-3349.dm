/datum/scp/scp_3349
	name = "SCP-3349"
	designation = "3349"
	classification = KETER

// ACTIVITY

/mob/living/carbon/human/proc/handle_3349()
	var/obj/item/organ/internal/heart/heart = internal_organs_by_name[BP_HEART]
	if(stat == DEAD)
		heart.scp3349_induced = FALSE
		UnregisterSignal(src, COMSIG_CARBON_LIFE)
	else
		if(heart.scp3349_induced)
			if(prob(0.75))		// about 2-5 minutes after starting, it ends.
				heart.scp3349_induced = FALSE
				to_chat(src, SPAN_INFO("The euphoric sensation ends."))
			if(prob(20))
				adjustSanityLoss(-1)	// the sensation is comforting
			if(prob(10))
				adjust_stamina(-1)		// little harder to run though
		else
			if(prob(0.1))	// takes a good 20-30 minutes on average, probably
				heart.scp3349_induced = TRUE
				to_chat(src, SPAN_INFO("You feel a sudden euphoric sensation!"))

// SETUP

GLOBAL_VAR(scp3349_precedent)
GLOBAL_VAR(scp3349_fake_precedent)

/proc/initialize_scp3349_precedents()

	// common medicines
	var/list/reagents = list(
		/datum/reagent/medicine/inaprovaline,
		/datum/reagent/medicine/kelotane,
		/datum/reagent/medicine/dylovene,
		/datum/reagent/medicine/dexalin
	)

	GLOB.scp3349_precedent = pick_n_take(reagents)
	GLOB.scp3349_fake_precedent = pick_n_take(reagents)

// PAPER

/obj/item/paper/scp3349_ekg
	color = COLOR_OFF_WHITE
	origin_tech = list(TECH_BIO = 6)
