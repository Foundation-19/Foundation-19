/datum/antagonist/trader
	id = MODE_DCLASS
	antaghud_indicator = "hud_trader"
	whitelisted_jobs = list(/datum/job/classd)
	flags = ANTAG_RANDSPAWN | ANTAG_VOTABLE

/datum/antagonist/trader/create_objectives(datum/mind/trader_mind)
	if(!..())
		return

	var/datum/objective/survive/survive_objective = new
	survive_objective.owner = trader_mind
	trader_mind.objectives += survive_objective

/datum/antagonist/trader/equip(mob/living/carbon/human/trader_mob)
	if(!..())
		return 0

	give_codewords(trader_mob)

/datum/antagonist/trader/proc/give_codewords(mob/living/trader_mob)
	to_chat(trader_mob, "<u><b>You've discovered some of the code phrases used by enemies of the Foundation; they might be useful for trading:</b></u>")
	to_chat(trader_mob, "<b>Code Phrase</b>: <span class='danger'>[syndicate_code_phrase]</span>")
	to_chat(trader_mob, "<b>Code Response</b>: <span class='danger'>[syndicate_code_response]</span>")
	trader_mob.StoreMemory("<b>Code Phrase</b>: [syndicate_code_phrase]", /decl/memory_options/system)
	trader_mob.StoreMemory("<b>Code Response</b>: [syndicate_code_response]", /decl/memory_options/system)
	to_chat(trader_mob, "Use the code words, preferably in the order provided, during regular conversation, to identify potential suppliers. Proceed with caution, however, as everyone is a potential foe.")
