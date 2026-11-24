/obj/item/storage/messenger
	name = "messenger bag"
	desc = "A small green-grey messenger bag with a blue Corvid Couriers logo on it."
	icon = 'icons/mob/simple_animal/crow.dmi'
	icon_state = "messenger_bag"
	storage_slots = 7
	w_class = ITEM_SIZE_SMALL
	max_w_class = ITEM_SIZE_SMALL

/mob/living/simple_animal/crow
	name = "crow"
	desc = "A large crow. Caw caw."
	icon = 'icons/mob/simple_animal/crow.dmi'
	icon_state = "crow"
	icon_living = "crow"
	icon_dead = "crow_dead"
	pass_flags = PASS_FLAG_TABLE
	mob_size = MOB_SMALL
	density = FALSE

	speak_emote = list("caws")

	natural_weapon = /obj/item/natural_weapon/crow_claws

	response_help  = "pets"
	response_disarm = "gently moves aside"
	response_harm   = "swats"
	universal_speak = TRUE
	pass_flags = PASS_FLAG_TABLE

	var/obj/item/storage/messenger/messenger_bag
	var/obj/item/card/id/access_card

	say_list_type = /datum/say_list/crow

/obj/item/natural_weapon/crow_claws
	name = "claws"
	gender = PLURAL
	attack_verb = list("clawed")
	sharp = TRUE
	force = 7

/mob/living/simple_animal/crow/Initialize()
	. = ..()
	messenger_bag = new(src)
	update_icon()

/mob/living/simple_animal/crow/GetIdCard()
	return access_card

/mob/living/simple_animal/crow/show_inv(mob/user)
	tgui_interact(user)

/mob/living/simple_animal/crow/tgui_interact(mob/user, datum/tgui/ui)
	if(user.incapacitated())
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CrowPanel", "Inventory of \the [name]")
		ui.open()

/mob/living/simple_animal/crow/tgui_data(mob/user)
	var/list/data = list()
	data["access_card"] = access_card ? access_card.name : null
	data["messenger_bag"] = messenger_bag ? messenger_bag.name : null
	return data

/mob/living/simple_animal/crow/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!ishuman(usr))
		return TRUE
	switch(action)
		if("remove_inv")
			var/obj/item/removed
			switch(params["slot"])
				if("access cuff")
					removed = access_card
					access_card = null
				if("back")
					removed = messenger_bag
					messenger_bag = null
			if(removed)
				removed.dropInto(loc)
				usr.put_in_hands(removed)
				visible_message(SPAN_NOTICE("\The [usr] removes \the [removed] from \the [src]'s [params["slot"]]."))
				update_icon()
			else
				to_chat(usr, SPAN_WARNING("There is nothing to remove from \the [src]'s [params["slot"]]."))
			return TRUE
		if("add_inv")
			var/mob/living/carbon/human/user = usr
			var/obj/item/equipping = user.get_active_hand()
			if(!equipping)
				to_chat(user, SPAN_WARNING("You have nothing in your hand to put on \the [src]'s [params["slot"]]."))
				return TRUE
			var/obj/item/equipped
			var/checktype
			switch(params["slot"])
				if("access cuff")
					equipped = access_card
					checktype = /obj/item/card/id
				if("back")
					equipped = messenger_bag
					checktype = /obj/item/storage/messenger
			if(equipped)
				to_chat(user, SPAN_WARNING("There is already something worn on \the [src]'s [params["slot"]]."))
				return TRUE
			if(!istype(equipping, checktype))
				to_chat(user, SPAN_WARNING("\The [equipping] won't fit on \the [src]'s [params["slot"]]."))
				return TRUE
			switch(params["slot"])
				if("access cuff")
					access_card = equipping
				if("back")
					messenger_bag = equipping
			if(!user.unEquip(equipping, src))
				return TRUE
			visible_message(SPAN_NOTICE("\The [user] places \the [equipping] on to \the [src]'s [params["slot"]]."))
			update_icon()
			return TRUE
	return FALSE

/mob/living/simple_animal/crow/DefaultTopicState()
	return GLOB.physical_state

/mob/living/simple_animal/crow/examine(mob/user)
	. = ..()
	if(Adjacent(src))
		if(messenger_bag)
			if(messenger_bag.contents.len)
				to_chat(user, "It's wearing a little messenger bag with a Corvid Couriers logo on it. There's something stuffed inside.")
			else
				to_chat(user, "It's wearing a little messenger bag with a Corvid Couriers logo on it. It seems to be empty.")
		if(access_card)
			to_chat(user, "It has an access cuff with \the [access_card] inserted.")

/mob/living/simple_animal/crow/on_update_icon()
	..()
	cut_overlay("bag")
	cut_overlay("bag_dead")
	if(messenger_bag)
		if(icon_state != icon_dead)
			add_overlay("bag")
		else
			add_overlay("bag_dead")

/mob/living/simple_animal/crow/cyber
	name = "cybercrow"
	desc = "A large cybercrow. k4w k4w."
	speak_emote = list("beeps")

/mob/living/simple_animal/crow/cyber/on_update_icon()
	..()
	cut_overlay("cyber")
	cut_overlay("cyber_dead")
	if(icon_state != icon_dead)
		add_overlay("cyber")
	else
		add_overlay("cyber_dead")

/datum/say_list/crow
	speak = list("Caw.", "Caw?", "Caw!", "CAW.")
	emote_hear = list("caws")
	emote_see = list("hops")
