GLOBAL_LIST_EMPTY(scp294_reagents)

/obj/machinery/scp294/
	name = "SCP-294"
	desc = "A standard coffee vending machine. This one seems to have a QWERTY keyboard."
	icon = 'icons/obj/scp294.dmi'
	icon_state = "coffee_294"
	layer = 2.9
	anchored = TRUE
	density = TRUE
	var/uses_left = 12
	var/last_use = 0
	var/restocking_timer = 0
	SCP = /datum/scp/scp_294
	var/list/player_names = list()
	var/player_attack
	var/mob/living/carbon/victim

/obj/machinery/scp294/Initialize(atom/holder)
	//get the names of all players at roundstart to save on cpu.
	//yes this may lead to names not working if they join midround but it adds to the mystery of its 'randomness' lol

	player_names += GLOB.player_list
	return ..()

/obj/machinery/scp294/Destroy()
	player_names = null
	victim = null
	return ..()

/datum/scp/scp_294
	name = "SCP-294"
	designation = "294"
	classification = EUCLID

/obj/machinery/scp294/attack_hand(mob/user)

	if((last_use + 3 SECONDS) > world.time)
		visible_message("<span class='notice'>[src] displays NOT READY message.</span>")
		return

	last_use = world.time
	if(uses_left < 1)
		visible_message("<span class='notice'>[src] displays RESTOCKING, PLEASE WAIT message.</span>")
		addtimer(CALLBACK(src, .proc/update_uses), 60 SECONDS)
		return

	var/valid_id
	while(!valid_id)
		var/chosen_id = input(user, "Enter the name of any liquid!", "SCP 294") as null|text
		if(isnull(chosen_id))
			break

		if(ispath(chosen_id))
			valid_id = TRUE
		else
			valid_id = FALSE

		if(!valid_id)
			to_chat(user, "<span class='warning'>A strange substance wheezes out of the dispenser and evaporates.</span>")
			return
		var/obj/item/reagent_containers/food/drinks/sillycup/D = new /obj/item/reagent_containers/food/drinks/sillycup(loc)
		D.reagents.add_reagent(chosen_id, 30)
		D.reagents.update_total()
		D.on_reagent_change()
		visible_message("<span class='notice'>[src] dispenses a small paper cup.</span>")


/obj/machinery/scp294/proc/update_uses()
	if(uses_left < 12)
		uses_left += 1
		addtimer(CALLBACK(src, .proc/update_uses), 60 SECONDS)
