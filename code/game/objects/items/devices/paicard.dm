/obj/item/device/paicard
	name = "personal AI device"
	icon = 'icons/obj/pda.dmi'
	icon_state = "pai"
	item_state = "electronic"
	w_class = ITEM_SIZE_SMALL
	slot_flags = SLOT_BELT
	origin_tech = list(TECH_DATA = 2)
	var/obj/item/device/radio/radio
	var/looking_for_personality = 0
	var/mob/living/silicon/pai/pai

/obj/item/device/paicard/relaymove(mob/user, direction)
	if(user.stat || user.stunned)
		return
	var/obj/item/rig/rig = src.get_rig()
	if(istype(rig))
		rig.forced_move(direction, user)

/obj/item/device/paicard/New()
	..()
	add_overlay("pai-off")

/obj/item/device/paicard/Destroy()
	//Will stop people throwing friend pAIs into the singularity so they can respawn
	if(!isnull(pai))
		pai.death(0)
	QDEL_NULL(radio)
	return ..()

/obj/item/device/paicard/attack_self(mob/user)
	if (!in_range(src, user))
		return
	tgui_interact(user)

/obj/item/device/paicard/tgui_interact(mob/user, datum/tgui/ui)
	if(!in_range(src, user))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PAICard", "PAI Card")
		ui.open()

/obj/item/device/paicard/tgui_data(mob/user)
	var/list/data = list()
	data["has_pai"] = pai ? TRUE : FALSE
	data["looking_for_personality"] = looking_for_personality
	data["has_radio"] = radio ? TRUE : FALSE
	if(pai)
		data["pai_name"] = pai.name
		data["pai_law0"] = pai.pai_law0
		data["pai_laws"] = pai.pai_laws
		data["can_set_dna"] = (!pai.master_dna || !pai.master) ? TRUE : FALSE
	if(radio)
		data["broadcasting"] = radio.broadcasting
		data["listening"] = radio.listening
	return data

/obj/item/device/paicard/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("setdna")
			if(!istype(pai) || pai.master_dna)
				return TRUE
			var/mob/M = usr
			if(!istype(M, /mob/living/carbon))
				to_chat(usr, SPAN_NOTICE("You don't have any DNA, or your DNA is incompatible with this device."))
			else
				var/datum/dna/dna = usr.dna
				pai.master = M.real_name
				pai.master_dna = dna.unique_enzymes
				to_chat(pai, SPAN_WARNING("You have been bound to a new master."))
			return TRUE
		if("request")
			src.looking_for_personality = 1
			paiController.findPAI(src, usr)
			return TRUE
		if("wipe")
			var/confirm = input("Are you CERTAIN you wish to delete the current personality? This action cannot be undone.", "Personality Wipe") in list("Yes", "No")
			if(confirm == "Yes")
				for(var/mob/M in src)
					to_chat(M, "<font color = #ff0000><h2>You feel yourself slipping away from reality.</h2></font>")
					to_chat(M, "<font color = #ff4d4d><h3>Byte by byte you lose your sense of self.</h3></font>")
					to_chat(M, "<font color = #ff8787><h4>Your mental faculties leave you.</h4></font>")
					to_chat(M, "<font color = #ffc4c4><h5>oblivion... </h5></font>")
					M.death(0)
				removePersonality()
			return TRUE
		if("wires")
			if(!istype(radio) || !istype(pai))
				return TRUE
			var/t1 = text2num(params["wires"])
			switch(t1)
				if(4)
					radio.ToggleBroadcast()
				if(2)
					radio.ToggleReception()
			return TRUE
		if("setlaws")
			if(!istype(pai))
				return TRUE
			var/newlaws = sanitize(input("Enter any additional directives you would like your pAI personality to follow. Note that these directives will not override the personality's allegiance to its imprinted master. Conflicting directives will be ignored.", "pAI Directive Configuration", pai.pai_laws) as message)
			if(newlaws)
				pai.pai_laws = newlaws
				to_chat(pai, "Your supplemental directives have been updated. Your new directives are:")
				to_chat(pai, "Prime Directive: <br>[pai.pai_law0]")
				to_chat(pai, "Supplemental Directives: <br>[pai.pai_laws]")
			return TRUE
	return FALSE

// 		WIRE_SIGNAL = 1
//		WIRE_RECEIVE = 2
//		WIRE_TRANSMIT = 4

/obj/item/device/paicard/proc/setPersonality(mob/living/silicon/pai/personality)
	src.pai = personality
	src.add_overlay("pai-happy")

/obj/item/device/paicard/proc/removePersonality()
	src.pai = null
	src.cut_overlays()
	src.add_overlay("pai-off")

/obj/item/device/paicard
	var/current_emotion = 1
/obj/item/device/paicard/proc/setEmotion(emotion)
	if(pai)
		src.cut_overlays()
		switch(emotion)
			if(1) src.add_overlay("pai-happy")
			if(2) src.add_overlay("pai-cat")
			if(3) src.add_overlay("pai-extremely-happy")
			if(4) src.add_overlay("pai-face")
			if(5) src.add_overlay("pai-laugh")
			if(6) src.add_overlay("pai-off")
			if(7) src.add_overlay("pai-sad")
			if(8) src.add_overlay("pai-angry")
			if(9) src.add_overlay("pai-what")
			if(10) src.add_overlay("pai-neutral")
			if(11) src.add_overlay("pai-silly")
			if(12) src.add_overlay("pai-nose")
			if(13) src.add_overlay("pai-smirk")
			if(14) src.add_overlay("pai-exclamation")
			if(15) src.add_overlay("pai-question")
		current_emotion = emotion

/obj/item/device/paicard/proc/alertUpdate()
	var/turf/T = get_turf_or_move(src.loc)
	for (var/mob/M in viewers(T))
		M.show_message(SPAN_NOTICE("\The [src] flashes a message across its screen, \"Additional personalities available for download.\""), 3, SPAN_NOTICE("\The [src] bleeps electronically."), 2)

/obj/item/device/paicard/emp_act(severity)
	for(var/mob/M in src)
		M.emp_act(severity)

/obj/item/device/paicard/ex_act(severity)
	if(pai)
		pai.ex_act(severity)
	else
		qdel(src)

/obj/item/device/paicard/see_emote(mob/living/M, text)
	if(pai && pai.client && pai.stat == CONSCIOUS)
		var/rendered = SPAN_CLASS("message","[text]")
		pai.show_message(rendered, 2)
	..()

/obj/item/device/paicard/show_message(msg, type, alt, alt_type)
	if(pai && pai.client)
		var/rendered = SPAN_CLASS("message","[msg]")
		pai.show_message(rendered, type)
	..()
