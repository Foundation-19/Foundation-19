/obj/item/weapon/monster_manual
	name = "monster manual"
	desc = "A book detailing various magical creatures."
	icon = 'icons/obj/library.dmi'
	icon_state = "bookHacking"
	throw_speed = 1
	throw_range = 5
	w_class = ITEM_SIZE_SMALL
	var/uses = 1
	var/temp = null
	var/list/monster = list(/mob/living/simple_animal/familiar/pet/cat,
							/mob/living/simple_animal/familiar/pet/mouse,
							/mob/living/simple_animal/familiar/carcinus,
							/mob/living/simple_animal/familiar/horror,
							/mob/living/simple_animal/familiar/minor_amaros,
							/mob/living/simple_animal/familiar/pike
							)
	var/list/monster_info = list(   "It is well known that the blackest of cats make good familiars.",
									"Mice are full of mischief and magic. A simple animal, yes, but one of the wizard's finest.",
									"A mortal decendant of the original Carcinus, it is said their shells are near impenetrable and their claws as sharp as knives.",
									"The physical embodiment of flesh and decay, its made from the reanimated corpse of a murdered man.",
									"A small magical creature known for its healing powers and pacifist ways.",
									"The more carnivorous and knowledge hungry cousin of the Space Carp. Keep away from books."
									)

/obj/item/weapon/monster_manual/attack_self(mob/user as mob)
	tgui_interact(user)

/obj/item/weapon/monster_manual/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MonsterManual", "Monster Manual")
		ui.open()

/obj/item/weapon/monster_manual/tgui_data(mob/user)
	var/list/data = list()
	data["temp"] = temp
	data["uses"] = uses
	var/list/monsters = list()
	for(var/i=1;i<=monster_info.len;i++)
		var/mob/M = monster[i]
		monsters += list(list(
			"name" = capitalize(initial(M.name)),
			"info" = monster_info[i],
			"path" = "\ref[monster[i]]",
		))
	data["monsters"] = monsters
	return data

/obj/item/weapon/monster_manual/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("return")
			temp = null
			return TRUE
		if("summon")
			if(uses == 0)
				to_chat(usr, "This book is out of uses.")
				return TRUE

			var/datum/ghosttrap/ghost = get_ghost_trap("wizard familiar")
			var path = locate(params["path"]) in monster
			if(!ispath(path))
				crash_with("Invalid mob path in [src]. Contact a coder.")
				return TRUE

			var/mob/living/simple_animal/familiar/F = new path(get_turf(src))
			temp = "You have attempted summoning \the [F]"
			ghost.request_player(F,"A wizard is requesting a familiar.", 60 SECONDS)
			spawn(600)
				if(F)
					if(!F.ckey || !F.client)
						F.visible_message("With no soul to keep \the [F] linked to this plane, it fades away.")
						qdel(F)
					else
						F.faction = usr.faction
						to_chat(F, SPAN_NOTICE("You are a familiar."))
						to_chat(F, "<b>You have been summoned by the wizard [usr] to assist in all matters magical and not.</b>")
						to_chat(F, "<b>Do their bidding and help them with their goals.</b>")
						uses--
			return TRUE
	return FALSE
