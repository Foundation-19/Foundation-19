#define GOOD_RODS	"rods"
#define GOOD_CASH	"cash"
#define GOOD_TAPE	"tape"

GLOBAL_DATUM_INIT(traders, /datum/antagonist/trader, new)

/datum/antagonist/trader
	id = MODE_DCLASS
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

	/// We keep track of the order of the goods we get, so we aren't given the same goods we're trading for	// TODO: this doesn't work lol
	var/list/goods_order = null

/datum/antagonist/trader/create_objectives(datum/mind/trader_mind)
	if(!..())
		return

	// we want more of one good than the other
	var/minor_desired = get_goods_order()
	var/major_desired = get_goods_order()
	var/desired_text

	switch(major_desired)
		if(GOOD_RODS)
			desired_text = "[rand(4,6)] iron rods"
		if(GOOD_CASH)
			desired_text = "[trader_mind.initial_account.money + rand(150,250)] dollars"
		if(GOOD_TAPE)
			desired_text = "[rand(2,3)] rolls of tape"

	switch(minor_desired)
		if(GOOD_RODS)
			desired_text += "and [rand(2,3)] iron rods"
		if(GOOD_CASH)
			desired_text += "and [trader_mind.initial_account.money + rand(50,150)] dollars"
		if(GOOD_TAPE)
			desired_text += "and 1 roll of tape"

	var/datum/objective/trading/trading_objective = new(desired_text)
	trading_objective.owner = trader_mind
	trader_mind.objectives += trading_objective

	var/datum/objective/survive/survive_objective = new
	survive_objective.owner = trader_mind
	trader_mind.objectives += survive_objective

/datum/antagonist/trader/equip(mob/living/carbon/human/trader_mob)
	if(!..())
		return 0

	var/starting_good = get_goods_order()

	switch(starting_good)
		if(GOOD_RODS)
			var/obj/item/stack/material/rods/rods = new
			rods.amount = rand(2,4)
			if(!trader_mob.equip_to_storage(rods))
				trader_mob.put_in_hands(rods)
		if(GOOD_CASH)
			trader_mob.mind.initial_account.money += rand(100, 200)
		if(GOOD_TAPE)
			var/obj/item/tape_roll/tape = new
			if(!trader_mob.equip_to_storage(tape))
				trader_mob.put_in_hands(tape)
			if(prob(50))	// equivalent to rand(1,2) rolls
				var/obj/item/tape_roll/tape2 = new
				if(!trader_mob.equip_to_storage(tape2))
					trader_mob.put_in_hands(tape2)

	give_codewords(trader_mob)

/datum/antagonist/trader/proc/get_goods_order()
	if(isnull(goods_order))
		goods_order = list(GOOD_RODS, GOOD_TAPE, GOOD_CASH)
	return pick_n_take(goods_order)

/datum/antagonist/trader/proc/give_codewords(mob/living/trader_mob)
	to_chat(trader_mob, "<u><b>You've discovered some of the code phrases used by enemies of the Foundation; they might be useful for trading:</b></u>")
	to_chat(trader_mob, "<b>Code Phrase</b>: <span class='danger'>[syndicate_code_phrase]</span>")
	to_chat(trader_mob, "<b>Code Response</b>: <span class='danger'>[syndicate_code_response]</span>")
	trader_mob.StoreMemory("<b>Code Phrase</b>: [syndicate_code_phrase]", /decl/memory_options/system)
	trader_mob.StoreMemory("<b>Code Response</b>: [syndicate_code_response]", /decl/memory_options/system)
	to_chat(trader_mob, "Use the code words, preferably in the order provided, during regular conversation, to identify potential suppliers. Proceed with caution, however, as everyone is a potential foe.")
