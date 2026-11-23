/datum/computer_file/program/merchant
	filename = "mlist"
	filedesc = "Merchant's List"
	extended_desc = "Allows communication and trade between passing vessels, even while jumping."
	program_icon_state = "comm"
	program_menu_icon = "cart"
	nanomodule_path = /datum/nano_module/program/merchant
	size = 12
	usage_flags = PROGRAM_CONSOLE
	required_access = ACCESS_MERCHANT
	var/obj/machinery/merchant_pad/pad = null
	var/current_merchant = 0
	var/show_trades = 0
	var/hailed_merchant = 0
	var/last_comms = null
	var/temp = null
	var/bank = 0 //A straight up money till

/datum/nano_module/program/merchant
	name = "Merchant's List"

/datum/computer_file/program/merchant/proc/get_merchant(num)
	if(num > SStrade.traders.len)
		num = SStrade.traders.len
	if(num)
		return SStrade.traders[num]

/datum/nano_module/program/merchant/tgui_interact(mob/user, datum/tgui/ui, datum/tgui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "MerchantProgram", "Merchant List", 575, 700, state = state)
		ui.open()

/datum/nano_module/program/merchant/tgui_data(mob/user)
	var/list/data = host.initial_data()
	var/show_trade = 0
	var/hailed = 0
	var/datum/trader/T
	if(program)
		var/datum/computer_file/program/merchant/P = program
		data["temp"] = P.temp
		data["mode"] = !!P.current_merchant
		data["last_comms"] = P.last_comms
		data["pad"] = !!P.pad
		data["bank"] = P.bank
		show_trade = P.show_trades
		hailed = P.hailed_merchant
		T = P.get_merchant(P.current_merchant)
	data["mode"] = !!T
	if(T)
		data["traderName"] = T.name
		data["origin"]     = T.origin
		data["hailed"]     = hailed
		if(show_trade)
			var/list/trades = list()
			if(T.trading_items.len)
				for(var/i in 1 to T.trading_items.len)
					trades += T.print_trading_items(i)
			data["trades"] = trades
	return data

/datum/computer_file/program/merchant/proc/connect_pad()
	for(var/obj/machinery/merchant_pad/P in orange(1,get_turf(computer)))
		pad = P
		return

/datum/computer_file/program/merchant/proc/test_fire()
	if(pad && pad.get_target())
		return 1
	return 0

/datum/computer_file/program/merchant/proc/get_response(datum/trade_response/tr)
	last_comms = tr.text
	bank += tr.money_delta
	return tr.success

/datum/computer_file/program/merchant/proc/offer_money(datum/trader/T, num, skill)
	if(pad)
		get_response(T.offer_money_for_trade(num, bank, get_turf(pad), skill))
	else
		last_comms = "PAD NOT CONNECTED"

/datum/computer_file/program/merchant/proc/bribe(datum/trader/T, amt)
	if(bank < amt)
		last_comms = "ERROR: NOT ENOUGH FUNDS."
		return
	get_response(T.bribe_to_stay_longer(amt))

/datum/computer_file/program/merchant/proc/offer_item(datum/trader/T, num, skill)
	if(pad)
		var/list/targets = pad.get_targets()
		if(!targets.len)
			last_comms = "PAD IS EMPTY: MOVE GOODS ONTO THE PAD BEFORE PROCEEDING"
			return
		for(var/target in targets)
			if(istype(target, /mob/living/carbon/human))
				var/mob/living/carbon/human/human_trafficking = target
				if(!computer.computer_emagged)
					last_comms = "SAFETY LOCK ENABLED: SENTIENT MATTER UNTRANSMITTABLE"
					return
				if(!human_trafficking.handcuffed) // To avoid accidents and generally unwanted behavior
					last_comms = "TARGET IS NOT SECURED: APPLY RESTRAINTS BEFORE TRANSMITTING"
					return
		get_response(T.offer_items_for_trade(targets, num, get_turf(pad), skill))
	else
		last_comms = "PAD NOT CONNECTED"

/datum/computer_file/program/merchant/proc/sell_items(datum/trader/T, skill)
	if(pad)
		var/list/targets = pad.get_targets()
		if(!targets.len)
			last_comms = "PAD IS EMPTY: MOVE GOODS ONTO THE PAD BEFORE PROCEEDING"
			return
		for(var/target in targets)
			if(istype(target, /mob/living/carbon/human))
				var/mob/living/carbon/human/human_trafficking = target
				if(!computer.computer_emagged)
					last_comms = "SAFETY LOCK ENABLED: SENTIENT MATTER UNTRANSMITTABLE"
					return
				if(!human_trafficking.handcuffed)
					last_comms = "TARGET IS NOT SECURED: APPLY RESTRAINTS BEFORE TRANSMITTING"
					return
		get_response(T.sell_items(targets, skill))
	else
		last_comms = "PAD NOT CONNECTED"

/datum/computer_file/program/merchant/proc/transfer_to_bank()
	if(pad)
		var/list/targets = pad.get_targets()
		for(var/target in targets)
			if(istype(target, /obj/item/spacecash))
				var/obj/item/spacecash/cash = target
				bank += cash.worth
				qdel(target)
		last_comms = "ALL MONEY DETECTED ON PAD TRANSFERED"
		return
	last_comms = "PAD NOT CONNECTED"

/datum/computer_file/program/merchant/proc/get_money()
	if(!pad)
		last_comms = "PAD NOT CONNECTED. CANNOT TRANSFER"
		return
	var/turf/T = get_turf(pad)
	var/obj/item/spacecash/bundle/B = new(T)
	B.worth = bank
	bank = 0
	B.update_icon()

/datum/computer_file/program/merchant/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/user = usr
	if(action == "PRG_connect_pad")
		. = TRUE
		connect_pad()
	if(action == "PRG_continue")
		. = TRUE
		temp = null
	if(action == "PRG_transfer_to_bank")
		. = TRUE
		transfer_to_bank()
	if(action == "PRG_get_money")
		. = TRUE
		get_money()
	if(action == "PRG_main_menu")
		. = TRUE
		current_merchant = 0
	if(action == "PRG_merchant_list")
		if(SStrade.traders.len == 0)
			. = FALSE
			temp = "Cannot find any traders within broadcasting range."
		else
			. = TRUE
			current_merchant = 1
			hailed_merchant = 0
			last_comms = null
	if(action == "PRG_test_fire")
		. = TRUE
		if(test_fire())
			temp = "Test Fire Successful"
		else
			temp = "Test Fire Unsuccessful"
	if(action == "PRG_scroll")
		. = TRUE
		var/scrolled = 0
		switch(params["PRG_scroll"])
			if("right")
				scrolled = 1
			if("left")
				scrolled = -1
		var/new_merchant  = Clamp(current_merchant + scrolled, 1, SStrade.traders.len)
		if(new_merchant != current_merchant)
			hailed_merchant = 0
			last_comms = null
		current_merchant = new_merchant
	if(current_merchant)
		var/datum/trader/T = get_merchant(current_merchant)
		if(!hailed_merchant)
			if(action == "PRG_hail")
				. = TRUE
				hailed_merchant = get_response(T.hail(user))
				show_trades = 0
			. = TRUE
		else
			if(action == "PRG_show_trades")
				. = TRUE
				show_trades = !show_trades
			if(action == "PRG_insult")
				. = TRUE
				get_response(T.insult())
			if(action == "PRG_compliment")
				. = TRUE
				get_response(T.compliment())
			if(action == "PRG_offer_item")
				. = TRUE
				offer_item(T,text2num(params["PRG_offer_item"]) + 1, user.get_skill_value(SKILL_FINANCE))
			if(action == "PRG_how_much_do_you_want")
				. = TRUE
				get_response(T.how_much_do_you_want(text2num(params["PRG_how_much_do_you_want"]) + 1, user.get_skill_value(SKILL_FINANCE)))
			if(action == "PRG_offer_money_for_item")
				. = TRUE
				offer_money(T, text2num(params["PRG_offer_money_for_item"])+1, user.get_skill_value(SKILL_FINANCE))
			if(action == "PRG_what_do_you_want")
				. = TRUE
				get_response(T.what_do_you_want())
			if(action == "PRG_sell_items")
				. = TRUE
				sell_items(T, user.get_skill_value(SKILL_FINANCE))
			if(action == "PRG_bribe")
				. = TRUE
				bribe(T, text2num(params["PRG_bribe"]))
