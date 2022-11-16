GLOBAL_LIST_EMPTY(scp294_reagents)

/obj/machinery/scp294/
	name = "SCP-294"
	desc = "A standard coffee vending machine. This one seems to have a QWERTY keyboard."
	icon = 'icons/obj/scp294.dmi'
	icon_state = "coffee_294"
	layer = 2.9
	anchored = TRUE
	density = TRUE
	var/list/banned_chems = list(
	/datum/reagent/adminordrazine,
	/datum/reagent/nitroglycerin,
	/datum/reagent/glycerol,
	/datum/reagent/coolant,
	/datum/reagent/frostoil,
	/datum/reagent/zombie,
	/datum/reagent/jerraman,
	/datum/reagent/three_eye
	)
	var/uses_left = 5
	var/last_use = 0
	var/restock_amount = 5
	var/restock_delay = 10 MINUTES //This is in ticks.
	var/restock_min = 1 //The minimum amount that SCP-294 can have before restocking
	SCP = /datum/scp/scp_294

/datum/scp/scp_294
	name = "SCP-294"
	designation = "294"
	classification = EUCLID

/obj/machinery/scp294/attack_hand(mob/user)

	if((last_use + 20 SECONDS) > world.time)
		visible_message(SPAN_NOTICE("[src] displays 'NOT READY'."))
		return

	last_use = world.time
	if(uses_left < restock_min)
		visible_message(SPAN_NOTICE("[src] displays 'RESTOCKING'."))
		addtimer(CALLBACK(src, .proc/update_uses), restock_delay)
		return

	var/valid_id
	while(!valid_id)
		var/chosen_id = input(user, "Enter the name of any liquid!", "SCP 294") as null|text
		var/chosen_reagent = text2path(chosen_id)
		if(isnull(chosen_id))
			to_chat(user, SPAN_WARNING("SCP-294 wheezes and displays 'NO INPUT' before shutting down."))
			return
		if(!ispath(chosen_reagent))
			to_chat(user, SPAN_WARNING("SCP-294 wheezes and displays 'OUT OF RANGE' before shutting down."))
			return
		if(!(chosen_reagent in banned_chems))
			valid_id = TRUE
		else
			valid_id = FALSE
			to_chat(user, SPAN_WARNING("A strange substance wheezes out of the dispenser and evaporates."))
			return

		var/obj/item/reagent_containers/food/drinks/sillycup/D = new /obj/item/reagent_containers/food/drinks/sillycup(loc)
		D.reagents.add_reagent(chosen_reagent, 30)
		D.reagents.update_total()
		D.on_reagent_change()
		visible_message(SPAN_NOTICE("[src] dispenses a small paper cup."))


/obj/machinery/scp294/proc/update_uses()
	if(uses_left < restock_min) //So you can adjust when it restocks. E.G never
		uses_left = restock_amount //No use conserving charges. You got what you got.
		addtimer(CALLBACK(src, .proc/update_uses), restock_delay)
