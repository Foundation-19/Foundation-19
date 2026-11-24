/mob/living/bot/medbot
	name = "Medibot"
	desc = "A little medical robot. He looks somewhat underwhelmed."
	icon = 'icons/mob/bot/medibot.dmi'
	icon_state = "medibot0"
	req_access = list(list(ACCESS_MEDICAL, ACCESS_ROBOTICS))
	botcard_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CHEMISTRY, ACCESS_VIROLOGY)
	var/skin = null //Set to "tox", "ointment" or "o2" for the other two firstaid kits.

	//AI vars
	var/last_newpatient_speak = 0
	var/vocal = 1

	//Healing vars
	var/obj/item/reagent_containers/glass/reagent_glass = null //Can be set to draw from this for reagents.
	var/injection_amount = 15 //How much reagent do we inject at a time?
	var/heal_threshold = 10 //Start healing when they have this much damage in a category
	var/use_beaker = 0 //Use reagents in beaker instead of default treatment agents.
	var/treatment_brute = /datum/reagent/medicine/tricordrazine
	var/treatment_oxy = /datum/reagent/medicine/tricordrazine
	var/treatment_fire = /datum/reagent/medicine/tricordrazine
	var/treatment_tox = /datum/reagent/medicine/tricordrazine
	var/treatment_emag = /datum/reagent/toxin
	var/declare_treatment = 0 //When attempting to treat a patient, should it notify everyone wearing medhuds?

/mob/living/bot/medbot/handleIdle()
	if(vocal && prob(1))
		var/message = pick("Radar, put a mask on!", "There's always a catch, and it's the best there is.", "I knew it, I should've been a plastic surgeon.", "What kind of infirmary is this? Everyone's dropping like dead flies.", "Delicious!")
		say(message)

/mob/living/bot/medbot/handleAdjacentTarget()
	UnarmedAttack(target)

/mob/living/bot/medbot/lookForTargets()
	for(var/mob/living/carbon/human/H in view(7, src)) // Time to find a patient!
		if(confirmTarget(H))
			target = H
			if(last_newpatient_speak + 300 < world.time)
				var/message = pick("Hey, [H.name]! Hold on, I'm coming.", "Wait [H.name]! I want to help!", "[H.name], you appear to be injured!")
				say(message)
				custom_emote(1, "points at [H.name].")
				last_newpatient_speak = world.time
			break

/mob/living/bot/medbot/UnarmedAttack(mob/living/carbon/human/H, proximity)
	if(!..())
		return

	if(!on)
		return

	if(!istype(H))
		return

	if(busy)
		return

	if(H.stat == DEAD)
		var/death_message = pick("No! NO!", "Live, damnit! LIVE!", "I... I've never lost a patient before. Not today, I mean.")
		say(death_message)
		target = null
		return

	var/t = confirmTarget(H)
	if(!t)
		var/message = pick("All patched up!", "An apple a day keeps me away.", "Feel better soon!")
		say(message)
		target = null
		return

	icon_state = "medibots"
	visible_message(SPAN_WARNING("[src] is trying to inject [H]!"))
	if(declare_treatment)
		var/area/location = get_area(src)
		broadcast_medical_hud_message("[src] is treating <b>[H]</b> in <b>[location]</b>", src)
	busy = 1
	update_icons()
	if(do_after(src, 4 SECONDS, H, bonus_percentage = 25))
		if(t == 1)
			reagent_glass.reagents.trans_to_mob(H, injection_amount, CHEM_BLOOD)
		else
			H.reagents.add_reagent(t, injection_amount)
		visible_message(SPAN_WARNING("[src] injects [H] with the syringe!"))
	busy = 0
	update_icons()

/mob/living/bot/medbot/update_icons()
	cut_overlays()
	if(skin)
		add_overlay(image('icons/mob/bot/medibot_skins.dmi', "medskin_[skin]"))
	if(busy)
		icon_state = "medibots"
	else
		icon_state = "medibot[on]"

/mob/living/bot/medbot/attackby(obj/item/O, mob/user)
	if(istype(O, /obj/item/reagent_containers/glass))
		if(locked)
			to_chat(user, SPAN_NOTICE("You cannot insert a beaker because the panel is locked."))
			return
		if(!isnull(reagent_glass))
			to_chat(user, SPAN_NOTICE("There is already a beaker loaded."))
			return

		if(!user.unEquip(O, src))
			return
		reagent_glass = O
		to_chat(user, SPAN_NOTICE("You insert [O]."))
		return
	else
		..()

/mob/living/bot/medbot/GetInteractTitle()
	return "Automatic Medical Unit v1.0"

/mob/living/bot/medbot/get_status_data(mob/user)
	. = ..()
	.["info"] += list(list("label" = "Beaker", "value" = reagent_glass ? "Loaded \[[reagent_glass.reagents.total_volume]/[reagent_glass.reagents.maximum_volume]\]" : "None loaded"))
	if(reagent_glass)
		.["buttons"] = list(list("action" = "eject", "label" = "Eject beaker"))
	return

/mob/living/bot/medbot/get_panel_data(mob/user)
	. = list()
	.["info"] = list(
		list("label" = "Healing threshold", "value" = heal_threshold),
		list("label" = "Injection level", "value" = injection_amount),
	)
	.["buttons"] = list(
		list("action" = "adj_threshold", "label" = "--", "params" = list("amount" = -10)),
		list("action" = "adj_threshold", "label" = "-", "params" = list("amount" = -5)),
		list("action" = "adj_threshold", "label" = "+", "params" = list("amount" = 5)),
		list("action" = "adj_threshold", "label" = "++", "params" = list("amount" = 10)),
		list("action" = "adj_inject", "label" = "-", "params" = list("amount" = -5)),
		list("action" = "adj_inject", "label" = "+", "params" = list("amount" = 5)),
	)
	.["toggles"] = list(
		list("action" = "use_beaker", "label" = "Reagent source", "value" = use_beaker, "value_text" = use_beaker ? "Loaded Beaker (When available)" : "Internal Synthesizer"),
		list("action" = "declaretreatment", "label" = "Treatment report", "value" = declare_treatment),
		list("action" = "togglevoice", "label" = "Speaker", "value" = vocal),
	)
	return

/mob/living/bot/medbot/get_maintenance_data(mob/user)
	. = list()
	if(emagged < 2)
		.["toggles"] = list(
			list("action" = "emag", "label" = "Injection mode", "value" = emagged, "value_text" = emagged ? "Random (DANGER)" : "Treatment"),
		)
	else
		.["info"] = list(
			list("label" = "Injection mode", "value" = "ERROROROROROR-----"),
		)
	return

/mob/living/bot/medbot/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(CanAccessPanel(usr))
		switch(action)
			if("adj_threshold")
				var/threshold_num = params["amount"]
				if(!isnum(threshold_num))
					threshold_num = text2num("[threshold_num]")
				if(isnum(threshold_num))
					heal_threshold = Clamp(heal_threshold + threshold_num, 5, 75)
				return TRUE
			if("adj_inject")
				var/inject_num = params["amount"]
				if(!isnum(inject_num))
					inject_num = text2num("[inject_num]")
				if(isnum(inject_num))
					injection_amount = Clamp(injection_amount + inject_num, 5, 15)
				return TRUE
			if("use_beaker")
				use_beaker = !use_beaker
				return TRUE
			if("eject")
				if(reagent_glass)
					if(!locked)
						reagent_glass.dropInto(src.loc)
						reagent_glass = null
					else
						to_chat(usr, SPAN_NOTICE("You cannot eject the beaker because the panel is locked."))
				return TRUE
			if("togglevoice")
				vocal = !vocal
				return TRUE
			if("declaretreatment")
				declare_treatment = !declare_treatment
				return TRUE
	if(CanAccessMaintenance(usr))
		switch(action)
			if("emag")
				if(emagged < 2)
					emagged = !emagged
				return TRUE
	return FALSE

/mob/living/bot/medbot/emag_act(remaining_uses, mob/user)
	. = ..()
	if(!emagged)
		if(user)
			to_chat(user, SPAN_WARNING("You short out [src]'s reagent synthesis circuits."))
			ignore_list |= user
		visible_message(SPAN_WARNING("[src] buzzes oddly!"))
		flick("medibot_spark", src)
		target = null
		busy = 0
		emagged = TRUE
		on = 1
		update_icons()
		. = 1

/mob/living/bot/medbot/explode()
	on = 0
	visible_message(SPAN_DANGER("[src] blows apart!"))
	var/turf/Tsec = get_turf(src)

	new /obj/item/storage/firstaid(Tsec)
	new /obj/item/device/assembly/prox_sensor(Tsec)
	new /obj/item/device/scanner/health(Tsec)
	if (prob(50))
		new /obj/item/robot_parts/l_arm(Tsec)

	if(reagent_glass)
		reagent_glass.forceMove(Tsec)
		reagent_glass = null

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	qdel(src)
	return

/mob/living/bot/medbot/confirmTarget(mob/living/carbon/human/H)
	if(!..())
		return 0

	if(H.stat == DEAD) // He's dead, Jim
		return 0

	if(emagged)
		return treatment_emag

	// If they're injured, we're using a beaker, and they don't have on of the chems in the beaker
	if(reagent_glass && use_beaker && ((H.getBruteLoss() >= heal_threshold) || (H.getToxLoss() >= heal_threshold) || (H.getToxLoss() >= heal_threshold) || (H.getOxyLoss() >= (heal_threshold + 15))))
		for(var/datum/reagent/R in reagent_glass.reagents.reagent_list)
			if(!H.reagents.has_reagent(R))
				return 1
			continue

	if((H.getBruteLoss() >= heal_threshold) && (!H.reagents.has_reagent(treatment_brute)))
		return treatment_brute //If they're already medicated don't bother!

	if((H.getOxyLoss() >= (15 + heal_threshold)) && (!H.reagents.has_reagent(treatment_oxy)))
		return treatment_oxy

	if((H.getFireLoss() >= heal_threshold) && (!H.reagents.has_reagent(treatment_fire)))
		return treatment_fire

	if((H.getToxLoss() >= heal_threshold) && (!H.reagents.has_reagent(treatment_tox)))
		return treatment_tox
