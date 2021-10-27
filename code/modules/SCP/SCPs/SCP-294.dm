GLOBAL_LIST_EMPTY(scp294_reagents)

/obj/machinery/scp294/
	name = "SCP-294"
	desc = "A standard coffee vending machine. This one seems to have a QWERTY keyboard."
	icon = 'icons/obj/scp294.dmi'
	icon_state = "coffee_294"
	layer = 2.9
	anchored = 1
	density = 1
	var/uses_left = 12
	var/last_use = 0
	var/restocking_timer = 0
	SCP = /datum/scp/scp_294

/obj/machinery/scp294/New(atom/holder)
	..()

	if(!GLOB.scp294_reagents.len)
        //Chemical Reagents - Initialises all /datum/reagent into a list indexed by reagent id
		var/paths = typesof(/datum/reagent)
		for(var/path in paths)
			holder = src
			GLOB.scp294_reagents += path

/obj/machinery/scp294/Destroy()
	. = ..()

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
		return

	var/product = null
	var/mob/living/carbon/victim = null
	var/input_reagent = lowertext(input("Enter the name of any liquid", "What would you like to drink?") as text)
	for(var/mob/living/carbon/M in GLOB.living_mob_list_)
		if (lowertext(M.name) == input_reagent)
			if (istype(M, /mob/living/carbon/))
				victim = M
				if(victim)
					to_chat(M, "You feel a sharp stabbing pain in your insides!")
					var/i
					var/pain = rand(1, 6)
					for(i=1; i<=pain; i++)
						M.adjustBruteLoss(5)

	if(!victim)
		product = find_reagent(input_reagent)

	// use one use
	if (product || victim)
		--uses_left
		if (!uses_left)
			addtimer(CALLBACK(src, .proc/refresh_uses), 240)
	if(product)
		if(do_after(10))
			var/obj/item/reagent_containers/food/drinks/sillycup/D = new /obj/item/reagent_containers/food/drinks/sillycup(loc)
			D.reagents.add_reagent(product, 30)
			visible_message("<span class='notice'>[src] dispenses a small paper cup.</span>")
	else if (victim)
		var/obj/item/reagent_containers/food/drinks/sillycup/D = new /obj/item/reagent_containers/food/drinks/sillycup(loc)
		product = victim.take_blood(D,30)
		D.reagents.reagent_list += product
		D.reagents.update_total()
		D.on_reagent_change()
		visible_message("<span class='notice'>[src] dispenses a small paper cup.</span>")
	else
		visible_message("<span class='notice'>[src]'s OUT OF RANGE light flashes rapidly.</span>")

/obj/machinery/scp294/proc/refresh_uses()
	uses_left = initial(uses_left)

/obj/machinery/scp294/proc/find_reagent(input)
	. = FALSE
	var/list/paths = typesof(/datum/reagents/)
	for(var/picked in paths)
		if(findtext(picked, input))
			return picked
