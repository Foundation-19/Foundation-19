/// Restores our verbs. It will only restore verbs allowed during lesser (monkey) form if we are not human
/mob/proc/make_changeling()
	if(!mind)
		return
	if(!mind.changeling)
		mind.changeling = new /datum/changeling(gender)
		mind.changeling.owner_mind = mind

	add_verb(src, /datum/changeling/proc/EvolutionMenu)
	add_language(LANGUAGE_CHANGELING_GLOBAL)

	// Code to auto-purchase free powers.
	for(var/power_type in GLOB.changeling_powers)
		var/datum/power/changeling/P = power_type
		if(!initial(P.genome_cost) && !initial(P.no_autobuy) && !(locate(P) in mind.changeling.purchased_powers)) // Is it free, and we don't own it?
			mind.changeling.purchasePower(mind, P, FALSE, TRUE)

	for(var/language in languages)
		mind.changeling.absorbed_languages |= language

	var/mob/living/carbon/human/H = src
	if(istype(H))
		var/datum/absorbed_dna/newDNA = new(H.real_name, H.dna, H.species.name, H.languages)
		mind.changeling.absorb_DNA(newDNA)

	return TRUE


/mob/proc/sting_can_reach(mob/M, sting_range = 1)
	if(M.loc == loc)
		return 1 //target and source are in the same thing
	if(!isturf(loc) || !isturf(M.loc))
		to_chat(src, SPAN_WARNING("We cannot reach \the [M] with a sting!"))
		return //One is inside, the other is outside something.
	// Maximum queued turfs set to 25; I don't *think* anything raises sting_range above 2, but if it does the 25 may need raising
	if(!AStar(loc, M.loc, /turf/proc/AdjacentTurfs, /turf/proc/Distance, max_nodes=25, max_node_depth=sting_range)) //If we can't find a path, fail
		to_chat(src, SPAN_WARNING("We cannot find a path to sting \the [M] by!"))
		return
	return TRUE
