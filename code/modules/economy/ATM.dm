#define NO_SCREEN 0
#define CHANGE_SECURITY_LEVEL 1
#define TRANSFER_FUNDS 2
#define VIEW_TRANSACTION_LOGS 3

/obj/item/card/id/var/money = 2000

/obj/machinery/atm
	name = "automatic teller machine"
	desc = "For all your monetary needs!"
	icon = 'icons/obj/terminals.dmi'
	icon_state = "atm"
	anchored = TRUE
	idle_power_usage = 10
	var/datum/money_account/authenticated_account
	var/number_incorrect_tries = 0
	var/previous_account_number = 0
	var/max_pin_attempts = 3
	var/ticks_left_locked_down = 0
	var/ticks_left_timeout = 0
	var/machine_id = ""
	var/obj/item/card/id/held_card
	var/editing_security_level = 0
	var/view_screen = NO_SCREEN
	var/datum/effect/effect/system/spark_spread/spark_system
	var/account_security_level = 0

/obj/machinery/atm/New()
	..()
	machine_id = "[station_name()] ATM #[num_financial_terminals++]"
	spark_system = new /datum/effect/effect/system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/machinery/atm/Process()
	if(stat & NOPOWER)
		return

	if(ticks_left_timeout > 0)
		ticks_left_timeout--
		if(ticks_left_timeout <= 0)
			authenticated_account = null
	if(ticks_left_locked_down > 0)
		ticks_left_locked_down--
		if(ticks_left_locked_down <= 0)
			number_incorrect_tries = 0

	for(var/obj/item/spacecash/S in src)
		S.dropInto(loc)
		if(prob(50))
			playsound(loc, 'sounds/items/polaroid1.ogg', 50, 1)
		else
			playsound(loc, 'sounds/items/polaroid2.ogg', 50, 1)
		break

/obj/machinery/atm/emag_act(remaining_charges, mob/user)
	if(!emagged)
		//short out the machine, shoot sparks, spew money!
		emagged = TRUE
		spark_system.start()
		spawn_money(rand(100,500),get_turf(src))
		//we don't want to grief people by locking their id in an emagged ATM
		release_held_id(user)

		//display a message to the user
		var/response = pick("Initiating withdraw. Have a nice day!", "CRITICAL ERROR: Activating cash chamber panic siphon.","PIN Code accepted! Emptying account balance.", "Jackpot!")
		to_chat(user, "[icon2html(src, user)] <span class='warning'>[src] beeps: \"[response]\"</span>")
		return 1

/obj/machinery/atm/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/card/id))
		if(emagged > 0)
			//prevent inserting id into an emagged ATM
			to_chat(user, "[icon2html(src, user)] <span class='warning'>CARD READER ERROR. This system has been compromised!</span>")
			return
		if(stat & NOPOWER)
			to_chat(user, "You try to insert your card into [src], but nothing happens.")
			return

		var/obj/item/card/id/idcard = I
		if(!held_card)
			if(!user.unEquip(idcard, src))
				return
			held_card = idcard
			if(authenticated_account && held_card.associated_account_number != authenticated_account.account_number)
				authenticated_account = null
			attack_hand(user)

	else if(authenticated_account)
		if(istype(I,/obj/item/spacecash))
			var/obj/item/spacecash/dolla = I

			//deposit the cash
			if(authenticated_account.deposit(dolla.worth, "Credit deposit", machine_id))
				if(prob(50))
					playsound(loc, 'sounds/items/polaroid1.ogg', 50, 1)
				else
					playsound(loc, 'sounds/items/polaroid2.ogg', 50, 1)

				to_chat(user, SPAN_INFO("You insert [I] into [src]."))
				src.attack_hand(user)
				qdel(I)
	else
		..()

/obj/machinery/atm/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/atm/tgui_interact(mob/user, datum/tgui/ui)
	if(istype(user, /mob/living/silicon))
		to_chat(user, "[icon2html(src, user)] <span class='warning'>Artificial unit recognized. Artificial units do not currently receive monetary compensation, as per system banking regulation #1005.</span>")
		return

	if(get_dist(src, user) > 1)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ATM", machine_id)
		ui.open()

/obj/machinery/atm/tgui_data(mob/user)
	var/list/data = list()
	data["screen"] = view_screen
	data["machine_id"] = machine_id
	data["has_card"] = held_card ? TRUE : FALSE
	if(held_card)
		data["card_name"] = held_card.name
	data["emagged"] = emagged > 0 ? TRUE : FALSE
	data["locked_down"] = ticks_left_locked_down > 0 ? TRUE : FALSE
	data["security_required"] = account_security_level
	data["logged_in"] = authenticated_account ? TRUE : FALSE
	if(authenticated_account)
		data["owner_name"] = authenticated_account.owner_name
		data["money"] = authenticated_account.money
		data["suspended"] = authenticated_account.suspended ? TRUE : FALSE
		data["security_level"] = authenticated_account.security_level
		data["currency"] = GLOB.using_map.local_currency_name_short
		var/list/transactions = list()
		for(var/datum/transaction/T in authenticated_account.transaction_log)
			transactions += list(list(
				"date" = T.date,
				"time" = T.time,
				"target" = T.get_target_name(),
				"purpose" = T.purpose,
				"amount" = T.amount,
				"source" = T.get_source_name(),
			))
		data["transactions"] = transactions
	return data

/obj/machinery/atm/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("transfer")
			if(authenticated_account)
				var/transfer_amount = text2num(params["funds_amount"])
				transfer_amount = round(transfer_amount, 0.01)
				if(transfer_amount <= 0)
					alert("That is not a valid amount.")
				else if(transfer_amount <= authenticated_account.money)
					var/target_account_number = text2num(params["target_acc_number"])
					var/transfer_purpose = sanitizeSafe(params["purpose"])
					var/datum/money_account/target_account = get_account(target_account_number)
					if(target_account && authenticated_account.transfer(target_account, transfer_amount, transfer_purpose))
						to_chat(usr, "[icon2html(src, usr)]<span class='info'>Funds transfer successful.</span>")
					else
						to_chat(usr, "[icon2html(src, usr)]<span class='warning'>Funds transfer failed.</span>")

				else
					to_chat(usr, "[icon2html(src, usr)]<span class='warning'>You don't have enough funds to do that!</span>")
			return TRUE

		if("goto")
			view_screen = text2num(params["screen"])
			return TRUE

		if("change_security_level")
			if(authenticated_account)
				var/new_sec_level = max( min(text2num(params["new_security_level"]), 2), 0)
				authenticated_account.security_level = new_sec_level
			return TRUE

		if("attempt_auth")
			//Look to see if we're holding an ID, if so scan the data from that and use it, if not scan the user for the data
			var/obj/item/card/id/login_card
			login_card = held_card ? held_card : scan_user(usr)

			if(!ticks_left_locked_down)
				var/tried_account_num = text2num(params["account_num"])
				//We WILL need an account number entered manually if security is high enough, do not automagic account number
				if(!tried_account_num && login_card && (account_security_level != 2))
					tried_account_num = login_card.associated_account_number
				var/tried_pin = text2num(params["account_pin"])

				//We'll need more information if an account's security is greater than zero so let's find out what the security setting is
				var/datum/money_account/D
				//Below is to avoid a runtime
				if(tried_account_num)
					D = get_account(tried_account_num)

					if(D)
						account_security_level = D.security_level

				authenticated_account = attempt_account_access(tried_account_num, tried_pin, held_card && login_card.associated_account_number == tried_account_num ? 2 : 1)

				if(!authenticated_account)
					number_incorrect_tries++
					//let's not count an incorrect try on someone who just needs to put in more information
					if(previous_account_number == tried_account_num && tried_pin)
						if(number_incorrect_tries >= max_pin_attempts)
							//lock down the atm
							ticks_left_locked_down = 30
							playsound(src, 'sounds/machines/buzz-two.ogg', 50, 1)

							//create an entry in the account transaction log
							var/datum/money_account/failed_account = get_account(tried_account_num)
							if(failed_account)
								failed_account.log_msg("Unauthorized login attempt", machine_id)
						else
							to_chat(usr, "[icon2html(src, usr)] <span class='warning'>Incorrect pin/account combination entered, [max_pin_attempts - number_incorrect_tries] attempts remaining.</span>")
							previous_account_number = tried_account_num
							playsound(src, 'sounds/machines/buzz-sigh.ogg', 50, 1)
					else
						to_chat(usr, "[icon2html(src, usr)] <span class='warning'>Unable to log in to account, additional information may be required.</span>")
						number_incorrect_tries = 0
				else
					playsound(src, 'sounds/machines/twobeep.ogg', 50, 1)
					ticks_left_timeout = 120
					view_screen = NO_SCREEN

					//create a transaction log entry
					authenticated_account.log_msg("Remote terminal access", machine_id)

					to_chat(usr, "[icon2html(src, usr)] <span class='info'>Access granted. Welcome user '[authenticated_account.owner_name].'</span>")

				previous_account_number = tried_account_num
			return TRUE

		if("e_withdrawal")
			var/amount = max(text2num(params["funds_amount"]),0)
			amount = round(amount, 0.01)
			if(amount <= 0)
				alert("That is not a valid amount.")
			else if(authenticated_account && amount > 0)
				//create an entry in the account transaction log
				if(amount <= authenticated_account.money)
					if(authenticated_account.withdraw(amount, "Credit withdrawal", machine_id))
						playsound(src, 'sounds/machines/chime.ogg', 50, 1)
						spawn_ewallet(amount,get_turf(src),usr)
				else
					to_chat(usr, "[icon2html(src, usr)]<span class='warning'>You don't have enough funds to do that!</span>")
			return TRUE

		if("withdrawal")
			var/amount = max(text2num(params["funds_amount"]),0)
			amount = round(amount, 0.01)
			if(amount <= 0)
				alert("That is not a valid amount.")
			else if(authenticated_account && amount > 0)
				//remove the money
				if(amount <= authenticated_account.money)
					if(authenticated_account.withdraw(amount, "Credit withdrawal", machine_id))
						playsound(src, 'sounds/machines/chime.ogg', 50, 1)
						spawn_money(amount,get_turf(src),usr)
				else
					to_chat(usr, "[icon2html(src, usr)]<span class='warning'>You don't have enough funds to do that!</span>")
			return TRUE

		if("balance_statement")
			if(authenticated_account)
				var/obj/item/paper/R = new(get_turf(src))
				R.SetName("Account balance: [authenticated_account.owner_name]")
				R.info = "<b>Automated Teller Account Statement</b><br><br>"
				R.info += "<i>Account holder:</i> [authenticated_account.owner_name]<br>"
				R.info += "<i>Account number:</i> [authenticated_account.account_number]<br>"
				R.info += "<i>Balance:</i> [GLOB.using_map.local_currency_name_short][authenticated_account.money]<br>"
				R.info += "<i>Date and time:</i> [station_time_timestamp("hh:mm")], [stationdate2text()]<br><br>"
				R.info += "<i>Service terminal ID:</i> [machine_id]<br>"

				//stamp the paper
				var/image/stampoverlay = image('icons/obj/bureaucracy.dmi')
				stampoverlay.icon_state = "paper_stamp-boss"
				if(!R.stamped)
					R.stamped = new
				R.stamped += /obj/item/stamp
				R.add_overlay(stampoverlay)
				R.stamps += "<HR><i>This paper has been stamped by the Automatic Teller Machine.</i>"

				playsound(loc, prob(50) ? 'sounds/items/polaroid1.ogg' : 'sounds/items/polaroid2.ogg', 50, 1)
			return TRUE

		if("print_transaction")
			if(authenticated_account)
				var/obj/item/paper/R = new(get_turf(src))
				R.SetName("Transaction logs: [authenticated_account.owner_name]")
				R.info = "<b>Transaction logs</b><br>"
				R.info += "<i>Account holder:</i> [authenticated_account.owner_name]<br>"
				R.info += "<i>Account number:</i> [authenticated_account.account_number]<br>"
				R.info += "<i>Date and time:</i> [station_time_timestamp("hh:mm")], [stationdate2text()]<br><br>"
				R.info += "<i>Service terminal ID:</i> [machine_id]<br>"
				R.info += "<table border=1 style='width:100%'>"
				R.info += "<tr>"
				R.info += "<td><b>Date</b></td>"
				R.info += "<td><b>Time</b></td>"
				R.info += "<td><b>Target</b></td>"
				R.info += "<td><b>Purpose</b></td>"
				R.info += "<td><b>Value</b></td>"
				R.info += "<td><b>Source terminal ID</b></td>"
				R.info += "</tr>"

				for(var/datum/transaction/T in authenticated_account.transaction_log)
					R.info += "<tr>"
					R.info += "<td>[T.date]</td>"
					R.info += "<td>[T.time]</td>"
					R.info += "<td>[T.get_target_name()]</td>"
					R.info += "<td>[T.purpose]</td>"
					R.info += "<td>[GLOB.using_map.local_currency_name_short][T.amount]</td>"
					R.info += "<td>[T.get_source_name()]</td>"
					R.info += "</tr>"
				R.info += "</table>"

				//stamp the paper
				var/image/stampoverlay = image('icons/obj/bureaucracy.dmi')
				stampoverlay.icon_state = "paper_stamp-boss"
				if(!R.stamped)
					R.stamped = new
				R.stamped += /obj/item/stamp
				R.add_overlay(stampoverlay)
				R.stamps += "<HR><i>This paper has been stamped by the Automatic Teller Machine.</i>"

				playsound(loc, prob(50) ? 'sounds/items/polaroid1.ogg' : 'sounds/items/polaroid2.ogg', 50, 1)
			return TRUE

		if("insert_card")
			if(!held_card)
				//this might happen if the user had the browser window open when somebody emagged it
				if(emagged > 0)
					to_chat(usr, "[icon2html(src, usr)] <span class='warning'>The ATM card reader rejected your ID because this machine has been sabotaged!</span>")
				else
					var/obj/item/I = usr.get_active_hand()
					if(istype(I, /obj/item/card/id))
						if(!usr.unEquip(I, src))
							return TRUE
						held_card = I
			else
				release_held_id(usr)
			return TRUE

		if("logout")
			authenticated_account = null
			account_security_level = 0
			return TRUE
	return FALSE

/obj/machinery/atm/proc/scan_user(mob/living/carbon/human/human_user as mob)
	if(!authenticated_account)
		var/obj/item/card/id/I = human_user.GetIdCard()
		if(istype(I))
			return I

// put the currently held id on the ground or in the hand of the user
/obj/machinery/atm/proc/release_held_id(mob/living/carbon/human/human_user as mob)
	if(!held_card)
		return

	held_card.dropInto(loc)
	authenticated_account = null
	account_security_level = 0

	if(ishuman(human_user) && !human_user.get_active_hand())
		human_user.put_in_hands(held_card)
	held_card = null


/obj/machinery/atm/proc/spawn_ewallet(sum, loc, mob/living/carbon/human/human_user as mob)
	var/obj/item/spacecash/ewallet/E = new /obj/item/spacecash/ewallet(loc)
	if(ishuman(human_user) && !human_user.get_active_hand())
		human_user.put_in_hands(E)
	E.worth = sum
	E.owner_name = authenticated_account.owner_name
