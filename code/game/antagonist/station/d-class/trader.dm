#define GOOD_RODS	"rods"
#define GOOD_CASH	"cash"
#define GOOD_TAPE	"tape"

GLOBAL_DATUM_INIT(traders, /datum/antagonist/trader, new)

/datum/antagonist/trader
	id = MODE_TRADER
	role_text = "Trader"
	role_text_plural = "Traders"
	antaghud_indicator = "hud_trader"
	whitelisted_jobs = list(/datum/job/classd)
	flags = ANTAG_RANDSPAWN | ANTAG_VOTABLE
	skill_setter = null
	antag_text = "You are an semi-tagonist! While you have goals of your own, you aren't inherently an opposing force of your own. \
		Further RP and try to make sure other players have <i>fun</i>! \
		If you are confused or at a loss, always adminhelp, and before taking extreme actions, please try to also contact the administration! \
		Think through your actions and make the roleplay immersive! \
		<b>Please remember all rules aside from those without explicit exceptions apply to you.</b>"
	welcome_text = "You are a Trader! Trade with other D-class - and willing Foundation staff - for resources."


/datum/antagonist/trader/equip(mob/living/carbon/human/trader_mob)
	if(!..())
		return 0

	// we get an objective for a large amount of one good, a small amount of another, as well as a freebie of a third
	var/list/goods_order = list(GOOD_RODS, GOOD_TAPE, GOOD_CASH)

	// hacky as HELL. we should be getting objectives in create_objectives(), but then it's very difficult to keep track of which goods we're getting and which ones we want.

	var/desired_text

	switch(pick_n_take(goods_order))
		if(GOOD_RODS)
			desired_text = "[rand(4,6)] iron rods"
		if(GOOD_CASH)
			desired_text = "[trader_mob.mind?.initial_account.money + rand(300,400)] dollars"
		if(GOOD_TAPE)
			desired_text = "[rand(2,3)] rolls of tape"

	switch(pick_n_take(goods_order))
		if(GOOD_RODS)
			desired_text += "and [rand(2,3)] iron rods"
		if(GOOD_CASH)
			desired_text += "and [trader_mob.mind?.initial_account.money + rand(100,200)] dollars"
		if(GOOD_TAPE)
			desired_text += "and 1 roll of tape"

	var/datum/objective/trading/trading_objective = new(desired_text)
	trading_objective.owner = trader_mob.mind
	trader_mob.mind?.objectives += trading_objective

	var/datum/objective/survive/survive_objective = new
	survive_objective.owner = trader_mob.mind
	trader_mob.mind?.objectives += survive_objective

	switch(pick_n_take(goods_order))
		if(GOOD_RODS)
			var/obj/item/stack/material/rods/rods = new
			rods.amount = rand(3,4)
			if(!trader_mob.equip_to_storage(rods))
				trader_mob.put_in_hands(rods)
		if(GOOD_CASH)
			trader_mob.mind.initial_account.money += rand(200, 300)
		if(GOOD_TAPE)
			var/obj/item/tape_roll/tape = new
			if(!trader_mob.equip_to_storage(tape))
				trader_mob.put_in_hands(tape)
			if(prob(50))	// equivalent to rand(1,2) rolls
				var/obj/item/tape_roll/tape2 = new
				if(!trader_mob.equip_to_storage(tape2))
					trader_mob.put_in_hands(tape2)

	give_codewords(trader_mob)

/datum/antagonist/trader/proc/give_codewords(mob/living/trader_mob)
	to_chat(trader_mob, "<u><b>You've discovered some of the code phrases used by enemies of the Foundation; they might be useful for trading:</b></u>")
	to_chat(trader_mob, "<b>Code Phrases</b>: <span class='danger'>[jointext(GLOB.syndicate_code_phrase, ", ")]</span>")
	to_chat(trader_mob, "<b>Code Responses</b>: <span class='danger'>[jointext(GLOB.syndicate_code_response, ", ")]</span>")
	trader_mob.StoreMemory("<b>Code Phrases</b>: [jointext(GLOB.syndicate_code_phrase, ", ")]", /decl/memory_options/system)
	trader_mob.StoreMemory("<b>Code Responses</b>: [jointext(GLOB.syndicate_code_response, ", ")]", /decl/memory_options/system)
	to_chat(trader_mob, "Use the code words, preferably in the order provided, during regular conversation, to identify potential suppliers. Proceed with caution, however, as everyone is a potential foe.")

	trader_mob.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_phrase_regex, "blue", src)
	trader_mob.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_response_regex, "red", src)
